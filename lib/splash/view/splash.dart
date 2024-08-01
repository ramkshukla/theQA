import 'package:flutter/material.dart';
import 'package:the_qa/_util/assets_constant.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AssetsConstant.appLogo),
    );
  }
}
