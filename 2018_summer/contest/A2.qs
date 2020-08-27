// https://codeforces.com/contest/1002
namespace Solution_A2_2018 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Generate a super position of zero state and a basis state
    operation Solve (qr: Qubit[], bits: Bool[]) : Unit {
        H(qr[0]); // because bits[0] will always be 1

        for ( i in 1..Length(qr)-1) {
            if (bits[i]) {
                CNOT(qr[0], qr[i]);
            }
        }
    }
}