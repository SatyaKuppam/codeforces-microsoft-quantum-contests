namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;

    // This is just the adjoint of B1, because B1 operation is unitary its
    // reversible and we can apply its adjoint to simply decrease the
    // integer value, but here we run the operations in reverse.
    operation Decrement_mod_2 (register : LittleEndian) : Unit is Adj+Ctl {
        let qr = register!;

        X(qr[0]);

        if (Length(qr) > 1) {
            (Controlled Decrement_mod_2) (qr[0..0], LittleEndian(qr[1...]));
        }
    }
}
