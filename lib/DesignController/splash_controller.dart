import 'dart:async';
import 'package:get/get.dart';
import 'package:gpayapp/OnBoardingScreen/onboarding_screen.dart';
import 'package:gpayapp/RoutScreen/rout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class SplashController extends GetxController{
  @override
  void onInit() {
    Timer(
      Duration(seconds: 5),
          () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            String? tok = prefs.getString(tokenKey);
            if(tok != null && tok!=''){
              Get.off(RoutScreen());
            }else{
              Get.off(OnBoardingScreen());
            }
          },
    );
    super.onInit();
  }
}