// https://codeforces.com/contest/1001/problem/C
namespace Summer_2018_Warmup {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Creates Greenberger-Horne-Zeilinger (GHZ) states for N in [1,8]
    // for N=1, GHZ state is + and bell state B_0 from question B.
    operation Solve_C (qr: Qubit[]) : Unit {
        // just a for loop on all the qubits in the quantum register
        H(qr[0]);
        for (i in 1..Length(qr)-1) {
            CNOT(qr[0], qr[i]);
        } 
    }

    // @EntryPoint()
    operation test_C(): Unit {
        mutable output = 0;
        mutable bits = new Result[3];

        using (q = Qubit[3]) {
            Solve_C(q);
            set bits += [MeasureAllZ(q)];
        }
        set output = ResultArrayAsInt(bits);
        Message($"Output: {output}");
    }
}