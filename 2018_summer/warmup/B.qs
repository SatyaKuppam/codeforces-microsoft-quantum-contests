// https://codeforces.com/contest/1001/problem/B
namespace Summer_2018_Warmup {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Creates all the two qubit bell states in the Z basis
    operation Solve_B (qr: Qubit[], index: Int) : Unit {
        if (index == 0) {
            H(qr[0]);
            CNOT(qr[0], qr[1]);
        }
        if (index == 1) {
            X(qr[0]);
            H(qr[0]);
            CNOT(qr[0], qr[1]);
        }
        if (index == 2) {
            H(qr[0]);
            X(qr[1]);
            CNOT(qr[0], qr[1]);
        }
        if (index == 3) {
            X(qr[0]);
            H(qr[0]);
            X(qr[1]);
            CNOT(qr[0], qr[1]);
        }
    }

    //@EntryPoint()
    operation test_B(): Unit {
        mutable output = 0;
        mutable bits = new Result[0];

        using (q = Qubit[2]) {
            Solve_B(q, 0);
            set bits += [MeasureAllZ(q)];
            ResetAll(q);
        }
        set output = ResultArrayAsInt(bits);
        Message($"Output: {output}");
    }
}