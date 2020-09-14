// https://codeforces.com/contest/1001/problem/E
namespace Summer_2018_Warmup {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation Solve_E (qr: Qubit[]) : Int {
        CNOT(qr[0], qr[1]);
        H(qr[0]);
        return ResultArrayAsInt([M(qr[0]), M(qr[1])]);
    }

    @EntryPoint()
    operation test_E(): Unit {
        using (qr = Qubit[2]) {
            // get state B3 from question B
            Solve_B(qr, 2);
            Message($"state is: {Solve_E(qr)}");
            ResetAll(qr);
        }
    }
}