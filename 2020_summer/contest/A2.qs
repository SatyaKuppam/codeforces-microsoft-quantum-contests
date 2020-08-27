namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    operation distinguish_swap_cnot2(unitary : (Qubit[] => Unit is Adj+Ctl)): Int {
        mutable result_as_int = 0;
        using(qr = Qubit[2]) {
            X(qr[1]);
            unitary(qr);
            set result_as_int = ResultArrayAsInt([MResetZ(qr[0]), MResetZ(qr[1])]); 
            ResetAll(qr);
            // Message($"First: {result_as_int}");
            return result_as_int;
        }
    }

    // distinguish between I, cnot1,2, cnot2,1 and SWAP
    operation distinguish_I_cnots_swap (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        // start with state |01>
        // if we get |10> then its SWAP
        // if we get |11> then its CNOT2,1
        // if we get |01> then its either CNOT1,2 or I
        mutable result = distinguish_swap_cnot2(unitary);
        if (result == 1) {
            return 3;
        } 
        if (result == 3) {
            return 2;
        }
        mutable output = -1;
        using(qs = Qubit[2]) {
            // start with state |10>
            // if we get |10> then its I, if its |11> then its CNOT1,2
            X(qs[0]);
            unitary(qs);
            set result = ResultArrayAsInt([MResetZ(qs[0]), MResetZ(qs[1])]);
            // Message($"Second: {result}");
            if (result == 1) {
                set output = 0;
            }
            elif (result == 3) {
                set output = 1;
            }
            ResetAll(qs);
            return output;
        }
    }

    // operation solve_test(qr: Qubit[]):  Unit is Adj+Ctl {
    //      // I(qr[0]);
    //      // I(qr[1]);
    //      // CNOT(qr[0], qr[1]);
    //      // CNOT(qr[1], qr[0]);
    //      SWAP(qr[0], qr[1]);
    // }

    // @EntryPoint()
    // operation test(): Unit {
    //     let output = Solve(solve_test);
    //     Message($"output: {output}");
    // }
}