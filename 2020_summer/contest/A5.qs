namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;

    // distinguish between Rz and R1 gate
    // operation Solve (theta : Double, unitary : (Qubit => Unit is Adj+Ctl)) : Int {
    //     using (qr = Qubit[2]) {
    //         H(qr[0]);
    //         Controlled unitary(qr[0..0], qr[1]);
    //         return MResetX(qr[0]) == Zero ? 0 | 1;
    //     }
    // }

    // operation test_gate(q: Qubit): Unit is Adj+Ctl {
    //     Ry(0.25*PI(), q);
    // }

    // @EntryPoint()
    // operation test(): Unit {
    //     let output = Solve(0.25 * PI(), test_gate);
    //     Message($"{output}");
    // }
}