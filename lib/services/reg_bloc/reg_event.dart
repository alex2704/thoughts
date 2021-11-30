import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable {}

class SignUpButtonPressedEvent extends RegEvent {

  String email, password, name;

  SignUpButtonPressedEvent({required this.email, required this.password, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}