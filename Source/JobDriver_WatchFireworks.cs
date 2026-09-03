using RimWorld;
using Verse;

namespace FireworkStand
{
    /// <summary>
    /// The base game's "watch a building" driver, plus one line: tell the stand it is being
    /// watched.
    ///
    /// <c>JobDriver_WatchBuilding.WatchTickAction</c> is <c>protected virtual</c> - that is what
    /// makes this graft possible without a Harmony patch. Everything else is inherited: walking to
    /// the watch cell, facing the building, gaining comfort, accumulating joy, ending when the bar
    /// is full, and doing it from a bed if it has to.
    /// </summary>
    public class JobDriver_WatchFireworks : JobDriver_WatchBuilding
    {
        // public and not protected: Krafs.Publicizer exposes the member as public in the reference
        // assembly, and C# forbids narrowing accessibility when overriding.
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
