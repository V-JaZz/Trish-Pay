import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Models/dmt_bank_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class GetDmtBankList {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  GetDmtBankList(this._context);

  Future<List<Bank>?> get() async {

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
            'type': 'dmt_bank_list'
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      DmtBankListResponseModel model =
      DmtBankListResponseModel.fromJson(_helper.returnResponse(_context!, response));
      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      if (model.statuscode == 'TXN') {
        return model.data;
      } else {
        showBannerMessage(model.message!, _context!);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;

  }
}
