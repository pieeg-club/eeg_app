import 'package:equatable/equatable.dart';

/// Base class for all use cases.
///
/// A use case represents a single unit of business logic.
/// It takes parameters of type [Params] and returns a
/// result of type [ResultType].
///
/// Implementations should override the [call] method.
///
/// Example:
/// ```dart
/// class GetUserProfile extends UseCase<UserProfile, UserId> {
///   @override
///   UserProfile call(UserId params) {
///     // Implementation here
///   }
/// }
/// ```
// ignore: one_member_abstracts
abstract class UseCase<ResultType, Params> {
  /// Executes the use case with the given [params].
  ResultType call(Params params);
}

/// Represents no parameters.
///
/// Use this when a use case does not require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
