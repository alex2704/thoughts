import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/repositories/user_repository.dart';
import 'package:thoughts/bloc/auth_bloc/auth_event.dart';
import 'package:thoughts/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late UserRepository userRepository;

  AuthBloc() : super(AuthInitialState()){
    userRepository = UserRepository();
  }

  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent || event is UserSignedInEvent) {
       try {
         var isSignedIn = await userRepository.isSignedIn();
         if (isSignedIn) {
           var user = await userRepository.getCurrentUser();
           yield AuthenticatedState(user: user);
         } else {
           yield UnAuthenticatedState();
         }
       } catch (e) {
         yield UnAuthenticatedState();
       }
    }
  }


}