using RimWorld;
using UnityEngine;
using Verse;

namespace FireworkStand
{
    public class CompProperties_FireworkStand : CompProperties
    {
        /// <summary>
        /// Ticks between two salvoes while a colonist is watching. An in-game hour is 2500 ticks,
        /// so 900 is about twenty-two in-game minutes: a watching session of 4000 ticks sees four
        /// or five rockets go up.
        /// </summary>
        public int shotInterval = 900;

        /// <summary>Delay before the salvo leaves, to give the colonist time to look up.</summary>
        public int launchDelay = 60;

        /// <summary>Range of the memory a salvo leaves, in cells.</summary>
        public float moodRadius = 20f;

        /// <summary>How long the real light thrown on the ground lasts after the rocket leaves.</summary>
        public int flashTicks = 240;

        /// <summary>One puff of smoke every N ticks while the fuse burns.</summary>
        public int smokeInterval = 12;

        public CompProperties_FireworkStand()
        {
            compClass = typeof(CompFireworkStand);
        }
    }

    /// <summary>
    /// Makes the stand fire while a colonist watches it, hands out the memory, and provides the
    /// effects the original mod does not produce: the smoke at the foot of the stand and the light
    /// thrown across the ground.
    ///
    /// WHY FIRING IS DRIVEN BY THE WATCHING. A stand firing on its own timer would waste its
    /// rockets at night, in the rain, and when nobody is looking. Here the job driver tells it on
    /// every tick: no salvo without an audience, and consumption follows use exactly.
    ///
    /// The shot itself is delegated to the original mod through <see cref="FireworksBridge"/>: the
    /// bursts, the trails, the sub-emitters and the sounds are not reimplemented here.
    ///
    /// SOUND IS NOT OURS TO ADD, AND THAT IS CHECKED. `FireworkSpawner.TrySpawnFleck` already
    /// plays the `launchSound` carried by the FleckDef it rolls (`Fireworks_RocketLaunch` or
    /// `Fireworks_SmallRocketLaunch`), and every sub-emitter plays its `emitSound` as it bursts.
    /// Adding one here would only double what already plays.
    ///
    /// THE LIGHT IS A REAL LIGHT, not a glowing fleck. `CompGlower.ShouldBeLitNow` asks every comp
    /// on the building that implements <see cref="IThingGlower"/> and gives up as soon as one says
    /// no - that is the hook the game provides, and it consults neither fuel nor power. So this
    /// comp answers "yes" for the few seconds after the rocket leaves, and "no" the rest of the
    /// time: the stand lights the ground for the length of the burst instead of staying on like a
    /// lamp.
    /// </summary>
    public class CompFireworkStand : ThingComp, IThingGlower
    {
        private int lastShotTick = -99999;
        private int litUntilTick = -99999;
        private bool departed = true;
        private bool lit;

        private CompProperties_FireworkStand Props => (CompProperties_FireworkStand)props;
        private CompRefuelable Fuel => parent.GetComp<CompRefuelable>();
        private CompGlower Glower => parent.GetComp<CompGlower>();

        public bool ShouldBeLitNow() => lit;

        /// <summary>Called on every tick by the job driver, as long as a colonist is watching.</summary>
        public void Notify_Watched()
        {
            if (!FireworksBridge.Available) return;
            if (!parent.Spawned) return;
            if (Find.TickManager.TicksGame - lastShotTick < Props.shotInterval) return;

            var fuel = Fuel;
            if (fuel == null || !fuel.HasFuel) return;

            // Consume first: if the shot fails for any reason, one lost rocket is better than a
            // stand that fires forever without spending anything.
            fuel.ConsumeFuel(1f);
            lastShotTick = Find.TickManager.TicksGame;

            if (FireworksBridge.Fire(parent as ThingWithComps, Props.launchDelay))
            {
                // The fuse is lit: it will smoke until the rocket leaves, handled on tick.
                departed = false;
                ApplyMemory();
            }
        }

        /// <summary>
        /// True while the show is worth watching: launchers are loaded, or the last rocket was fired
        /// so recently that its fuse, its burst and its light are still going. Once it is over on an
        /// empty stand, nobody has anything left to watch and the watching job ends.
        /// </summary>
        public bool ShowIsOn()
        {
            var fuel = Fuel;
            if (fuel != null && fuel.HasFuel) return true;
            var sinceShot = Find.TickManager.TicksGame - lastShotTick;
            return sinceShot >= 0 && sinceShot < Props.launchDelay + Props.flashTicks + AfterglowTicks;
        }

        /// <summary>How long a watcher stays on after the last rocket has left: the burst still hangs in the sky.</summary>
        private const int AfterglowTicks = 180;

        /// <summary>
        /// The effects are timed in CompTick, which the game runs on EVERY tick, and not in
        /// CompTickInterval. For a building whose ticker is Normal the game calls CompTickInterval
        /// only every UpdateRateTicks ticks (Thing.DoTick: `tickDelta >= num || IsTickInterval(...)`),
        /// so a fuse that lasts sixty ticks and a puff every twelve fell between two calls: on the
        /// first full run of the Pickle suite the fuse smoke could not be seen at all, and the light
        /// went out late. `now % smokeInterval == 0` is safe here because the tick is never skipped.
        /// </summary>
        public override void CompTick()
        {
            base.CompTick();

            if (!parent.Spawned) return;
            var map = parent.Map;
            if (map == null) return;

            var now = Find.TickManager.TicksGame;
            var sinceShot = now - lastShotTick;

            // 1. The fuse is burning: a thread of smoke at the foot of the stand.
            if (!departed && sinceShot >= 0 && sinceShot < Props.launchDelay)
            {
                if (Props.smokeInterval > 0 && now % Props.smokeInterval == 0)
                {
                    ThrowFuseSmoke(map);
                }
            }

            // 2. The launch: thick puff, sparks, and the light comes on.
            if (!departed && sinceShot >= Props.launchDelay)
            {
                departed = true;
                litUntilTick = now + Props.flashTicks;

                FleckMaker.ThrowDustPuffThick(parent.DrawPos, map, 2.2f, new Color(0.85f, 0.85f, 0.85f, 0.6f));
                FleckMaker.ThrowSmoke(parent.DrawPos, map, 1.6f);
                FleckMaker.ThrowMicroSparks(parent.DrawPos, map);
                FleckMaker.ThrowLightningGlow(parent.DrawPos, map, 1.4f);

                SetLit(true, map);
            }

            // 3. Going dark again.
            if (lit && now >= litUntilTick)
            {
                SetLit(false, map);
            }
        }

        /// <summary>
        /// `UpdateLit` compares the wanted state to the current one and only adds or removes the
        /// glower from the light grid when they differ. So it is called at the two instants our
        /// answer changes, and never on every tick.
        /// </summary>
        private static FleckDef fuseSmokeDef;

        /// <summary>
        /// One puff of the fuse's smoke, at the foot of the stand. It is our own fleck (`FS_FuseSmoke`) and not
        /// FleckMaker.ThrowSmoke: the game's Smoke takes half a second to fade in and the fuse burns for one,
        /// so the thread never showed. The throw is otherwise ThrowSmoke's own: same drift, same spin, same
        /// range of sizes (scaled down, it is a thread and not the launch's cloud).
        /// </summary>
        private void ThrowFuseSmoke(Map map)
        {
            // From the top of the rack, not its middle: against the ground a puff shows, against the striped rockets it did not.
            Vector3 loc = parent.DrawPos + new Vector3(0f, 0f, 0.35f);
            if (!loc.ShouldSpawnMotesAt(map)) return;
            if (fuseSmokeDef == null) fuseSmokeDef = DefDatabase<FleckDef>.GetNamed("FS_FuseSmoke");
            FleckCreationData data = FleckMaker.GetDataStatic(loc, map, fuseSmokeDef, Rand.Range(1.5f, 2.25f));
            data.instanceColor = new Color(0.3f, 0.3f, 0.3f, 1f);
            data.rotationRate = Rand.Range(-30f, 30f);
            data.velocityAngle = Rand.Range(-12, 12);
            data.velocitySpeed = Rand.Range(1.0f, 1.4f);
            map.flecks.CreateFleck(data);
        }

        private void SetLit(bool value, Map map)
        {
            if (lit == value) return;
            lit = value;
            Glower?.UpdateLit(map);
        }

        /// <summary>
        /// Reproduces the original mod's memory roll, whose method is private. Same odds and same
        /// ThoughtDefs: 5% a dud, 15% unimpressive, 70% beautiful, 10% unforgettable. The range is
        /// wider than its own, because this fires from a fixed stand the whole colony can see, not
        /// from a rocket held in one hand.
        ///
        /// WHO COUNTS AS HAVING SEEN IT. Range alone is not enough: it would hand "beautiful
        /// fireworks" to a colonist asleep in a bedroom twelve cells away, which is the opposite of
        /// what this mod claims to be about. The three filters below are the ones the defs already
        /// impose on the watcher, applied to the audience:
        ///   - awake, because a sleeping pawn sees nothing;
        ///   - under open sky, the same test `unroofedOnly` puts on the stand itself - a rocket
        ///     bursts overhead, so a roof between pawn and sky hides it;
        ///   - capable of sight, the same capacity the JoyGiverDef requires.
        /// No line-of-sight check on the ground: the burst is in the air, and a wall between the
        /// colonist and the stand does not hide it.
        /// </summary>
        private void ApplyMemory()
        {
            var def = PickOutcome();
            if (def == null) return;

            var map = parent.Map;
            if (map == null) return;

            foreach (var pawn in map.mapPawns.FreeColonists)
            {
                if (pawn.Position.DistanceTo(parent.Position) > Props.moodRadius) continue;
                if (!CanSeeTheShow(pawn, map)) continue;
                pawn.needs?.mood?.thoughts?.memories?.TryGainMemory(def);
            }
        }

        private static bool CanSeeTheShow(Pawn pawn, Map map)
        {
            if (pawn == null || !pawn.Spawned) return false;
            if (!pawn.Awake()) return false;
            if (pawn.Position.Roofed(map)) return false;
            return pawn.health != null
                && pawn.health.capacities.CapableOf(PawnCapacityDefOf.Sight);
        }

        private static ThoughtDef PickOutcome()
        {
            var roll = Rand.Value;
            if (roll <= 0.05f) return FireworksBridge.Terrible;
            if (roll <= 0.20f) return FireworksBridge.Unimpressive;
            if (roll <= 0.90f) return FireworksBridge.Beautiful;
            return FireworksBridge.Unforgettable;
        }

        public override string CompInspectStringExtra()
        {
            if (!FireworksBridge.Available) return null;

            // An empty stand is not "ready to fire": the reload interval says nothing when there is
            // nothing to fire, and the fuel gauge beside this line already says that nothing is loaded.
            var fuel = Fuel;
            if (fuel == null || !fuel.HasFuel) return null;

            var remaining = Props.shotInterval - (Find.TickManager.TicksGame - lastShotTick);
            if (remaining <= 0) return "FireworkStand.Ready".Translate();
            return "FireworkStand.Reloading".Translate(remaining.ToStringTicksToPeriod());
        }

        public override void PostExposeData()
        {
            base.PostExposeData();
            Scribe_Values.Look(ref lastShotTick, "lastShotTick", -99999);
            Scribe_Values.Look(ref litUntilTick, "litUntilTick", -99999);
            Scribe_Values.Look(ref departed, "departed", true);
            Scribe_Values.Look(ref lit, "lit", false);
        }
    }
}
