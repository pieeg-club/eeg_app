import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/flat_microvolt_algorithm_result.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';

/// An algorithm that converts raw data to microvolts.
/// Without buffering the data.
class FlatMicrovoltAlgorithm
    implements Algorithm<FlatMicrovoltAlgorithmResult> {
  /// Constructs a [FlatMicrovoltAlgorithm].
  FlatMicrovoltAlgorithm(
    this._splitIntoChannels,
    this._convertToVolts,
  );

  final ProcessingStepRepo<List<List<int>>, List<int>> _splitIntoChannels;
  final ProcessingStepRepo<List<List<double>>, List<List<int>>> _convertToVolts;

  @override
  Future<Either<Failure, Option<FlatMicrovoltAlgorithmResult>>> call(
    List<int> rawData,
  ) async {
    // Step 0: Split data into channels
    final channelsData = await _splitIntoChannels(rawData);
    if (channelsData.isLeft()) {
      // Propagate failure if splitting into channels fails
      return Left(channelsData.fold((failure) => failure, (_) => null)!);
    }

    // Step 1: Convert to volts
    final volts = await _convertToVolts(channelsData.getOrElse(() => []));
    if (volts.isLeft()) {
      // Propagate failure if conversion to volts fails
      return Left(volts.fold((failure) => failure, (_) => null)!);
    }

    // Create result with converted data
    final voltsResult = volts.getOrElse(() => []);
    final result = FlatMicrovoltAlgorithmResult(
      List.generate(
        voltsResult.first.length,
        (sample) => List.generate(
          voltsResult.length,
          (channel) => voltsResult[channel][sample],
        ),
      ),
    );

    return Right(some(result));
  }
}
