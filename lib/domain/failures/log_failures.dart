import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to logging.
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
/// It contains a stack trace to help with debugging.
sealed class LogFailure extends Failure {
  const LogFailure(super.message, super.stackTrace);

  /// Factory constructor for creating a `FailedToLogFailure` instance.
  factory LogFailure.failedToLog(StackTrace stackTrace) =>
      FailedToLogFailure._(stackTrace);

  /// Factory constructor for creating an `UnknownLogFailure` instance.
  factory LogFailure.unknown(StackTrace stackTrace) =>
      UnknownLogFailure._(stackTrace);
}

/// Represents a failure when logging fails.
///
/// This class extends [LogFailure] with a predefined message.
class FailedToLogFailure extends LogFailure {
  const FailedToLogFailure._(StackTrace stackTrace)
      : super('Failed to log message', stackTrace);
}

/// Represents an unknown log failure.
///
/// This class extends [LogFailure] with a predefined message.
class UnknownLogFailure extends LogFailure {
  const UnknownLogFailure._(StackTrace stackTrace)
      : super('Unknown log failure', stackTrace);
}
