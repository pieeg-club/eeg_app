import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to saving data.
/// This is an abstract class that extends [Failure].
sealed class DataStorageFailure extends Failure {
  const DataStorageFailure(super.message, super.stackTrace);

  /// Factory constructor for creating a `UnknownSaveDataFailure` instance
  factory DataStorageFailure.unknown(StackTrace stackTrace) =>
      UnknownDataStorageFailure._(stackTrace);
}

/// Represents a failure when the save data fails to save the input.
/// This class extends [DataStorageFailure] with a predefined message.
class UnknownDataStorageFailure extends DataStorageFailure {
  const UnknownDataStorageFailure._(StackTrace stackTrace)
      : super('Unknown save data failure', stackTrace);
}
