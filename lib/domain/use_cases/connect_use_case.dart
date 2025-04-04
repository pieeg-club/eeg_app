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
    await result.fold((failure) async {
      await _logRepo.logError(failure.message);
      final errorMessage = await _deviceRepo.getLastConnectionError();
      errorMessage.fold((failure) {
        _logRepo.logError(failure.message);
      }, (data) {
        _logRepo
          ..logInfo('Error message retrieved successfully')
          ..logInfo(data);
      });
    }, (data) {
      _logRepo.logInfo('Connected to device');
    });
    final scanResults = await _deviceRepo.getLastScanResults();
    scanResults.fold((failure) {
      _logRepo.logError(failure.message);
    }, (data) {
      _logRepo
        ..logInfo('Connected devices retrieved successfully')
        ..logInfo(data.toSet().toString());
    });
    return result;
  }
}
