namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;

    // increment mod 2^n, introduces important concept of recursion with
    // controlled gate, otherwise it would be like a cascade of CNOT gates
    operation Increment_mod_2 (register : LittleEndian) : Unit is Adj+Ctl {
        let qr = register!;

        if (Length(qr) > 1) {
            (Controlled Increment_mod_2) (qr[0..0], LittleEndian(qr[1...]));
        }
        X(qr[0]);
    }
}
