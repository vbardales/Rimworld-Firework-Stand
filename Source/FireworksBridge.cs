using System;
using System.Reflection;
using RimWorld;
using Verse;

namespace FireworkStand
{
    /// <summary>
    /// Pont vers le mod Fireworks de telardo, entierement par reflexion.
    ///
    /// Pourquoi pas une reference directe : notre assembly doit se charger meme si le mod
    /// d'origine est absent. Une reference dure ferait echouer le chargement du type entier.
    ///
    /// Ce qu'on lui emprunte est deliberement minimal - une methode et un champ :
    ///   <c>CompLaunchFireworks.Launch(int delayTick)</c> tire une salve. Verifie par
    ///   decompilation : elle ne lit que <c>parent.DrawPos</c> et <c>parent.Map</c>, enregistre
    ///   la salve aupres du MapComponent du mod, et **ne detruit pas son porteur**. Rien n'y
    ///   suppose que le porteur soit l'objet consommable d'origine : un batiment fait l'affaire.
    ///   <c>CompLaunchFireworks.launched</c> est un champ public que la methode met a vrai pour
    ///   ne tirer qu'une fois. Le remettre a faux rearme le composant - c'est ce qui transforme
    ///   un lance-feux a usage unique en rampe reutilisable.
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
        /// Rearme le composant et tire une salve. Renvoie faux si le mod n'est pas la, ou si le
        /// batiment ne porte pas le composant - auquel cas il n'y a rien a faire et rien a dire.
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
