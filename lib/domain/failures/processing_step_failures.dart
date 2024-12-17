import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to a processing step.
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
/// It contains a stack trace to help with debugging.
sealed class ProcessingStepFailure extends Failure {
  const ProcessingStepFailure(super.message, super.stackTrace);

  /// Factory constructor for creating a `UnknownProcessingStepFailure` instance
  factory ProcessingStepFailure.unknown(StackTrace stackTrace) =>
      UnknownProcessingStepFailure._(stackTrace);
}

/// Represents a failure when the processing step fails to process the input.
/// This class extends [ProcessingStepFailure] with a predefined message.
class UnknownProcessingStepFailure extends ProcessingStepFailure {
  const UnknownProcessingStepFailure._(StackTrace stackTrace)
      : super('Unknown processing step failure', stackTrace);
}
