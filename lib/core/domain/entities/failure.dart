import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  const Failure({required this.message});
}

class ErrorFailure extends Failure {
  const ErrorFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class HttpFailure extends Failure {
  const HttpFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
