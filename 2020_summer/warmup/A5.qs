namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguish between Z and -Z
    operation DistinguishZAndMinusZ (unitary: (Qubit => Unit is Adj+Ctl)) : Int {
        using (qr = Qubit[2]) {
            H(qr[0]);
            Controlled unitary(qr[0..0], qr[1]);
            return MResetX(qr[0]) == Zero ? 0 | 1;
        }
    }
}