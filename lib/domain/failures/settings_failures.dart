import 'package:eeg_app/core/failure.dart';

/// Failures for the settings repository
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
/// It contains a stack trace to help with debugging.
sealed class SettingsFailures extends Failure {
  /// Constructs a [SettingsFailures] with the given [message] and [stackTrace].
  const SettingsFailures(super.message, super.stackTrace);
}
