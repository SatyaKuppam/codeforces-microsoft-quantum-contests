// https://codeforces.com/contest/1001/problem/A
namespace Summer_2018_Warmup {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Create + and - state
    operation Solve_A (q: Qubit, sign: Int) : Unit {
        if (sign == -1) {
            X(q);
        }
        H(q);
    }

    //@EntryPoint()
    operation test_A(): Unit {
        mutable output = 0;
        mutable bits = new Result[0];

        using (q = Qubit()) {
            Solve_A(q, -1);
            set bits += [MResetX(q)];
        }
        set output = ResultArrayAsInt(bits);
        Message($"Do we have a plus state? {output}");
    }
}