import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/repositories/user_repository.dart';
import 'package:thoughts/bloc/login_bloc/login_event.dart';
import 'package:thoughts/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late UserRepository userRepository;

  LoginBloc() : super(LoginInitialState()) {
    userRepository = UserRepository();
  }

  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginButtonPressedEvent) {
        yield LoginLoadingState();
        var user = await userRepository.signInWithEmailAndPassword(
            event.email, event.password);
        yield LoginSuccessState(user: user);
      }
    } catch (e) {
      yield LoginFailureState(message: e.toString());
    }
  }
}
