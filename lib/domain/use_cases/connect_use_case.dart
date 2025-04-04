import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';
import 'package:eeg_app/domain/repositories/log_repo.dart';

/// A use case that connects to the BLE device.
class ConnectUseCase implements UseCase<Unit, NoParams> {
  /// Constructs a [ConnectUseCase] with the given [DeviceRepo].
  ConnectUseCase(this._deviceRepo, this._logRepo);

  final DeviceRepo _deviceRepo;
  final LogRepo _logRepo;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final result = await _deviceRepo.connect();
    result.fold((failure) {
      _logRepo.logError(failure.message);
    }, (data) {
      _logRepo.logInfo('Connected to device');
    });
    return result;
  }
}
