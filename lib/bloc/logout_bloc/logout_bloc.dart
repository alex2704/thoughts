import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/repositories/user_repository.dart';
import 'package:thoughts/bloc/logout_bloc/logout_event.dart';
import 'package:thoughts/bloc/logout_bloc/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  late UserRepository userRepository;

  LogoutBloc() : super(LogoutInitialState()) {
    userRepository = UserRepository();
  }

  LogoutState get initialState => LogoutInitialState();

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is LogoutButtonPressedEvent) {
      await userRepository.signOut();
      yield LogoutSuccessState();
    }
  }
}
