import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/assets_constant.dart';
import 'package:the_qa/_util/routes.dart';
import 'package:the_qa/splash/controller/splash_bloc.dart';
import 'package:the_qa/splash/controller/splash_event.dart';
import 'package:the_qa/splash/controller/splash_state.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()
        ..add(
          MoveToHomeScreen(),
        ),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.moveToNextScreen) {
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                Navigator.popAndPushNamed(context, RouteNames.home);
              }
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                height: 500,
                width: 500,
                AssetsConstant.appLogo,
              ),
            ),
          );
        },
      ),
    );
  }
}
