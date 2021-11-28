import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable {}

class SignUpButtonPressedEvent extends RegEvent {

  String email, password;

  SignUpButtonPressedEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}