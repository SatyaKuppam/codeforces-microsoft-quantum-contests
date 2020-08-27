// https://codeforces.com/contest/1002
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguish between all zero and W state
    operation Solve_B2 (qr: Qubit[]) : Int {
        mutable count = 0;
        for ( i in 0 .. Length(qr) - 1) {
            if (M(qr[i]) == One) {
                set count = count + 1;
            }
        }
        if (count == 1) {
            return 1;
        }
        return 0;
    }
}