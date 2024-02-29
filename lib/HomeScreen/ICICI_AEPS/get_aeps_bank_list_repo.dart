// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/TransactionSuccessFulScreen/transaction_successful_screen.dart';
import 'package:gpayapp/HomeScreen/home_screen.dart';
import 'package:gpayapp/Models/aeps_bank_list_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/do_recharge_response_model.dart';
import '../../Models/login_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../RoutScreen/rout_screen.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../Utils/images.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class AepsBankListRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  AepsBankListRepo(this._context);

  Future<AepsBankListModel?> getBanks() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    try {
      final response = await _helper.post(
          ApiBaseHelper.doAeps,
          jsonEncode(<String, String>{
            'Token': tok??'',
            'UserId': uId.toString()??'',
            'DeviceId': dId??'',
            'transactionType': 'bank_list_aeps'
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      AepsBankListModel model = AepsBankListModel.fromJson(_helper.returnResponse(_context!, response));
      if (model.statuscode == 'TXN') {
        return model;
      } else {
        showBannerMessage(model.message??'', _context!);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
