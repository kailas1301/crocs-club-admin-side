import 'package:flutter/cupertino.dart';

@immutable
sealed class SplashEvent {}

class SetSplash extends SplashEvent {}
