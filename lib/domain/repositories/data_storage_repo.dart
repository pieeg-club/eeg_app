import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/data_storage_failures.dart';

/// Represents a repository for saving data.
/// This is an abstract class that contains a method for saving data.
abstract class DataStorageRepo {
  /// Saves the given data.
  Future<Either<DataStorageFailure, Unit>> saveData(List<dynamic> data);

  /// Gets the currently recorded file.
  Future<Either<DataStorageFailure, File>> getRecordingFile();

  /// Starts the data storage.
  Future<Either<DataStorageFailure, Unit>> startRecording();

  /// Stops the data storage.
  Future<Either<DataStorageFailure, Unit>> stopRecording();
}
