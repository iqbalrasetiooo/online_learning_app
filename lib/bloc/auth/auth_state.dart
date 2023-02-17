part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String? message;
  AuthSuccess({this.message});
}

class AuthError extends AuthState {
  final String? message;
  AuthError({this.message});
}
