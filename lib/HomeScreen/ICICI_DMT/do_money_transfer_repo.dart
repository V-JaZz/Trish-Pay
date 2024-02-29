// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/register_dmt.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/remitter_details.dart';
import 'package:gpayapp/Models/doMoneyTransferResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class DoMoneyTransferRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();
  // late String restaurantID;
  // late String emailID;

  DoMoneyTransferRepo(this._context);

  validate(
      { required String mNo,
      }) async {

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
              'type': 'verification',
              'mobile': mNo
            }),
            "");
        print("posting params");
        print(jsonEncode.toString());
        DoMoneyTransferResponseModel model =
        DoMoneyTransferResponseModel.fromJson(_helper.returnResponse(_context!, response));
        // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        if (model.status == 'success') {
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          if(model.statuscode == 'TXN'){
            Get.back();
            Get.to(RemitterDetails(dmt: model));
          }else{
            Get.to(RegisterDMT(mNo: model.data?.mobile??'', stateRep: model.data?.stateresp??''));
          };
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
