// https://codeforces.com/contest/1001
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Creates Greenberger-Horne-Zeilinger (GHZ) states for N in [1,8]
    // for N=1, GHZ state is + and bell state B_0 from question B.
    operation Solve_E (qr: Qubit[]) : Int {
        // just a for loop on all the qubits in the quantum register
        CNOT(qr[0], qr[1]);
        H(qr[0]);
        return ResultArrayAsInt([M(qr[0]), M(qr[1])]);
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