import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';

/// A use case that disconnects from the BLE device.
class DisconnectUseCase implements UseCase<Unit, NoParams> {
  /// Constructs a [DisconnectUseCase] with the given [DeviceRepo].
  DisconnectUseCase(this._deviceRepo);

  final DeviceRepo _deviceRepo;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _deviceRepo.disconnect();
  }
}
