import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/domain/repositories/user_repository.dart';
import 'package:thoughts/services/reg_bloc/reg_event.dart';
import 'package:thoughts/services/reg_bloc/reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  late UserRepository userRepository;

  RegBloc () : super(RegInitialState()) {
    userRepository = UserRepository();
  }

  RegState get initialState => RegInitialState();

  @override
  Stream<RegState> mapEventToState(RegEvent event) async*{
    if (event is SignUpButtonPressedEvent) {
      try {
        yield RegLoadingState();
        var user = await userRepository.registerWithEmailAndPassword(event.email, event.password);
        yield RegSuccessfulState(user: user);
      } catch (e) {
        yield RegFailureState(msg: e.toString());
      }
    }
  }
}