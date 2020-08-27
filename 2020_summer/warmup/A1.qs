namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguishes between I and X
    operation Solve_A1 (unitary: (Qubit => Unit is Adj+Ctl)) : Int {
        mutable bits = new Result[0];
        mutable output = 0;

        using (q = Qubit()) {
            unitary(q);
            set bits += [MResetZ(q)];
        }
        set output = ResultArrayAsInt(bits);
        return output;
    }
}