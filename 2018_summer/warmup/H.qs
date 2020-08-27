// https://codeforces.com/contest/1001
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation Solve_H (qr: Qubit[], y: Qubit) : Unit {
        for (i in 0..Length(qr)-1) {
            CNOT(qr[i], y);
        }
    }
}