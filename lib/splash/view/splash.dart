import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/assets_constant.dart';
import 'package:the_qa/_util/extension.dart';
import 'package:the_qa/splash/controller/splash_bloc.dart';
import 'package:the_qa/splash/controller/splash_event.dart';
import 'package:the_qa/splash/controller/splash_state.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    "Buidl methos called".logIt;
    return BlocProvider(
      create: (context) => SplashBloc()
        ..add(
          MoveToHomeScreen(scontext: context),
        ),
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Image.asset(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              AssetsConstant.logo,
            ),
          );
        },
      ),
    );
  }
}
