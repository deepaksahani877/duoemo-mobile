/// Base class for typed failures per instruction.md error handling guidelines.
abstract class Failure {
  final String message;
  final dynamic cause;

  const Failure(this.message, [this.cause]);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.cause]);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.cause]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.cause]);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, [super.cause]);
}
