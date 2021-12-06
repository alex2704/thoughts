import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegState extends Equatable {}

class RegInitialState extends RegState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegLoadingState extends RegState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegSuccessfulState extends RegState {

  User? user;

  RegSuccessfulState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegFailureState extends RegState {

  String msg;

  RegFailureState({required this.msg});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}