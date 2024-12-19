import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/failures/data_storage_failures.dart';

/// Represents a repository for saving data.
/// This is an abstract class that contains a method for saving data.
abstract class DataStorageRepo {
  /// Saves the given data.
  Future<Either<DataStorageFailure, Unit>> saveData(String data);

  /// Retrieves info for all files in the storage.
  Future<Either<DataStorageFailure, List<FileInfo>>> getFilesInfo();

  /// Deletes the file with the given name.
  Future<Either<DataStorageFailure, Unit>> deleteFile(String fileName);

  /// Shares the file with the given path.
  Future<Either<DataStorageFailure, Unit>> shareFile(String fliePath);

  /// Starts the data storage.
  Future<Either<DataStorageFailure, Unit>> startRecording();

  /// Stops the data storage.
  Future<Either<DataStorageFailure, Unit>> stopRecording();
}
