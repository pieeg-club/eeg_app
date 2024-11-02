import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';

/// A use case that gets a stream of processed data.
class GetProcessedDataStreamUseCase
    implements UseCase<Stream<List<List<double>>>, NoParams> {
  /// Constructs a [GetProcessedDataStreamUseCase] with the given [DeviceRepo].
  GetProcessedDataStreamUseCase(this._deviceRepo);

  final DeviceRepo _deviceRepo;

  @override
  Future<Either<Failure, Stream<List<List<double>>>>> call(NoParams params) {
    // Get the data stream result from the repository
    final dataStreamResult = _deviceRepo.getDataStream();

    // Handle the Either result
    return Future.value(
      dataStreamResult.fold(
        (failure) {
          // If there's a failure, return an empty stream wrapped in Right
          return const Right(Stream<List<List<double>>>.empty());
        },
        (dataStream) {
          // Process the data stream
          final processedDataStream =
              dataStream.map<List<List<double>>>((data) {
            return [data.map((e) => e.toDouble()).toList()];
          });

          // Return the processed data stream wrapped in Right
          return Right(processedDataStream);
        },
      ),
    );
  }
}
