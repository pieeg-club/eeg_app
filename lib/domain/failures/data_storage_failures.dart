import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to saving data.
/// This is an abstract class that extends [Failure].
sealed class DataStorageFailure extends Failure {
  const DataStorageFailure(super.message, super.stackTrace);

  /// Factory constructor for creating a
  /// `FailedToShareFileDataStorageFailure` instance
  factory DataStorageFailure.failedToShareFile(StackTrace stackTrace) =>
      FailedToShareFileDataStorageFailure._(stackTrace);

  /// Factory constructor for creating a
  /// `FailedToStopRecordingDataStorageFailure` instance
  factory DataStorageFailure.failedToStopRecording(StackTrace stackTrace) =>
      FailedToStopRecordingDataStorageFailure._(stackTrace);

  /// Factory constructor for creating a `FailedToSaveData` instance
  factory DataStorageFailure.failedToSave(StackTrace stackTrace) =>
      FailedToSaveData._(stackTrace);

  /// Factory constructor for creating a `FailedToGetData` instance
  factory DataStorageFailure.failedToGet(StackTrace stackTrace) =>
      FailedToGetData._(stackTrace);

  /// Factory constructor for creating a `FailedToDeleteData` instance
  factory DataStorageFailure.failedToDelete(StackTrace stackTrace) =>
      FailedToDeleteData._(stackTrace);

  /// Factory constructor for creating a
  /// `RecordingInProgreessDataStorageFailure` instance
  factory DataStorageFailure.recordingInProgress(StackTrace stackTrace) =>
      RecordingInProgreessDataStorageFailure._(stackTrace);

  /// Factory constructor for creating a `UnknownSaveDataFailure` instance
  factory DataStorageFailure.unknown(StackTrace stackTrace) =>
      UnknownDataStorageFailure._(stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class FailedToShareFileDataStorageFailure extends DataStorageFailure {
  const FailedToShareFileDataStorageFailure._(StackTrace stackTrace)
      : super('Failed to share file', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class FailedToStopRecordingDataStorageFailure extends DataStorageFailure {
  const FailedToStopRecordingDataStorageFailure._(StackTrace stackTrace)
      : super('Failed to stop recording', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class FailedToSaveData extends DataStorageFailure {
  const FailedToSaveData._(StackTrace stackTrace)
      : super('Failed to save data', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class FailedToGetData extends DataStorageFailure {
  const FailedToGetData._(StackTrace stackTrace)
      : super('Failed to get data', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class FailedToDeleteData extends DataStorageFailure {
  const FailedToDeleteData._(StackTrace stackTrace)
      : super('Failed to delete data', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class RecordingInProgreessDataStorageFailure extends DataStorageFailure {
  const RecordingInProgreessDataStorageFailure._(StackTrace stackTrace)
      : super('Recording in progress', stackTrace);
}

/// Represents a failure with data storage.
/// This class extends [DataStorageFailure] with a predefined message.
class UnknownDataStorageFailure extends DataStorageFailure {
  const UnknownDataStorageFailure._(StackTrace stackTrace)
      : super('Unknown data storage failure', stackTrace);
}
