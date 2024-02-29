// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/login_response_model.dart';
import '../Networking/api_base_helper.dart';
import '../RoutScreen/rout_screen.dart';
import '../common/common.dart';

class LoginRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  // late String restaurantID;
  // late String emailID;

  LoginRepository(this._context);

  login(
      {String? cCode,
      String? pNo,
      String? pass,
      String? deviceToken,
      String? lat,
      String? long}) async {
    if (checkString(pNo)) {
      showBannerMessage("Enter Phone Number", _context!);
    } else if (checkString(pass)) {
      showBannerMessage("Enter Password", _context!);
    } else {
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
            ApiBaseHelper.login,
            jsonEncode(<String, String>{
              'Mobile': pNo ?? '',
              'Password': pass ?? '',
              'DeviceId': deviceToken ?? '',
              'Lat': lat ?? '',
              'Log': long ?? ''
            }),
            "");
        print("posting params");
        print(jsonEncode.toString());
        LoginResponseModel model = LoginResponseModel.fromJson(
            _helper.returnResponse(_context!, response));
        // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        if (model.status == 'success') {
          print("model response");
          print(model.status);
          // StorageUtil.setData(StorageUtil.keyLoginData, jsonEncode(model.data));
          // StorageUtil.setData(StorageUtil.keyLoginToken, model.data!.token);
          // StorageUtil.setData(StorageUtil.keyEmail, model.data!.email);
          // StorageUtil.setData(
          //     StorageUtil.keyRestaurantId, model.data!.restaurantId);
          // emailID = model.data!.email!;

          // final SharedPreferences prefs = await _prefs;
          // restaurantID = model.data!.restaurantId!;
          print("login");
          // print(restaurantID);
          // prefs.setString('restaurant', restaurantID);
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          // Get.to(VerificationScreen(countryCode: cCode,deviceId: deviceToken,phoneNo: pNo,password: pass,lat: lat,long: long));
          Get.offAll(RoutScreen());
        } else {
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          showBannerMessage(model.message!, _context!);
        }
      } catch (e) {
        print(e.toString());
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      }
    }
  }
}
