import 'package:eeg_app/domain/core/use_case.dart';
import 'package:eeg_app/domain/repositories/ble_repo.dart';

/// A use case that gets a stream of processed data.
class GetProcessedDataStreamUseCase
    implements UseCase<Stream<List<List<double>>>, NoParams> {
  /// Constructs a [GetProcessedDataStreamUseCase] with the given [BleRepo].
  GetProcessedDataStreamUseCase(this._bleRepo);

  final BleRepo _bleRepo;

  @override
  Stream<List<List<double>>> call(NoParams params) async* {
    await for (final data in _bleRepo.getDataStream()) {
      yield data;
    }
  }
}
