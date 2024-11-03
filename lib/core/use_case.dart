import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:equatable/equatable.dart';

/// An abstract class representing a use case that can be
/// executed with the given parameters.
///
/// [ResultType] is the type of the result produced by the use case.
/// [Params] is the type of the parameters required to execute the use case.
// ignore: one_member_abstracts
abstract class UseCase<ResultType, Params> {
  /// Executes the use case with the given [params].
  ///
  /// Returns a [Future] that completes with either a [Failure]
  /// or a [ResultType].
  Future<Either<Failure, ResultType>> call(Params params);
}

/// Represents no parameters.
///
/// Use this when a use case does not require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
