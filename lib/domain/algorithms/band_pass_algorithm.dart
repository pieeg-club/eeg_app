import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/entities/algorithm_results/band_pass_algorithm_result.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';

/// An algorithm that processes raw data using a band-pass filter.
/// This algorithm filters out frequencies that are not
/// within a specified range.
class BandPassAlgorithm implements Algorithm {
  /// Constructs a [BandPassAlgorithm] with the given [ProcessingStepRepo].
  BandPassAlgorithm(
    this._convertToVolts,
    this._bandPassFilter,
  );

  final ProcessingStepRepo<List<double>, List<int>> _convertToVolts;
  final ProcessingStepRepo<List<double>, List<double>> _bandPassFilter;

  @override
  Stream<Either<Failure, AlgorithmResult>> call(Stream<List<int>> rawData) {
    return rawData.asyncMap((data) async {
      // Step 1: Convert to volts
      final volts = await _convertToVolts(data);
      if (volts.isLeft()) {
        // Propagate failure if conversion to volts fails
        return volts.map((result) => result as AlgorithmResult);
      }

      // Step 2: Apply band-pass filter
      final bandPassFiltered = await _bandPassFilter(volts.getOrElse(() => []));
      if (bandPassFiltered.isLeft()) {
        // Propagate failure if band-pass filtering fails
        return bandPassFiltered.map((result) => result as AlgorithmResult);
      }

      // Return successful result with band-pass filtered data
      return Right(
        BandPassAlgorithmResult(bandPassFiltered.getOrElse(() => [])),
      );
    });
  }
}
