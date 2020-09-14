// https://codeforces.com/contest/1001/problem/D
namespace Summer_2018_Warmup {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguish between + and - state
    operation Solve_D (qr: Qubit) : Int {
        H(qr);
        if (MResetZ(qr) == Zero) {
            return 1;
        }
        return -1;
    }

    //@EntryPoint()
    operation test_D(): Unit {
        using ((q1,q2)=(Qubit(),Qubit())) {
            H(q1);
            X(q2);
            H(q2);
            Message($"Do we have a plus state? {Solve_D(q1)}");
            Message($"Do we have a minus state? {Solve_D(q2)}");
        }
    }
}