using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace FireworkStand.PickleSteps
{
    /// <summary>
    /// What Pickle's own steps cannot say about a firework stand.
    ///
    /// Every step text starts with "Firework Stand:". Pickle loads the steps of every active suite
    /// into one namespace, and two suites declaring the same text make healthy scenarios fail with
    /// "Ambiguous step". No text uses parentheses or slashes, which Cucumber expressions read as
    /// optional text and alternatives: cells are spelled x=.. z=...
    ///
    /// WHY THERE IS AN ASSEMBLY AT ALL. The stand is a refuelable building whose comp fires only
    /// while a colonist watches it. No built-in step loads a refuelable, orders the watching job,
    /// reads a fuel gauge, reads whether a glower is lit, or asks who got which memory, and those
    /// are exactly the things TESTING.md asks a person to look at.
    ///
    /// NOTHING HERE REFERENCES THE MOD UNDER TEST OR FIREWORKS. The stand is found by its defName,
    /// its fuel through vanilla's CompRefuelable, its light through vanilla's CompGlower, the job
    /// by its defName, and the memories by the four ThoughtDef names Fireworks declares. A rename
    /// on either side then fails a scenario with the name it looked for, instead of failing to load
    /// the whole suite.
    ///
    /// EVERY WAITING STEP IS AN `async Task` THAT AWAITS. A `void` step that calls a method
    /// returning a Task and discards it never waits and never fails; Drum Bath Hygiene's suite went
    /// green over the wrong picture three runs in a row that way.
    /// </summary>
    [PickleSteps]
    public class FireworkStandSteps
    {
        public const string StandDef = "FS_FireworkStand";
        public const string WatchJob = "FS_WatchFireworks";

        /// <summary>The four memories Fireworks hands out, by the names the mod's bridge looks up.</summary>
        private static readonly string[] Memories =
        {
            "TerribleFireworks", "UnimpressiveFireworks", "BeautifulFireworks", "UnforgettableFireworks",
        };

        // ------------------------------------------------------------------ finding things

        private static Map CurrentMap(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null, "load a save first");
            return Find.CurrentMap;
        }

        private static Pawn PawnNamed(PickleContext ctx, string name)
        {
            IReadOnlyList<Pawn> spawned = CurrentMap(ctx).mapPawns.AllPawnsSpawned;
            Pawn found = spawned.FirstOrDefault(p =>
                (p.Name is NameTriple triple && triple.Nick == name)
                || (p.Name is NameSingle single && single.Name == name)
                || p.LabelShort == name);
            ctx.Assert(found != null,
                $"no spawned pawn named \"{name}\"; the map holds: "
                + string.Join(", ", spawned.Select(p => p.LabelShort)));
            return found;
        }

        private static Thing StandAt(PickleContext ctx, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");
            Thing stand = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == StandDef);
            ctx.Assert(stand != null,
                $"no {StandDef} at x={x} z={z}; the cell holds: "
                + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            return stand;
        }

        private static CompRefuelable FuelOf(PickleContext ctx, Thing stand)
        {
            CompRefuelable fuel = stand.TryGetComp<CompRefuelable>();
            ctx.Assert(fuel != null, "the stand carries no CompRefuelable, so it has no launchers to count");
            return fuel;
        }

        private static CompGlower GlowerOf(PickleContext ctx, Thing stand)
        {
            CompGlower glower = stand.TryGetComp<CompGlower>();
            ctx.Assert(glower != null, "the stand carries no CompGlower, so it has no light to read");
            return glower;
        }

        private static int Held(CompRefuelable fuel) => (int)Math.Round(fuel.Fuel);

        // ------------------------------------------------------------------ the fixture

        /// <summary>
        /// Exactly N launchers, whatever the stand held before. Empty first, then filled, so the
        /// step means "holds N" and not "holds at least N".
        /// </summary>
        [Given("Firework Stand: the stand at x={int} z={int} is loaded with {int} launchers")]
        public void Load(PickleContext ctx, int x, int z, int count)
        {
            CompRefuelable fuel = FuelOf(ctx, StandAt(ctx, x, z));
            ctx.Require(count >= 0 && count <= fuel.Props.fuelCapacity,
                $"{count} launchers do not fit: the stand takes {fuel.Props.fuelCapacity}");
            if (fuel.Fuel > 0f) fuel.ConsumeFuel(fuel.Fuel);
            if (count > 0) fuel.Refuel(count);
            ctx.Assert(Held(fuel) == count, $"the stand holds {fuel.Fuel} after being loaded with {count}");
        }

        /// <summary>
        /// Joy pulled low. A test colonist arrives with a full joy bar, and the watching job ends
        /// through JoyUtility.JoyTickCheckEnd the moment it is full, so a watcher who is not bored
        /// leaves before the first salvo. The same trap ended every real bath in the Drum Bath
        /// Hygiene suite.
        /// </summary>
        [Given("Firework Stand: {string} is bored")]
        public void Bored(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Need joy = pawn.needs?.AllNeeds.FirstOrDefault(n => n.def.defName == "Joy");
            ctx.Require(joy != null, $"{name} has no Joy need");
            joy.CurLevelPercentage = 0.05f;
        }

        /// <summary>
        /// Placed, not walked: a scenario that walked every subject into position would be testing
        /// pathing. Used for the audience of the memory, never for the watcher.
        /// </summary>
        [Given("Firework Stand: {string} is placed at x={int} z={int}")]
        public void Place(PickleContext ctx, string name, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Pawn pawn = PawnNamed(ctx, name);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");
            pawn.Position = cell;
            pawn.Notify_Teleported();
            ctx.Assert(pawn.Position == cell, $"{name} is at ({pawn.Position.x},{pawn.Position.z}) after being placed");
        }

        /// <summary>A constructed roof over a rectangle, the way a room's ceiling reads to the game.</summary>
        [Given("Firework Stand: the cells from x={int} z={int} to x={int} z={int} are roofed")]
        public void Roof(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            for (int x = Math.Min(x1, x2); x <= Math.Max(x1, x2); x++)
            {
                for (int z = Math.Min(z1, z2); z <= Math.Max(z1, z2); z++)
                {
                    var cell = new IntVec3(x, 0, z);
                    ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");
                    map.roofGrid.SetRoof(cell, RoofDefOf.RoofConstructed);
                }
            }
            ctx.Assert(new IntVec3(x1, 0, z1).Roofed(map), $"x={x1} z={z1} is still open to the sky after being roofed");
        }

        /// <summary>
        /// A colonist held where they are for the length of a scenario, so a pawn that stands for
        /// "awake, indoors" or "awake, outdoors" is not wandering somewhere else when the salvo goes
        /// off. The real Wait job, taken as an order.
        /// </summary>
        [Given("Firework Stand: {string} is told to stay where they stand")]
        public void Stay(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Job job = JobMaker.MakeJob(JobDefOf.Wait, 9000);
            job.expiryInterval = 9000;
            bool taken = pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc);
            ctx.Assert(taken, $"{name} refused the order to wait. Current job: {pawn.CurJob?.def.defName ?? "none"}");
        }

        /// <summary>
        /// Selects the stand by where it stands, not by its label: a label is translated, and this
        /// suite must run unchanged in English and in French. Opens the inspect pane as a click on
        /// the building would.
        /// </summary>
        [When("Firework Stand: I select the stand at x={int} z={int}")]
        public void SelectStand(PickleContext ctx, int x, int z)
        {
            Thing stand = StandAt(ctx, x, z);
            Find.Selector.ClearSelection();
            Find.Selector.Select(stand, false, false);
            Find.MainTabsRoot.SetCurrentTab(MainButtonDefOf.Inspect, false);
            ctx.Assert(Find.Selector.IsSelected(stand), "the stand is not selected after being selected");
        }

        [Given("Firework Stand: a bed stands at x={int} z={int}")]
        public void Bed(PickleContext ctx, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"x={x} z={z} is off the map");
            Thing bed = ThingMaker.MakeThing(ThingDefOf.Bed, ThingDefOf.WoodLog);
            GenSpawn.Spawn(bed, cell, map, Rot4.North);
            ctx.Assert(bed.Spawned, $"the bed did not spawn at x={x} z={z}");
        }

        /// <summary>
        /// The real LayDown job with forceSleep, so the pawn walks to the bed and falls asleep
        /// whatever the hour and however rested. Asleep means the job driver says so, which is what
        /// Pawn.Awake reads and what the stand's audience filter reads.
        /// </summary>
        [When("Firework Stand: {string} is ordered to sleep in the bed at x={int} z={int}")]
        public void OrderSleep(PickleContext ctx, string name, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Pawn pawn = PawnNamed(ctx, name);
            Thing bed = new IntVec3(x, 0, z).GetThingList(map).FirstOrDefault(t => t is Building_Bed);
            ctx.Assert(bed != null, $"no bed at x={x} z={z}");
            Job job = JobMaker.MakeJob(JobDefOf.LayDown, bed);
            job.forceSleep = true;
            bool taken = pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc);
            ctx.Assert(taken, $"{name} refused the order to sleep. Current job: {pawn.CurJob?.def.defName ?? "none"}");
        }

        [Then("Firework Stand: {string} is asleep")]
        public async Task IsAsleep(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            try { await ctx.WaitUntil(() => !pawn.Awake(), 60f); }
            catch (Exception) { /* reported below, with evidence */ }
            ctx.Assert(!pawn.Awake(),
                $"{name} is awake. Job {pawn.CurJob?.def.defName ?? "none"} "
                + $"(driver {pawn.jobs?.curDriver?.GetType().Name ?? "none"}), at ({pawn.Position.x},{pawn.Position.z}).");
        }

        // ------------------------------------------------------------------ the watching

        /// <summary>
        /// The REAL watching job, ordered as the joy giver would make it: the same best watch cell
        /// the giver would pick, no chair, the mod's own JobDef. The mod's driver then walks the
        /// pawn there and reports to the stand on every tick. Nothing is called on the stand
        /// directly, so a broken driver graft fails here and not in a step that bypassed it.
        /// </summary>
        [When("Firework Stand: {string} is ordered to watch the stand at x={int} z={int}")]
        public void OrderWatch(PickleContext ctx, string name, int x, int z)
        {
            Thing stand = StandAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            JobDef def = DefDatabase<JobDef>.GetNamedSilentFail(WatchJob);
            ctx.Assert(def != null, $"no JobDef \"{WatchJob}\": the stand's guarded patch did not apply");
            bool found = WatchBuildingUtility.TryFindBestWatchCell(stand, pawn, false, out IntVec3 cell, out Building chair);
            ctx.Assert(found, $"no cell from which {name} can watch the stand at x={x} z={z}");
            Job job = JobMaker.MakeJob(def, stand, cell, chair);
            bool taken = pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc);
            ctx.Assert(taken, $"{name} refused the order to watch. Current job: {pawn.CurJob?.def.defName ?? "none"}");
        }

        private static bool Watching(Pawn pawn, Thing stand)
            => pawn.CurJob != null
               && pawn.CurJob.def.defName == WatchJob
               && pawn.CurJob.targetA.Thing == stand
               && pawn.CurJob.targetB.IsValid
               && pawn.Position == pawn.CurJob.targetB.Cell;

        /// <summary>
        /// Arrived and watching: the job is the mod's, aimed at this stand, and the pawn stands on
        /// the watch cell rather than walking toward it. A trace of every change of job is kept,
        /// because a timeout alone says nothing about whether the colonist never set off or was
        /// sent elsewhere.
        /// </summary>
        [Then("Firework Stand: {string} is watching the stand at x={int} z={int}")]
        public async Task IsWatching(PickleContext ctx, string name, int x, int z)
        {
            Thing stand = StandAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            var trace = new List<string>();
            string last = null;
            float t0 = UnityEngine.Time.realtimeSinceStartup;
            bool Sample()
            {
                string now = pawn.CurJob?.def.defName ?? "none";
                if (now != last)
                {
                    trace.Add($"+{UnityEngine.Time.realtimeSinceStartup - t0:0.0}s {now} at ({pawn.Position.x},{pawn.Position.z})");
                    last = now;
                }
                return Watching(pawn, stand);
            }

            try { await ctx.WaitUntil(Sample, 90f); }
            catch (Exception) { /* reported below, with evidence */ }

            ctx.Assert(Watching(pawn, stand),
                $"{name} is not watching the stand at x={x} z={z}. Now: job {pawn.CurJob?.def.defName ?? "none"} "
                + $"(driver {pawn.jobs?.curDriver?.GetType().Name ?? "none"}), at ({pawn.Position.x},{pawn.Position.z}), "
                + $"stand at ({stand.Position.x},{stand.Position.z}), drafted {pawn.Drafted}, downed {pawn.Downed}. "
                + "Job trace: " + (trace.Count == 0 ? "(nothing sampled)" : string.Join(" | ", trace)));
        }

        /// <summary>
        /// The two claims about where they stand: 4 to 12 cells from the stand, and on their feet
        /// with no chair. Read off the running job, so it asserts what the driver was given.
        /// </summary>
        [Then("Firework Stand: {string} stands between {int} and {int} cells from the stand at x={int} z={int}, with no chair")]
        public void StandsBack(PickleContext ctx, string name, int min, int max, int x, int z)
        {
            Thing stand = StandAt(ctx, x, z);
            Pawn pawn = PawnNamed(ctx, name);
            float distance = pawn.Position.DistanceTo(stand.Position);
            ctx.Assert(distance >= min && distance <= max,
                $"{name} stands {distance:0.0} cells from the stand, outside {min} to {max}");
            LocalTargetInfo chair = pawn.CurJob?.targetC ?? LocalTargetInfo.Invalid;
            ctx.Assert(!chair.HasThing,
                $"{name} watches from a chair: {chair.Thing?.def.defName}. desireSit should be false.");
        }

        [Then("Firework Stand: {string} does not watch any stand")]
        public void DoesNotWatch(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(pawn.CurJob == null || pawn.CurJob.def.defName != WatchJob,
                $"{name} is watching a stand: job {pawn.CurJob?.def.defName}, target "
                + $"{pawn.CurJob?.targetA.Thing?.def.defName} at ({pawn.CurJob?.targetA.Cell.x},{pawn.CurJob?.targetA.Cell.z})");
        }

        // ------------------------------------------------------------------ the launchers

        [Then("Firework Stand: the stand at x={int} z={int} holds {int} launchers")]
        public void Holds(PickleContext ctx, int x, int z, int count)
        {
            CompRefuelable fuel = FuelOf(ctx, StandAt(ctx, x, z));
            ctx.Assert(Held(fuel) == count, $"the stand holds {fuel.Fuel} launchers, not {count}");
        }

        /// <summary>Waits for a salvo to have been spent: one launcher per salvo, so the count is the salvo counter.</summary>
        [Then("Firework Stand: the stand at x={int} z={int} comes to hold {int} launchers within {int} seconds")]
        public async Task ComesToHold(PickleContext ctx, int x, int z, int count, int seconds)
        {
            CompRefuelable fuel = FuelOf(ctx, StandAt(ctx, x, z));
            try { await ctx.WaitUntil(() => Held(fuel) == count, seconds); }
            catch (Exception) { /* reported below, with evidence */ }
            ctx.Assert(Held(fuel) == count, $"after {seconds} s the stand holds {fuel.Fuel} launchers, not {count}");
        }

        // ------------------------------------------------------------------ the light

        [Then("Firework Stand: the light of the stand at x={int} z={int} is off")]
        public void LightOff(PickleContext ctx, int x, int z)
        {
            ctx.Assert(!GlowerOf(ctx, StandAt(ctx, x, z)).Glows, "the stand's light is on, and should be off");
        }

        [Then("Firework Stand: the light of the stand at x={int} z={int} comes on within {int} seconds")]
        public async Task LightComesOn(PickleContext ctx, int x, int z, int seconds)
        {
            CompGlower glower = GlowerOf(ctx, StandAt(ctx, x, z));
            try { await ctx.WaitUntil(() => glower.Glows, seconds); }
            catch (Exception) { /* reported below, with evidence */ }
            ctx.Assert(glower.Glows, $"after {seconds} s the stand's light never came on");
        }

        [Then("Firework Stand: the light of the stand at x={int} z={int} goes off within {int} seconds")]
        public async Task LightGoesOff(PickleContext ctx, int x, int z, int seconds)
        {
            CompGlower glower = GlowerOf(ctx, StandAt(ctx, x, z));
            try { await ctx.WaitUntil(() => !glower.Glows, seconds); }
            catch (Exception) { /* reported below, with evidence */ }
            ctx.Assert(!glower.Glows, $"after {seconds} s the stand's light is still on");
        }

        // ------------------------------------------------------------------ the memory

        private static List<string> MemoriesOf(Pawn pawn)
            => pawn.needs?.mood?.thoughts?.memories?.Memories
                .Select(m => m.def.defName).Where(n => Memories.Contains(n)).ToList()
               ?? new List<string>();

        [Then("Firework Stand: {string} has a fireworks memory")]
        public void HasMemory(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(MemoriesOf(pawn).Count > 0,
                $"{name} has no fireworks memory. Awake {pawn.Awake()}, roofed {pawn.Position.Roofed(pawn.Map)}, "
                + $"at ({pawn.Position.x},{pawn.Position.z}). Memories: "
                + string.Join(", ", pawn.needs?.mood?.thoughts?.memories?.Memories.Select(m => m.def.defName) ?? new string[0]));
        }

        [Then("Firework Stand: {string} has no fireworks memory")]
        public void HasNoMemory(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            List<string> held = MemoriesOf(pawn);
            ctx.Assert(held.Count == 0,
                $"{name} has a fireworks memory ({string.Join(", ", held)}). Awake {pawn.Awake()}, "
                + $"roofed {pawn.Position.Roofed(pawn.Map)}, at ({pawn.Position.x},{pawn.Position.z}).");
        }
    }
}
