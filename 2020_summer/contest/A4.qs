namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;

    // distinguish between Rz and R1 gate
    // operation Solve_ (unitary : ((Double, Qubit) => Unit is Adj+Ctl)) : Int {
    //     let theta = PI();
    //     using (qr = Qubit[2]) {
    //         H(qr[0]);
    //         Controlled unitary(qr[0..0], (theta, qr[1]));
    //         return MResetX(qr[0]) == Zero ? 1 | 0;
    //     }
    // }

    // operation test_unitary(theta: Double, q: Qubit): Unit is Adj+Ctl {
    //     Rz(theta, q);
    //     // R1(theta, q);
    // }

    // @EntryPoint()
    // operation test(): Unit {
    //     Message($"{Solve(test_unitary)}");
    // }
}