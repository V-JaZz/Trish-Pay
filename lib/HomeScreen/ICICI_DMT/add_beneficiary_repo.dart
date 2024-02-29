// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/remitter_details.dart';
import 'package:gpayapp/Models/add_bene_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/register_dmt_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'do_money_transfer_repo.dart';

class AddBeneficiaryRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  AddBeneficiaryRepo(this._context);

  add({
    required String mNo,
    required String beneName,
    required String beneBank,
    required String beneAccount,
    required String beneIfsc,
    required String pinCode,
    required String address,
    required String beneMobile,
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
            'Token': tok ?? '',
            'UserId': uId.toString() ?? '',
            'DeviceId': dId ?? '',
            'type': 'addbeneficiary',
            'mobile': mNo,
            'benename': beneName,
            'benebank': beneBank,
            'beneaccount': beneAccount,
            'beneifsc': beneIfsc,
            'dob': '2001-03-30',
            'address': address,
            'pincode': pinCode,
            'benemobile': beneMobile
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      AddBeneResponseModel model = AddBeneResponseModel.fromJson(
          _helper.returnResponse(_context!, response));
      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      if (model.statuscode == 'TXN') {
        DoMoneyTransferRepo doMoneyTransferRepo = DoMoneyTransferRepo(_context);
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
