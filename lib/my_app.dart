import 'package:flutter/material.dart';
import 'package:the_qa/_util/routes.dart';
import 'package:the_qa/google_auth/view/google_auth.dart';
import 'package:the_qa/home/view/home.dart';
import 'package:the_qa/splash/view/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
      // const Home(),
      routes: {
        RouteNames.login: (context) => const GoogleAuth(),
        RouteNames.home: (context) => const Home()
      },
    );
  }
}
