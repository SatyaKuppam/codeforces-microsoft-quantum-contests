// https://codeforces.com/contest/1002
namespace Solution_A3_2018 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    function FirstDiff(bits0: Bool[], bits1: Bool[]) : Int {
        for (i in 0 .. Length(bits0) - 1) {
            if (bits0[i] != bits1[i]) {
                return i;
            }
        }
        return -1;
    }

    // Generate a super position of zero state and a basis state
    operation Solve (qr: Qubit[], bits0: Bool[], bits1: Bool[]) : Unit {
        let firstDiff = FirstDiff(bits0, bits1);

        //DumpMachine();
        for ( i in 0 .. Length(bits0)-1) {
            if (i == firstDiff) {
                H(qr[firstDiff]);
            }
            if (bits0[i] == bits1[i]) {
                if (bits0[i]) {
                    X(qr[i]);
                }
            }
            else {
                if (i > firstDiff) {
                    CNOT(qr[firstDiff], qr[i]);
                    if (bits0[i] != bits0[firstDiff]) {
                        X(qr[i]);
                    }
                }
            }
        }
        //DumpMachine();
    }

    // @EntryPoint()
    // operation test(): Unit {
    //     using(qr = Qubit[3]) {
    //         Solve(qr, [false,true,false], [false,false,false]);
    //         ResetAll(qr);
    //     }
    // }
}