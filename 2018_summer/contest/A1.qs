// https://codeforces.com/contest/1002
namespace Solution_A1_2018 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Generate a super position of all possible states
    operation Solve (qr: Qubit[]) : Unit {
        for ( i in 0..Length(qr)-1) {
            H(qr[i]);
        }
    }
}