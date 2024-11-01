import 'package:eeg_app/domain/core/use_case.dart';
import 'package:eeg_app/domain/repositories/ble_repo.dart';

/// A use case that disconnects from the BLE device.
class DisconnectUseCase implements UseCase<Future<void>, NoParams> {
  /// Constructs a [DisconnectUseCase] with the given [BleRepo].
  DisconnectUseCase(this._bleRepo);

  final BleRepo _bleRepo;

  @override
  Future<void> call(NoParams params) async {
    await _bleRepo.disconnect();
  }
}
