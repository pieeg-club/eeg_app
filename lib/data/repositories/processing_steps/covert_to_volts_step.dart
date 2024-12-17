import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';

/// Converts the input data from bits to volts
class CovertToVoltsStep
    implements ProcessingStepRepo<List<List<double>>, List<List<int>>> {
  @override
  Future<Either<ProcessingStepFailure, List<List<double>>>> call(
    List<List<int>> input,
  ) async {
    var dataResult = 0;
    var convertData = 0;
    const dataCheck = 0xFFFFFF;
    const dataTest = 0x7FFFFF;
    var result = 0.0;
    const bytesPerSample = 3;
    final dataForGraph = <List<double>>[];

    for (var channel = 0; channel < input.length; channel++) {
      dataForGraph.add([]);
      for (var index = 0; index < input[channel].length; index++) {
        final dataRead = input[channel][index];
        dataResult = (dataResult << 8) | dataRead;

        if ((index + 1) % bytesPerSample == 0) {
          convertData = dataResult | dataTest;

          if (convertData == dataCheck) {
            result = (dataResult - 16777214).toDouble();
          } else {
            result = dataResult.toDouble();
          }

          result = ((1000000 * 4.5 * (result / 16777215)) * 100).round() / 100;

          dataForGraph[channel].add(result);

          dataResult = 0;
        }
      }
    }

    return Right(dataForGraph);
  }
}
