// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Models/customer_info_response_model.dart';
import '../HomeScreen/home_screen.dart';
import '../Networking/api_base_helper.dart';
import '../WelcomeScreen/welcome_screen.dart';
import '../common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../kyc_screen/kyc_screen.dart';

class CustomerInfoRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  CustomerInfoRepo(this._context);

  Future<CustomerInfoResponseModel?> getUserInfo({
    String? userId,
    String? androidId,
    String? token,
  }) async {
    // Dialogs.showLoadingDialog(_context!, _keyLoader);

    try {
      final response = await _helper.post(
          ApiBaseHelper.customerInfo,
          jsonEncode(<String, String>{
            'Token': token ?? '',
            'DeviceId': androidId ?? '',
            'UserId': userId ?? '',
          }),
          "");

      CustomerInfoResponseModel model =
          CustomerInfoResponseModel.fromJson(jsonDecode(response.body));
      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      if (model.status == 'success') {
        if (model.data?.kyc == 'verified') {
          return model;
        } else {
          Get.off(KycScreen(
            kycStatus: model.data?.kyc ?? '',
            remark: model.data?.remark ?? '',
          ));
        }
      } else if (model.status == 'failure') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, '');
        initLoad = 0;
        Get.off(WelcomeScreen());
      } else {
        showBannerMessage(model.message!, _context!);
      }
    } catch (e) {
      print(e.toString());
      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
    return null;
  }
}
