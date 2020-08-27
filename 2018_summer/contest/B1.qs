// https://codeforces.com/contest/1002
namespace Solution_B1_2018 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguish between all zero and W state
    operation Solve (qr: Qubit[]) : Int {
        for ( i in 0 .. Length(qr) - 1) {
            if (M(qr[i]) == One) {
                return 1;
            }
        }
        return 0;
    }
}