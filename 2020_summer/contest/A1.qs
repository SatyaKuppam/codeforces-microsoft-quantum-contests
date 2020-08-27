namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation distinguish_cnots (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        using(qr = Qubit[2]) {
            X(qr[0]);
            X(qr[1]);
            unitary(qr);
            let output = M(qr[0]) == One ? 0 | 1;
            ResetAll(qr);
            return output;
        }
    }

    // operation solve_test():  Int {
    //     using(qr = Qubit[2]) {
    //         X(qr[0]);
    //         X(qr[1]);
    //         CNOT(qr[0], qr[1]);
    //         let output = MResetZ(qr[0]) == One ? 0 | 1;
    //         ResetAll(qr);
    //         return output;
    //     }
    // }

    // @EntryPoint()
    // operation test(): Unit {
    //     let output = solve_test();
    //     Message($"output: {output}");
    // }
}