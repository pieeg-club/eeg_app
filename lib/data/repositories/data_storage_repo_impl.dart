import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/failures/data_storage_failures.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:synchronized/synchronized.dart';

/// Represents a repository for saving data.
class DataStorageRepoImpl implements DataStorageRepo {
  bool _isRecording = false;
  final _lock = Lock();
  final _buffer = StringBuffer();
  static const _flushThreshold = 6000;
  File? _file;

  @override
  Future<Either<DataStorageFailure, Unit>> saveData(String data) async {
    if (_isRecording) {
      try {
        _buffer.write(data);
        if (_buffer.length > _flushThreshold) {
          await _saveData(data: _buffer.toString());
          _buffer.clear();
        }
      } catch (e, s) {
        log('Error saving data: $e', stackTrace: s);
        return Left(DataStorageFailure.failedToSave(s));
      }
    }
    return const Right(unit);
  }

  @override
  Future<Either<DataStorageFailure, Unit>> deleteFile(String fileName) async {
    if (_isRecording) {
      return Left(
        DataStorageFailure.recordingInProgress(StackTrace.current),
      );
    }
    try {
      await _deleteFileByName(fileName);
      return const Right(unit);
    } catch (e, s) {
      log('Error deleting file: $e', stackTrace: s);
      return Left(DataStorageFailure.failedToDelete(s));
    }
  }

  @override
  Future<Either<DataStorageFailure, List<FileInfo>>> getFilesInfo() async {
    if (_isRecording) {
      return Left(
        DataStorageFailure.recordingInProgress(StackTrace.current),
      );
    }
    try {
      final fileInfos = await _getFileInfosInApplicationDocuments();
      return Right(fileInfos);
    } catch (e, s) {
      log('Error getting files info: $e', stackTrace: s);
      return Left(DataStorageFailure.failedToGet(s));
    }
  }

  @override
  Future<Either<DataStorageFailure, Unit>> startRecording() async {
    _isRecording = true;
    return const Right(unit);
  }

  @override
  Future<Either<DataStorageFailure, Unit>> stopRecording() async {
    if (!_isRecording) return const Right(unit);
    _isRecording = false;
    if (_file != null) {
      try {
        if (_buffer.isNotEmpty) {
          await _saveData(data: _buffer.toString());
          _buffer.clear();
        }
        await _flushFile(_file!);
        _file = null;
      } catch (e, s) {
        log('Error stopping recording: $e', stackTrace: s);
        return Left(DataStorageFailure.failedToStopRecording(s));
      }
    }
    return const Right(unit);
  }

  @override
  Future<Either<DataStorageFailure, Unit>> shareFile(String filePath) async {
    if (_isRecording) {
      return Left(
        DataStorageFailure.recordingInProgress(StackTrace.current),
      );
    }
    try {
      await _shareFile(filePath);
      return const Right(unit);
    } catch (e, s) {
      log('Error sharing file: $e', stackTrace: s);
      return Left(DataStorageFailure.failedToShareFile(s));
    }
  }

  @override
  Future<Either<DataStorageFailure, bool>> isRecording() async {
    return Right(_isRecording);
  }

  /// Shares the file with the given path.
  Future<void> _shareFile(String filePath) async {
    await _lock.synchronized(() async {
      final result = await Share.shareXFiles([XFile(filePath)]);
      if (result.status == ShareResultStatus.dismissed) {
        throw Exception('Share was dismissed');
      }
    });
  }

  /// Appends the provided data to the file.
  Future<void> _saveData({
    required String data,
  }) async {
    await _lock.synchronized(() async {
      final file = await _getCurrentFile();
      await file.writeAsString(data, mode: FileMode.append);
    });
  }

  /// Deletes the file after ensuring all buffered data is written to disk.
  Future<void> _deleteFileByName(String fileName) async {
    // Get the Application Documents Directory
    final directory = await getApplicationDocumentsDirectory();

    await _lock.synchronized(() async {
      final files = Directory(directory.path).listSync();

      for (final entity in files) {
        if (entity is File) {
          // Check if the file's name matches
          if (path.basename(entity.path) == fileName) {
            await entity.delete();
            break;
          }
        }
      }
    });
  }

  Future<List<FileInfo>> _getFileInfosInApplicationDocuments() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileInfos = <FileInfo>[];

    await _lock.synchronized(() async {
      final files = Directory(directory.path).listSync();

      for (final entity in files) {
        // Check if the entity is a file, not a directory
        if (entity is File) {
          final fileStat = entity.statSync();

          fileInfos.add(
            FileInfo(
              path.basename(entity.path), // File name
              entity.path, // Full file path
              path.extension(entity.path), // File extension
              fileStat.size, // File size in bytes
            ),
          );
        }
      }
    });

    return fileInfos;
  }

  /// Helper method to get the file to write data to.
  Future<File> _getCurrentFile() async {
    if (_file == null) {
      final appDirectory = await getApplicationDocumentsDirectory();

      // Format the current date and time
      final timestamp =
          DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());

      // Generate the file name with date and time
      _file = File(
        path.join(
          appDirectory.path,
          'eeg_data_$timestamp.txt',
        ),
      );
    }

    return _file!;
  }

  /// Flushes buffered data to disk to ensure data integrity.
  Future<void> _flushFile(File file) async {
    final randomAccessFile = await file.open();
    await randomAccessFile.flush();
    await randomAccessFile.close();
  }
}
