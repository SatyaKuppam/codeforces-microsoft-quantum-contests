// https://codeforces.com/contest/1357/problem/C1
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;

    // From the super position kata
    // see post-selection
    operation superposition_without_11 (qs : Qubit[]) : Unit {
        using(ancilla = Qubit()) {
            repeat {
                ApplyToEach(H, qs);
                Controlled X(qs, ancilla);
                let result = MResetZ(ancilla);
            }
            until (result == Zero)
            fixup {
                ResetAll(qs);
            }
        }
    }
}