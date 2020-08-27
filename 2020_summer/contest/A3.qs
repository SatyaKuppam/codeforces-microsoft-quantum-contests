namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    // distinguish between H and X
    operation distinguish_H_X (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using(q = Qubit()) {
            unitary(q);
            X(q);
            unitary(q);
            return MResetZ(q) == Zero ? 0 | 1;
        }
    }

    // @EntryPoint()
    // operation test(): Unit {
    //     Message($"H: {Solve(H)}");
    //     Message($"X: {Solve(X)}");
    // }
}