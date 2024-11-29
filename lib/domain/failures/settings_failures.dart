import 'package:eeg_app/core/failure.dart';

/// Failures for the settings repository
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
/// It contains a stack trace to help with debugging.
sealed class SettingsFailures extends Failure {
  /// Constructs a [SettingsFailures] with the given [message] and [stackTrace].
  const SettingsFailures(super.message, super.stackTrace);

  /// Factory constructor for creating
  /// an `IncorrectBandPassCutOffsFailure` instance.
  factory SettingsFailures.incorrectBandPassCutOffs(StackTrace stackTrace) =>
      IncorrectBandPassCutOffsFailure._(stackTrace);

  /// Factory constructor for creating an `UnknownSettingsFailure` instance.
  factory SettingsFailures.unknown(StackTrace stackTrace) =>
      UnknownSettingsFailure._(stackTrace);
}

/// Represents a failure when the band pass cut off values are incorrect.
///
/// This class extends [SettingsFailures] with a predefined message.
class IncorrectBandPassCutOffsFailure extends SettingsFailures {
  const IncorrectBandPassCutOffsFailure._(StackTrace stackTrace)
      : super('Incorrect band pass cut off values', stackTrace);
}

/// Represents an unknown settings failure.
///
/// This class extends [SettingsFailures] with a predefined message.
class UnknownSettingsFailure extends SettingsFailures {
  const UnknownSettingsFailure._(StackTrace stackTrace)
      : super('Unknown settings failure', stackTrace);
}
