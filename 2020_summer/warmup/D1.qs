namespace Solution {
    open Microsoft.Quantum.MachineLearning;

    operation solution_to_D1 () : (ControlledRotation[], (Double[], Double)) {
        return ([
            ControlledRotation((0, new Int[0]), PauliY, 0)
        ], ([3.1322749999999973], -0.0006999999999999784));
    }
}