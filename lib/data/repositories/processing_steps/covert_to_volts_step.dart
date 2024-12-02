import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';

/// Converts the input data from bits to volts
class CovertToVoltsStep implements ProcessingStepRepo<List<double>, List<int>> {
  @override
  Future<Either<ProcessingStepFailure, List<double>>> call(
    List<int> input,
  ) async {
    int dataResult = 0;
    int convertData = 0;
    int dataCheck = 0xFFFFFF;
    int dataTest = 0x7FFFFF;
    double result = 0.0;
    int bytesPerSample = 3;
    List<double> dataForGraph = [];

    for (int index = 3; index < input.length; index++) {
      int dataRead = input[index];
      dataResult = (dataResult << 8) | dataRead;

      if ((index + 1) % bytesPerSample == 0) {
        convertData = dataResult | dataTest;

        if (convertData == dataCheck) {
          result = (dataResult - 16777214).toDouble();
        } else {
          result = dataResult.toDouble();
        }

        result = ((1000000 * 4.5 * (result / 16777215)) * 100).round() / 100;

        dataForGraph.add(result);

        dataResult = 0;
      }
    }

    return Right(dataForGraph);
  }
}
