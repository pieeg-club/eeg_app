import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/failures/log_failures.dart';
import 'package:eeg_app/domain/repositories/log_repo.dart';

/// A use case that retrieves logs from the repository.
class GetLogsUseCase implements UseCase<List<String>, NoParams> {
  /// Constructs a [GetLogsUseCase] with the given [LogRepo].
  const GetLogsUseCase(this._logRepo);

  final LogRepo _logRepo;

  @override
  Future<Either<LogFailure, List<String>>> call(NoParams params) async {
    return _logRepo.getLogs();
  }
}
