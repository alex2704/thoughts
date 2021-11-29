import 'package:flutter/cupertino.dart';

@immutable
abstract class SplashScreenState {}

class InitialSplashScreenState extends SplashScreenState {}

class LoadingSplashScreenState extends SplashScreenState {}

class LoadedSplashScreenState extends SplashScreenState {}