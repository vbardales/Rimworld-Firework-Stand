using RimWorld;
using Verse;

namespace FireworkStand
{
    /// <summary>
    /// The base game's "watch a building" joy giver, refusing a stand with nothing loaded.
    ///
    /// <c>JoyGiver_WatchBuilding</c> and <c>JoyGiver_InteractBuilding</c> never look at fuel, and the
    /// watching driver's joy tick is vanilla's and does not ask the stand either, so an empty stand was
    /// offered as recreation and a colonist watching it gained the whole recreation without a rocket
    /// going up (read from the compiled game, 2026-09-21, and confirmed by the owner as not intended:
    /// an empty stand gives no recreation). Refusing it here keeps the colonist from walking over to
    /// nothing; <see cref="JobDriver_WatchFireworks"/> ends the job when the last rocket has gone.
    ///
    /// <c>CanInteractWith</c> is a protected virtual method, so this is an override and not a Harmony patch.
    /// </summary>
    public class JoyGiver_WatchFireworkStand : JoyGiver_WatchBuilding
    {
        // public and not protected: Krafs.Publicizer exposes the member as public in the reference
        // assembly, and C# forbids narrowing accessibility when overriding (the driver does the same).
        public override bool CanInteractWith(Pawn pawn, Thing t, bool inBed)
        {
            if (!base.CanInteractWith(pawn, t, inBed)) return false;

            var fuel = t.TryGetComp<CompRefuelable>();
            return fuel != null && fuel.HasFuel;
        }
    }
}
