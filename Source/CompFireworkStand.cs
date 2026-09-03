using RimWorld;
using UnityEngine;
using Verse;

namespace FireworkStand
{
    public class CompProperties_FireworkStand : CompProperties
    {
        /// <summary>Ticks between two salvoes while a colonist is watching. 900 = a quarter hour.</summary>
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

        public override void CompTickInterval(int delta)
        {
            base.CompTickInterval(delta);

            if (!parent.Spawned) return;
            var map = parent.Map;
            if (map == null) return;

            var now = Find.TickManager.TicksGame;
            var sinceShot = now - lastShotTick;

            // 1. The fuse is burning: a thread of smoke at the foot of the stand.
            if (!departed && sinceShot >= 0 && sinceShot < Props.launchDelay)
            {
                // `% interval < delta` and not `% interval == 0`: in 1.6 the game can skip several
                // ticks at once, and an equality test would miss the window outright.
                if (Props.smokeInterval > 0 && now % Props.smokeInterval < delta)
                {
                    FleckMaker.ThrowSmoke(parent.DrawPos, map, 0.7f);
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
                pawn.needs?.mood?.thoughts?.memories?.TryGainMemory(def);
            }
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
