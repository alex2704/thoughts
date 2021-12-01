import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:thoughts/services/splash_screen_bloc/splash_screen_state.dart';
import 'package:thoughts/theme/colors.dart';
import 'package:thoughts/views/feed_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashScreenBloc> _buildBody (BuildContext context) {
    return BlocProvider(
        create: (context) => SplashScreenBloc(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: CustomColors.orange,
          child: Center(
            child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
              builder: (context, state) {
                if ((state is InitialSplashScreenState) || (state is LoadingSplashScreenState)) {
                  return Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('THOUGHTS', style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            letterSpacing: 15,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                      child:Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset('assets/images/splash.png'))),
                    ]
                  );
                } else if (state is LoadedSplashScreenState) {
                  return const FeedScreen();
                }
                return Container();
              },
            ),
          ),
        )
    );
  }

}