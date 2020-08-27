// https://codeforces.com/contest/1001
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation Solve_F (qr: Qubit[], bits0: Bool[], bits1: Bool[]) : Int {
        // just a for loop on all the qubits in the quantum register
        mutable first_diff = -1;
        for (i in 0..Length(bits1)-1) {
            if (bits0[i] != bits1[i]) {
                set first_diff = i;
            }
        }

        let qr_bit = (M(qr[first_diff]) != Zero);
        if (qr_bit == bits0[first_diff]) {
            return 0;
        }
        else {
            return 1;
        }
    }

    // @EntryPoint()
    // operation test_E(): Unit {
    //     using (qr = Qubit[2]) {
    //         Solve_B(qr, 2);
    //         Message($"B_2 {Solve(qr)}");
    //         ResetAll(qr);
    //     }
    // }
}