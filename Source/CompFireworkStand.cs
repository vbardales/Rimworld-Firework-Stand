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

        /// <summary>Duree de la lueur reelle projetee au sol apres le depart de la fusee.</summary>
        public int flashTicks = 240;

        /// <summary>Un flocon de fumee tous les N ticks pendant que la meche brule.</summary>
        public int smokeInterval = 12;

        public CompProperties_FireworkStand()
        {
            compClass = typeof(CompFireworkStand);
        }
    }

    /// <summary>
    /// Fait tirer la rampe pendant qu'un colon la regarde, distribue le souvenir, et fournit les
    /// effets que le mod d'origine ne produit pas : la fumee au pied de la rampe et la lumiere
    /// projetee au sol.
    ///
    /// POURQUOI DECLENCHER DEPUIS LE REGARD. Une rampe qui tire toute seule sur minuterie
    /// gaspillerait ses munitions la nuit, sous la pluie, et quand personne ne regarde. Ici c'est
    /// le pilote de la tache qui previent a chaque tick : pas de salve sans spectateur, et la
    /// consommation suit exactement l'usage.
    ///
    /// Le tir lui-meme est delegue au mod d'origine via <see cref="FireworksBridge"/> : on ne
    /// reimplemente ni les gerbes, ni les trainees, ni les sous-emetteurs, ni les sons.
    ///
    /// LE SON N'EST PAS DE NOTRE RESSORT, ET C'EST VERIFIE. `FireworkSpawner.TrySpawnFleck` joue
    /// deja le `launchSound` porte par le FleckDef tire au sort (`Fireworks_RocketLaunch` ou
    /// `Fireworks_SmallRocketLaunch`), et chaque sous-emetteur joue son `emitSound` a
    /// l'eclatement. En ajouter un ici ne ferait que doubler ce qui se joue deja.
    ///
    /// LA LUMIERE EST UNE VRAIE LUMIERE, pas un fleck lumineux. `CompGlower.ShouldBeLitNow`
    /// interroge tous les composants du batiment qui implementent <see cref="IThingGlower"/> et
    /// s'eteint des que l'un d'eux dit non - c'est le crochet prevu par le jeu, et il ne consulte
    /// ni carburant ni courant. Ce composant repond donc « oui » pendant les quelques secondes qui
    /// suivent le depart de la fusee, et « non » le reste du temps : la rampe illumine le sol le
    /// temps de la gerbe au lieu de rester allumee comme une lampe.
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
                // La meche est allumee : elle fumera jusqu'au depart, gere au tick.
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

            // 1. La meche brule : un filet de fumee au pied de la rampe.
            if (!departed && sinceShot >= 0 && sinceShot < Props.launchDelay)
            {
                // `% interval < delta` et non `% interval == 0` : en 1.6 le jeu peut sauter
                // plusieurs ticks d'un coup, un test d'egalite raterait purement et simplement
                // la fenetre.
                if (Props.smokeInterval > 0 && now % Props.smokeInterval < delta)
                {
                    FleckMaker.ThrowSmoke(parent.DrawPos, map, 0.7f);
                }
            }

            // 2. Le depart : bouffee epaisse, etincelles, et la lumiere s'allume.
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

            // 3. Extinction.
            if (lit && now >= litUntilTick)
            {
                SetLit(false, map);
            }
        }

        /// <summary>
        /// `UpdateLit` compare l'etat voulu a l'etat courant et n'inscrit ou ne retire le glower
        /// de la grille de lumiere que s'ils different. On ne l'appelle donc qu'aux deux instants
        /// ou notre reponse change, et jamais a chaque tick.
        /// </summary>
        private void SetLit(bool value, Map map)
        {
            if (lit == value) return;
            lit = value;
            Glower?.UpdateLit(map);
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
            Scribe_Values.Look(ref litUntilTick, "litUntilTick", -99999);
            Scribe_Values.Look(ref departed, "departed", true);
            Scribe_Values.Look(ref lit, "lit", false);
        }
    }
}
