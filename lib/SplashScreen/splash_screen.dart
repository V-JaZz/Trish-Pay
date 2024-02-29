import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/splash_controller.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/images.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: SvgPicture.asset(Images.trishPayLog),
        ),
      ),
    );
  }
}
