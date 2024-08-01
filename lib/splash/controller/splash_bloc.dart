import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/_util/routes.dart';
import 'package:the_qa/splash/controller/splash_event.dart';
import 'package:the_qa/splash/controller/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {
    "Bloc".logIt;
    on<MoveToHomeScreen>(
      (event, emit) {
        "Called>>>>>".logIt;
        Timer.periodic(const Duration(seconds: 3), (timer) {
          Navigator.popAndPushNamed(event.scontext, RouteNames.home);
        });
      },
    );
  }
}
