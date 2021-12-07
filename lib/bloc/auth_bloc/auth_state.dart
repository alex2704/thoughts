import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthenticatedState extends AuthState {

  User? user;

  AuthenticatedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}