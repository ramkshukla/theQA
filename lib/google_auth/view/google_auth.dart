import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_qa/_util/assets_constant.dart';
import 'package:the_qa/_util/routes.dart';
import 'package:the_qa/_util/string_constants.dart';
import 'package:the_qa/google_auth/controller/google_auth_bloc.dart';
import 'package:the_qa/google_auth/controller/google_auth_event.dart';
import 'package:the_qa/google_auth/controller/google_auth_state.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleAuthBloc(),
      child: const GoogleAuthUI(),
    );
  }
}

class GoogleAuthUI extends StatelessWidget {
  const GoogleAuthUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state.signInSuccess) {
          Navigator.popAndPushNamed(context, RouteNames.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(GoogleAuthConstants.title),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsConstant.appLogo,
                    height: 300,
                    width: 300,
                  ),
                  // const Text(
                  //   GoogleAuthConstants.heading,
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  // const Text(
                  //   GoogleAuthConstants.subHeading,
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  const SizedBox(height: 100),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue,
                  //     elevation: 0.0,
                  //     minimumSize: const Size(200, 50),

                  //   ),
                  //   onPressed: () {
                  //     context.read<GoogleAuthBloc>().add(SignInEvent());
                  //   },
                  //   child: const Text(
                  //     GoogleAuthConstants.google,
                  //     style: TextStyle(color: Colors.white, fontSize: 17),
                  //   ),
                  // )

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        side: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.read<GoogleAuthBloc>().add(SignInEvent());
                    },
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    iconAlignment: IconAlignment.start,
                    icon: Image.asset(
                      AssetsConstant.google,
                      height: 18,
                      width: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
