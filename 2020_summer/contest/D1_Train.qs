namespace Solution.Contest2020Summer.Qml {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.MachineLearning;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;

    operation SampleSingleParameter() : Double {
        return PI() * (RandomReal(16) - 1.0);
    }
    
     operation SampleParametersForSequence(structure : ControlledRotation[]) : Double[] {
        return ForEach(SampleSingleParameter, ConstantArray(Length(structure), ()));
    }

    operation SampleInitialParameters(nInitialParameterSets : Int, structure : ControlledRotation[]) : Double[][] {
        return ForEach(SampleParametersForSequence, ConstantArray(nInitialParameterSets, structure));
    }

    // Define your Model here
    function ClassifierStructure(): ControlledRotation[] {
        return CombinedStructure([
            //LocalRotationsLayer(1, PauliZ),
            //LocalRotationsLayer(1, PauliX),
            //LocalRotationsLayer(1, PauliY)
            LocalRotationsLayer(4, PauliZ),
            LocalRotationsLayer(4, PauliX),
            CyclicEntanglingLayer(4, PauliX, 1),
            PartialRotationsLayer([3], PauliX)
        ]);
    }

    // Train yout model here
    operation TrainModelD1(
        trainingVectors: Double[][],
        trainingLabels: Int[]
    ) : (Double[], Double) {
        let samples = Mapped(LabeledSample, Zip(trainingVectors, trainingLabels));
        let initialParameters = SampleInitialParameters(10, ClassifierStructure());
        let models = Mapped(
            SequentialModel(ClassifierStructure(), _, 0.0),
            initialParameters
        );
        let defaultSchedule = SamplingSchedule([0..Length(samples)-1]);
        Message($"Length of structure: {Length(ClassifierStructure())}");
        Message($"{initialParameters}");

        let (optimizedModel, nMisses) = TrainSequentialClassifier(
            models,
            samples,
            DefaultTrainingOptions()
                w/ LearningRate <- 2.0
                w/ MinibatchSize <- 4
                w/ NMeasurements <- 10000
                w/ MaxEpochs <- 2
                w/ Tolerance <- 0.005
                w/ VerboseMessage <- Message,
            defaultSchedule,
            defaultSchedule
        );
        Message($"Training complete, found optimal parameters: {optimizedModel::Parameters}, {optimizedModel::Bias} with {nMisses} misses");
        return (optimizedModel::Parameters, optimizedModel::Bias);
    }

    // Validate your model here
    operation ValidateModel(
        validationVectors: Double[][],
        validationLabels: Int[],
        parameters: Double[],
        bias: Double
    ): Double {
        let samples = Mapped(LabeledSample, Zip(validationVectors, validationLabels));

        let tolerance = 0.005;
        let nMeasurements = 10000;

        let defaultSchedule = SamplingSchedule([0..Length(samples)-1]);
        let results = ValidateSequentialClassifier(
            SequentialModel(ClassifierStructure(), parameters, bias),
            samples,
            tolerance,
            nMeasurements,
            defaultSchedule
        );
        return IntAsDouble(results::NMisclassifications)/IntAsDouble(Length(samples));
    }    
}