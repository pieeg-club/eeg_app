import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/log_failures.dart';

/// This is a repository interface for logging errors, info, and warnings.
abstract class LogRepo {
  /// Logs an error message.
  Future<Either<LogFailure, Unit>> logError(String error);

  /// Logs an info message.
  Future<Either<LogFailure, Unit>> logInfo(String info);

  /// Logs a warning message.
  Future<Either<LogFailure, Unit>> logWarning(String warning);

  /// Retrieves a list of logs.
  Future<Either<LogFailure, List<String>>> getLogs();
}
