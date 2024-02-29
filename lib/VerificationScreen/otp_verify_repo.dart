// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/constants/constants.dart';
import '../Models/login_response_model.dart';
import '../Models/otp_verify_response_model.dart';
import '../Networking/api_base_helper.dart';
import '../RoutScreen/rout_screen.dart';
import '../VerificationScreen/verification_screen.dart';
import '../common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  OtpVerifyRepository(this._context);

  verify(
      { String? cCode,
        String? pNo,
        String? pass,
        String? androidId,
        String? lat,
        String? long,
        String? otp,
      }) async {
    if (checkString(otp)) {
      showBannerMessage("Enter OTP", _context!);
    }else{
      Dialogs.showLoadingDialog(_context!, _keyLoader); //invoking login
      var deviceType = "";
      if (Platform.isAndroid) {
        deviceType = "Android";
      } else {
        deviceType = "IOS";
      }
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // String version = packageInfo.version;
      // print(version);
      try {
        final response = await _helper.post(
            ApiBaseHelper.otpValidate,
            jsonEncode(<String, String>{
              'Mobile': pNo??'',
              'Password': pass??'',
              'DeviceId': androidId??'',
              'Lat': lat??'',
              'Log': long??'',
              'Otp': otp??''
            }),
            "");
        print("posting params");
        print(jsonEncode.toString());
        OtpVerifyResponseModel model =
        OtpVerifyResponseModel.fromJson(_helper.returnResponse(_context!, response));
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        if (model.status == 'success') {
          print("model response");
          print(model.status);

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString(tokenKey, model.apptoken??'');
          await prefs.setInt(uIdKey, model.userId??0);
          await prefs.setString(deviceIdKey, androidId??'');

          print("verified");
          Get.offAll(RoutScreen());

        } else {
          showBannerMessage(model.message!, _context!);
        }
      } catch (e) {
        print(e.toString());
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      }
    }
  }
}
