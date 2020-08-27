// https://codeforces.com/contest/1001
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    // Distinguish between + and - state
    operation Solve_D (qr: Qubit) : Int {
        // just apply the hadamard on qubit and measure it in Z basis
        // if the result is 0 then its + state if 1 then its - state
        // mutable output = 0;
        // mutable bits = new Result[0];
        // H(qr);
        // set bits += [MResetZ(qr)];
        // set output = ResultArrayAsInt(bits);
        // if (output == 0) {
        //     return 1;
        // }
        // return -1;

        // More concisely
        H(qr);
        if (MResetZ(qr) == Zero) {
            return 1;
        }
        return -1;
    }

    // @EntryPoint()
    // operation test_A(): Unit {
    //     using ((q1,q2)=(Qubit(),Qubit())) {
    //         H(q1);
    //         X(q2);
    //         H(q2);
    //         Message($"Do we have a plus state? {Solve(q1)}");
    //         Message($"Do we have a minus state? {Solve(q2)}");
    //     }
    // }
}