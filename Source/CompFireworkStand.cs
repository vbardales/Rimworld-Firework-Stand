using System.Collections.Generic;
using RimWorld;
using UnityEngine;
using Verse;

namespace FireworkStand
{
    public class CompProperties_FireworkStand : CompProperties
    {
        /// <summary>Ticks entre deux salves tant qu'un colon regarde. 900 = un quart d'heure.</summary>
        public int shotInterval = 900;

        /// <summary>Delai avant que la salve ne parte, pour laisser au colon le temps de lever la tete.</summary>
        public int launchDelay = 60;

        /// <summary>Portee du souvenir laisse par une salve, en cases.</summary>
        public float moodRadius = 20f;

        public CompProperties_FireworkStand()
        {
            compClass = typeof(CompFireworkStand);
        }
    }

    /// <summary>
    /// Fait tirer la rampe pendant qu'un colon la regarde, et distribue le souvenir.
    ///
    /// POURQUOI DECLENCHER DEPUIS LE REGARD. Une rampe qui tire toute seule sur minuterie
    /// gaspillerait ses munitions la nuit, sous la pluie, et quand personne ne regarde. Ici c'est
    /// le pilote de la tache qui previent a chaque tick : pas de salve sans spectateur, et la
    /// consommation suit exactement l'usage.
    ///
    /// Le tir lui-meme est delegue au mod d'origine via <see cref="FireworksBridge"/> : on ne
    /// reimplemente ni les gerbes, ni les trainees, ni les sous-emetteurs, ni les sons.
    /// </summary>
    public class CompFireworkStand : ThingComp
    {
        private int lastShotTick = -99999;

        private CompProperties_FireworkStand Props => (CompProperties_FireworkStand)props;
        private CompRefuelable Fuel => parent.GetComp<CompRefuelable>();

        /// <summary>Appele a chaque tick par le pilote, tant qu'un colon regarde.</summary>
        public void Notify_Watched()
        {
            if (!FireworksBridge.Available) return;
            if (!parent.Spawned) return;
            if (Find.TickManager.TicksGame - lastShotTick < Props.shotInterval) return;

            var fuel = Fuel;
            if (fuel == null || !fuel.HasFuel) return;

            // On consomme d'abord : si le tir echoue pour une raison quelconque, mieux vaut une
            // fusee perdue qu'une rampe qui tire indefiniment sans rien depenser.
            fuel.ConsumeFuel(1f);
            lastShotTick = Find.TickManager.TicksGame;

            if (FireworksBridge.Fire(parent as ThingWithComps, Props.launchDelay))
            {
                ApplyMemory();
            }
        }

        /// <summary>
        /// Reproduit la distribution de souvenirs du mod d'origine, dont la methode est privee.
        /// Memes probabilites et memes ThoughtDef : 5 % rate, 15 % quelconque, 70 % beau,
        /// 10 % inoubliable. La portee est plus large que la sienne, parce qu'on tire depuis une
        /// rampe fixe que la colonie entiere peut voir, et non depuis une fusee tenue a la main.
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
        }
    }
}
