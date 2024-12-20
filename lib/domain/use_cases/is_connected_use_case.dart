import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';

/// Use case to check if the device is connected
class IsConnectedUseCase implements UseCase<bool, NoParams> {
  /// Constructor
  IsConnectedUseCase(this._deviceRepo);

  final DeviceRepo _deviceRepo;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _deviceRepo.isConnected();
  }
}
