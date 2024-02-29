// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/icici_dmt.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/remitter_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/register_dmt_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'do_money_transfer_repo.dart';

class RegisterDmtRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  RegisterDmtRepo(this._context);

  register(
      { required String mNo,
        required String fName,
        required String lName,
        required String pinCode,
        required String stateResp,
        required String otp,
      }) async {

    late DoMoneyTransferRepo doMoneyTransferRepo = DoMoneyTransferRepo(_context!);

    Dialogs.showLoadingDialog(_context!, _keyLoader);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    try {
      final response = await _helper.post(
          ApiBaseHelper.doMoneyTransfer,
          jsonEncode(<String, String>{
            'Token': tok??'',
            'UserId': uId.toString()??'',
            'DeviceId': dId??'',
            'mobile': mNo,
            'type': 'registration',
            'fname': fName,
            'lname': lName,
            'otp': otp,
            'dob': '2023-02-14',
            'pincode': pinCode,
            'stateresp': stateResp,
            'gst_state': '07'
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      RegisterDmtResponseModel model =
      RegisterDmtResponseModel.fromJson(_helper.returnResponse(_context!, response));
      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      if (model.status == 'success') {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        doMoneyTransferRepo.validate(mNo: mNo);
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
