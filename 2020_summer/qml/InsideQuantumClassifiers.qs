namespace Qml {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.MachineLearning;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;


    // generate sample data
    operation SampleData (samplesNumber : Int, separationAngles : Double[]) : (Double[][], Int[]) {
        mutable features = new Double[][samplesNumber];
        mutable labels = new Int[samplesNumber];
        for (i in 0 .. samplesNumber - 1) {
            let sample = [RandomReal(8), RandomReal(8)];
            let angle = ArcTan2(sample[1], sample[0]);
            set features w/= i <- sample;
            set labels w/= i <- (angle < separationAngles[0] or angle > separationAngles[1]) ? 0 | 1;
        }
        return (features, labels);
    }

    operation SampleDataDemo () : Unit {
        let trainingData = SampleData(5, [PI() / 6.0, PI()/ 3.0]);
        Message($"{trainingData}");
    }

    // amplitude encoding of the dataset
    operation EncodeDataDemo () : Unit {
        let sample = [RandomReal(8), RandomReal(8)];
        Message($"Raw data: {sample}");
    
        let norm = Sqrt(sample[0] ^ 2.0 + sample[1] ^ 2.0);
        Message($"Normalized data: [{sample[0] / norm}, {sample[1] / norm}]");
    
        using (q = Qubit()) {
            let (temp, encoder) = (InputEncoder(sample))!;
            Message($"{temp}");
            encoder(LittleEndian([q]));
            Message("Encoded as a quantum state:");
            DumpMachine();
            Reset(q);
        }
    }

    // Just one rotation with one parameter
    // the parameter has the index 0
    // we need to train a model on the zero
    // parameter
    function ClassifierStructure(): ControlledRotation[] {
        return [
            ControlledRotation((0, new Int[0]), PauliX, 0),
            ControlledRotation((0, new Int[0]), PauliY, 1),
            ControlledRotation((0, new Int[0]), PauliZ, 2)
        ];
    }

    // Training the model
    // returns: [parameters] and bias(b)
    // args:
    //      trainingVectors: Double[][]
    //      trainingLabels:  Int[]
    //      initialParameters: Double[][]
    operation TrainModel(
        trainingVectors: Double[][],
        trainingLabels: Int[],
        initialParameters: Double[][]
    ) : (Double[], Double) {
        // create a LabeledSample obj from the raw data
        let samples = Mapped(LabeledSample, Zip(trainingVectors, trainingLabels));

        // Define a set of models we're going to try training;
        // in this case all models have the same structure but differ in the value of initial parameters
        let models = Mapped(
            SequentialModel(ClassifierStructure(), _, 0.0),
            initialParameters
        );

        // Train the model
        let defaultSchedule = SamplingSchedule([0..Length(samples)-1]);
        let (optimizedModel, nMisses) = TrainSequentialClassifier(
            models,
            samples,
            DefaultTrainingOptions()
                w/ LearningRate <- 2.0
                w/ Tolerance <- 0.0005,
            defaultSchedule,
            defaultSchedule
        );
        Message($"Training complete, found optimal parameters: {optimizedModel::Parameters}, {optimizedModel::Bias} with {nMisses} misses");
        return (optimizedModel::Parameters, optimizedModel::Bias);
    }

    // traing the model with data
    operation TrainModelDemo(): Unit {
        let (features, labels) = SampleData(150, [PI()/6.0, PI()/3.0]);
        let (parameters, bias) = TrainModel(features, labels, [[1.0], [2.0]]);
    }

    // validate the model
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

    // combines both training and validation
    operation TrainAndValidateModelDemo(): Unit {
        // generate the training data
        let (trainingVectors, trainingLabels) = SampleData(150, [PI() / 6.0, PI()/ 3.0]);
        // train the model with the data generate above
        let (parameters, bias) = TrainModel(trainingVectors, trainingLabels, [[1.0], [2.0]]);
        Message($"Parameters {parameters}, bias {bias}");
        // generate the validation data
        let (validationVectors, validationLabels) = SampleData(50, [PI() / 6.0, PI()/ 3.0]);
        // calculate the model performance on the validation data
        let missRate = ValidateModel(validationVectors, validationLabels, parameters, bias);
        Message($"Miss rate: {missRate * 100.0}%");
    }

    // @EntryPoint()
    // operation start(): Unit {
    //     // SampleDataDemo();
    //     // EncodeDataDemo();
    //     // TrainModelDemo();
    //     // TrainAndValidateModelDemo();
    //     // TrainModelD1();
    // }
}