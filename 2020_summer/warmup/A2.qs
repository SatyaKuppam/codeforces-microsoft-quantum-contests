namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation Solve_A2 (unitary: (Qubit => Unit is Adj+Ctl)) : Int {
        mutable bits = new Result[0];
        mutable output = 0;

        using (q = Qubit()) {
            H(q);
            unitary(q);
            H(q);
            set bits += [MResetZ(q)];
        }
        set output = ResultArrayAsInt(bits);
        return output;
    }
}