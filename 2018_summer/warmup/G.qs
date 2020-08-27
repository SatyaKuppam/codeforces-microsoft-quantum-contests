// https://codeforces.com/contest/1001
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation Solve_G (qr: Qubit[], y: Qubit, k: Int) : Unit {
        CNOT(qr[k], y);
    }

    // @EntryPoint()
    // operation test_E(): Unit {
    //     using (qr = Qubit[2]) {
    //         Solve_B(qr, 2);
    //         Message($"B_2 {Solve(qr)}");
    //         ResetAll(qr);
    //     }
    // }
}