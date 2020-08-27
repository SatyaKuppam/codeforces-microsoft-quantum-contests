namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguishes between Z and S
    operation Solve_A4 (unitary: (Qubit[] => Unit is Adj+Ctl)) : Int {
        mutable bits = new Result[0];
        mutable output = 0;

        using (register = Qubit[2]) {
            X(register[1]);
            unitary(register);
            set bits += [MResetZ(register[1])];
            ResetAll(register);
        }
        set output = ResultArrayAsInt(bits);
        return output;
    }

    // operation test_cnot(qubits: Qubit[]): Unit is Adj+Ctl {
    //     CNOT(qubits[0], qubits[1]);
    // }

    // operation ix(qubits: Qubit[]): Unit is Adj+Ctl {
    //     I(qubits[0]);
    //     X(qubits[1]);
    // }

    // @EntryPoint()
    // operation test(): Unit {
    //     Message($"CNOT value is {Solve(test_cnot)}");
    //     Message($"ix value is {Solve(ix)}");
    // }
}