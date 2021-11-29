import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_event.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(InitialSplashScreenState());

  SplashScreenState get initialState => InitialSplashScreenState();

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async*{
    if (event is NavigateToStartScreenEvent) {
      yield LoadingSplashScreenState();
      await Future.delayed(Duration(seconds: 4));
      yield LoadedSplashScreenState();
    }
  }
}