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
    this._splitIntoChannels,
    this._convertToVolts,
    this._bandPassFilter,
  );

  final ProcessingStepRepo<List<List<int>>, List<int>> _splitIntoChannels;
  final ProcessingStepRepo<List<List<double>>, List<List<int>>> _convertToVolts;
  final ProcessingStepRepo<List<List<double>>, List<List<double>>>
      _bandPassFilter;
  final _result = BandPassAlgorithmResult([]);

  @override
  Future<Either<Failure, Option<AlgorithmResult>>> call(
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

    // Step 2: Apply band-pass filter
    final bandPassFiltered = await _bandPassFilter(volts.getOrElse(() => []));
    if (bandPassFiltered.isLeft()) {
      // Propagate failure if band-pass filtering fails
      return Left(bandPassFiltered.fold((failure) => failure, (_) => null)!);
    }

    // Update result with band-pass filtered data
    for (var channel = 0;
        channel < bandPassFiltered.getOrElse(() => []).length;
        channel++) {
      if (_result.result.length <= channel) {
        _result.result.add([]);
      }
      _result.result[channel]
          .addAll(bandPassFiltered.getOrElse(() => [])[channel]);
    }

    if (_result.result[0].length >= 1000) {
      for (var channel = 0; channel < _result.result.length; channel++) {
        _result.result[channel].removeRange(0, 200);
      }
      return Right(some(_result));
    }

    return Right(none());
  }
}
