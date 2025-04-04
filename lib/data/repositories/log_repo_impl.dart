import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/log_failures.dart';
import 'package:eeg_app/domain/repositories/log_repo.dart';
import 'package:synchronized/synchronized.dart';

/// A repository for logging messages.
class LogRepoImpl implements LogRepo {
  final List<String> _logs = [];
  final _lock = Lock();

  @override
  Future<Either<LogFailure, List<String>>> getLogs() async {
    return _lock.synchronized(() async {
      return Right(List<String>.from(_logs));
    });
  }

  @override
  Future<Either<LogFailure, Unit>> logError(String error) =>
      _log('Error', error);

  @override
  Future<Either<LogFailure, Unit>> logInfo(String info) => _log('Info', info);

  @override
  Future<Either<LogFailure, Unit>> logWarning(String warning) =>
      _log('Warning', warning);

  Future<Either<LogFailure, Unit>> _log(String prefix, String message) async {
    await _lock.synchronized(() {
      _logs.add('$prefix: $message');
    });
    return const Right(unit);
  }
}
