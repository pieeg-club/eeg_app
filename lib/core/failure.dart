/// An abstract class representing a failure with an associated message.
///
/// This class serves as a base class for different types of failures that
/// can occur in the application. Each failure has a message that provides
/// more details about the failure.
///
/// The [Failure] class is intended to be extended by other classes to
/// represent specific types of failures.
///
/// Example:
/// ```dart
/// class NetworkFailure extends Failure {
///   const NetworkFailure(String message) : super(message);
/// }
/// ```
///
/// Properties:
/// - `message`: A string containing details about the failure.
abstract class Failure {
  /// Constructs a [Failure] with the given message.
  const Failure(this.message, this.stackTrace);

  /// A string containing details about the failure.
  final String message;

  /// A stack trace that provides information about where the failure occurred.
  final StackTrace stackTrace;

  @override
  String toString() => message;
}
