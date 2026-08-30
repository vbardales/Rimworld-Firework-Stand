using RimWorld;
using Verse;

namespace FireworkStand
{
    /// <summary>
    /// Le pilote « regarder un batiment » du jeu de base, plus une ligne : prevenir la rampe
    /// qu'on la regarde.
    ///
    /// <c>JobDriver_WatchBuilding.WatchTickAction</c> est <c>protected virtual</c> - c'est ce qui
    /// rend cette greffe possible sans patch Harmony. Tout le reste est herite : aller a la case
    /// d'observation, faire face au batiment, gagner du confort, accumuler la joie, terminer
    /// quand la barre est pleine, et le faire depuis un lit s'il le faut.
    /// </summary>
    public class JobDriver_WatchFireworks : JobDriver_WatchBuilding
    {
        // public et non protected : Krafs.Publicizer expose le membre en public dans l'assembly
        // de reference, et C# interdit de restreindre l'accessibilite en redefinissant.
        public override void WatchTickAction(int delta)
        {
            base.WatchTickAction(delta);

            if (TargetA.Thing is ThingWithComps stand)
            {
                stand.GetComp<CompFireworkStand>()?.Notify_Watched();
            }
        }
    }
}
