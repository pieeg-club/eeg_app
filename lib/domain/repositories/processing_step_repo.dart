import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';

/// Abstract class for processing steps.
/// A processing step is a step in the processing pipeline.
/// It takes an input and returns an output.
/// The input and output can be of any type.
// ignore: one_member_abstracts
abstract class ProcessingStepRepo<Output, Input> {
  /// Call the processing step with the given input.
  /// Returns the output of the processing step.
  Future<Either<ProcessingStepFailure, Output>> call(Input input);
}
