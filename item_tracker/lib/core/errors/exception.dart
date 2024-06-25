
class Failure extends Error {
  final String? errorMessage;
  final int? applicationStatusCode;

  @override
  String get message => errorMessage ?? '';

  Failure({
    this.applicationStatusCode,
    this.errorMessage,
  }) : super();

  @override
  String toString() {
    if (message.isNotEmpty) {
      return message;
    } else {
      return 'Something Went Wrong';
    }
  }
}