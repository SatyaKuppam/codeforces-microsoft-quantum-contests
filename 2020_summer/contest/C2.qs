// https://codeforces.com/contest/1357/problem/C2
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;

    operation generate_state_with_parity (qs : Qubit[], parity : Int) : Unit {
        mutable result = -1;
        using (ancilla = Qubit()) {
            repeat {
                ApplyToEach(H, qs);
                for ( i in 0 .. Length(qs)-1) {
                    CNOT(qs[i], ancilla);
                }
                if (MResetZ(ancilla) == Zero) {
                    set result = 0;
                }
                else {
                    set result = 1;
                }
            } until (result == parity)
            fixup {
                ResetAll(qs);
            }
        }
    }

    // @EntryPoint()
    // operation test(): Unit {
    //     using (qs = Qubit[2]) {
    //         Solve(qs, 1);
    //         DumpMachine();
    //         ResetAll(qs);
    //     }
    // }
}