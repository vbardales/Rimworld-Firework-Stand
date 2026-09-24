using RimWorld;
using Verse;
using Verse.AI;

namespace FireworkStand
{
    /// <summary>
    /// The base game's "watch a building" driver, plus two lines: tell the stand it is being
    /// watched, and stop when there is nothing left to watch.
    ///
    /// <c>JobDriver_WatchBuilding.WatchTickAction</c> is <c>protected virtual</c> - that is what
    /// makes this graft possible without a Harmony patch. Everything else is inherited: walking to
    /// the watch cell, facing the building, gaining comfort, accumulating joy, ending when the bar
    /// is full, and doing it from a bed if it has to.
    ///
    /// The joy tick is vanilla's and does not ask the stand, so without the second line a colonist
    /// would go on gaining recreation in front of an empty stand. The job ends once the last rocket
    /// has left and its burst has had time to fade (<see cref="CompFireworkStand.ShowIsOn"/>).
    /// </summary>
    public class JobDriver_WatchFireworks : JobDriver_WatchBuilding
    {
        // public and not protected: Krafs.Publicizer exposes the member as public in the reference
        // assembly, and C# forbids narrowing accessibility when overriding.
        public override void WatchTickAction(int delta)
        {
            var stand = TargetA.Thing as ThingWithComps;
            var comp = stand?.GetComp<CompFireworkStand>();

            if (comp != null && !comp.ShowIsOn())
            {
                EndJobWith(JobCondition.Succeeded);
                return;
            }

            base.WatchTickAction(delta);

            comp?.Notify_Watched();
        }
    }
}
