import 'package:eeg_app/domain/core/use_case.dart';
import 'package:eeg_app/domain/repositories/ble_repo.dart';

/// A use case that connects to the BLE device.
class ConnectUseCase implements UseCase<Future<void>, NoParams> {
  /// Constructs a [ConnectUseCase] with the given [BleRepo].
  ConnectUseCase(this._bleRepo);

  final BleRepo _bleRepo;

  @override
  Future<void> call(NoParams params) async {
    await _bleRepo.connect();
  }
}
