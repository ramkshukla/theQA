import 'package:flutter/material.dart';

abstract class SplashEvent {
  SplashEvent();
}

class MoveToHomeScreen extends SplashEvent {
  final BuildContext scontext;
  MoveToHomeScreen({required this.scontext});
}
