import 'dart:developer' as developer;
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/services/auth_bloc/auth_bloc.dart';
import 'package:thoughts/services/auth_bloc/auth_event.dart';
import 'package:thoughts/services/auth_bloc/auth_state.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_event.dart';
import 'package:thoughts/theme/custom_theme.dart';
import 'package:thoughts/views/feed_screen.dart';
import 'package:thoughts/views/login_screen.dart';
import 'package:thoughts/views/onboarding_screen.dart';
import 'package:thoughts/views/post_screen.dart';
import 'package:thoughts/views/registration_screen.dart';
import 'package:thoughts/views/splash_screen.dart';

import 'color_block.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     home: BlocProvider(
  //       create: (context) => ColorBloc(Colors.red),
  //       child: MyHomePage(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.mainTheme,
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlocProvider(
                  create: (context) => AuthBloc()..add(AppStartedEvent()),
                  child: App(),
                );
              }
              return SplashScreen();
            }));
    // return FutureBuilder(
    //   future: Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       developer.log('done');
    //       return MaterialApp(
    //         theme: CustomTheme.mainTheme,
    //         home: BlocProvider(
    //           create: (context) => AuthBloc(),
    //           child: App(),
    //         ),
    //       );
    //     }
    //     developer.log('default');
    //     return MaterialApp(
    //         home: OnBoardingScreen());
    //   },
    // );
    // return MaterialApp(
    //   theme: CustomTheme.mainTheme,
    //   home: BlocProvider(
    //     create: (context) => AuthBloc(),
    //     child: App(),
    //   ),
      // initialRoute: '/',
    //   routes: {
    //     '/': (context) => const OnBoardingScreen(),
    //     '/feed': (context) => const FeedScreen(),
    //     '/login': (context) => const LoginScreen(),
    //     '/registration': (context) => const RegistrationScreen(),
    //     '/post': (context) => const PostScreen(),
    //   },
    // );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitialState) {
            return LoginScreen();
          } else if (state is AuthenticatedState) {
            return const OnBoardingScreen();
          } else if (state is UnAuthenticatedState) {
            return LoginScreen();
          }
          return const OnBoardingScreen();
        },
      ),
    ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorBloc _bloc = BlocProvider.of<ColorBloc>(context);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('MyApp'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<ColorBloc, Color>(
          builder: (context, currentColor) => AnimatedContainer(
            height: 100,
            width: 100,
            color: currentColor,
            duration: Duration(milliseconds: 500),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              _bloc.add(ColorEvent.event_red);
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              _bloc.add(ColorEvent.event_green);
            },
          )
        ],
      ),
    ));
  }
}
