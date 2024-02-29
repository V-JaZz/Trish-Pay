import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/get_fund_banks_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class GetFundBanksRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  GetFundBanksRepo(this._context);

  Future<GetFundBanksResponseModel?> get() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    try {
      final response = await _helper.post(
          ApiBaseHelper.getFund,
          jsonEncode(<String, String>{
            'Token': tok??'',
            'UserId': uId.toString()??'',
            'DeviceId': dId??'',
            'Type': 'getfundbank'
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());

      GetFundBanksResponseModel model =
      GetFundBanksResponseModel.fromJson(_helper.returnResponse(_context!, response));

      if (model.status == 'success') {
        return model;
      } else {
        showBannerMessage(model.message!, _context!);
      }
    } catch (e) {
      print(e.toString());
      Get.back();
    }
    return null;

  }
}
