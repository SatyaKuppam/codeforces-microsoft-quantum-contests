namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguishes between Z and S
    operation Solve_A3 (unitary: (Qubit => Unit is Adj+Ctl)) : Int {
        mutable bits = new Result[0];
        mutable output = 0;

        using (q = Qubit()) {
            H(q);
            unitary(q);
            unitary(q);
            H(q);
            set bits += [MResetZ(q)];
        }
        set output = ResultArrayAsInt(bits);
        return output;
    }
}