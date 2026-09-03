using System;
using System.Reflection;
using RimWorld;
using Verse;

namespace FireworkStand
{
    /// <summary>
    /// Bridge to telardo's Fireworks mod, entirely through reflection.
    ///
    /// Why not a direct reference: this assembly has to load even when the original mod is
    /// absent. A hard reference would fail the load of the whole type.
    ///
    /// What is borrowed is deliberately minimal - one method and one field:
    ///   <c>CompLaunchFireworks.Launch(int delayTick)</c> fires one salvo. Checked by
    ///   decompilation: it only reads <c>parent.DrawPos</c> and <c>parent.Map</c>, registers the
    ///   salvo with the mod's own MapComponent, and **does not destroy its holder**. Nothing in
    ///   it assumes the holder is the original single-use item: a building will do.
    ///   <c>CompLaunchFireworks.launched</c> is a public field the method sets to true so it only
    ///   fires once. Setting it back to false rearms the comp - that is what turns a single-use
    ///   launcher into a reusable stand.
    /// </summary>
    public static class FireworksBridge
    {
        private static bool resolved;
        private static bool available;

        private static Type compType;      // Fireworks.CompLaunchFireworks
        private static MethodInfo launch;  // .Launch(int)
        private static FieldInfo launched; // .launched

        public static ThoughtDef Terrible;
        public static ThoughtDef Unimpressive;
        public static ThoughtDef Beautiful;
        public static ThoughtDef Unforgettable;

        public static bool Available
        {
            get
            {
                Resolve();
                return available;
            }
        }

        private static void Resolve()
        {
            if (resolved) return;
            resolved = true;

            try
            {
                Assembly asm = null;
                foreach (var pack in LoadedModManager.RunningModsListForReading)
                {
                    foreach (var a in pack.assemblies.loadedAssemblies)
                    {
                        if (a.GetName().Name == "Fireworks") { asm = a; break; }
                    }
                    if (asm != null) break;
                }
                if (asm == null) return;

                compType = asm.GetType("Fireworks.CompLaunchFireworks");
                launch = compType?.GetMethod("Launch", BindingFlags.Public | BindingFlags.Instance);
                launched = compType?.GetField("launched", BindingFlags.Public | BindingFlags.Instance);

                available = compType != null && launch != null && launched != null;

                if (!available)
                {
                    Log.Warning("[Firework Stand] Fireworks found, but CompLaunchFireworks.Launch "
                              + "or its launched field could not be resolved. The stand will not fire.");
                }

                Terrible = DefDatabase<ThoughtDef>.GetNamedSilentFail("TerribleFireworks");
                Unimpressive = DefDatabase<ThoughtDef>.GetNamedSilentFail("UnimpressiveFireworks");
                Beautiful = DefDatabase<ThoughtDef>.GetNamedSilentFail("BeautifulFireworks");
                Unforgettable = DefDatabase<ThoughtDef>.GetNamedSilentFail("UnforgettableFireworks");
            }
            catch (Exception ex)
            {
                available = false;
                Log.Warning("[Firework Stand] could not bridge to Fireworks: " + ex.Message);
            }
        }

        /// <summary>
        /// Rearms the comp and fires one salvo. Returns false if the mod is not there, or if the
        /// building does not carry the comp - in which case there is nothing to do and nothing
        /// to report.
        /// </summary>
        public static bool Fire(ThingWithComps building, int delayTicks)
        {
            if (!Available || building == null) return false;

            try
            {
                var comp = building.AllComps.Find(c => compType.IsInstanceOfType(c));
                if (comp == null) return false;

                launched.SetValue(comp, false);
                launch.Invoke(comp, new object[] { delayTicks });
                return true;
            }
            catch (Exception ex)
            {
                Log.WarningOnce("[Firework Stand] Fire failed: " + ex.Message, 0x2F14A7);
                return false;
            }
        }
    }
}
