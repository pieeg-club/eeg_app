import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';

/// An abstract class that represents an algorithm.
/// This class is used to define the structure of an algorithm.
// ignore: one_member_abstracts
abstract class Algorithm {
  /// Processes the raw data stream and returns a stream of processed data.
  Stream<Either<Failure, AlgorithmResult>> call(Stream<List<int>> rawData);
}
