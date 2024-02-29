// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/TransactionSuccessFulScreen/transaction_successful_screen.dart';
import 'package:gpayapp/HomeScreen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/do_recharge_response_model.dart';
import '../../Models/login_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../RoutScreen/rout_screen.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../Utils/font_family.dart';
import '../../Utils/images.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class DoRechargeRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  DoRechargeRepo(this._context);

  doRecharge({String? providerId, String? number, String? amount}) async {
    Dialogs.showLoadingDialog(Get.context ?? _context!, _keyLoader);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    try {
      final response = await _helper.post(
          ApiBaseHelper.doRecharge,
          jsonEncode(<String, String>{
            'Token': tok ?? '',
            'UserId': uId.toString() ?? '',
            'DeviceId': dId ?? '',
            'provider_id': providerId ?? '',
            'amount': amount ?? '',
            'number': number ?? ''
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      DoRechargeModel model =
          DoRechargeModel.fromJson(_helper.returnResponse(_context!, response));
      if (model.statuscode == 200) {
        Get.back();
        Get.defaultDialog(
          backgroundColor: ColorResources.white,
          contentPadding: EdgeInsets.zero,
          title: "",
          titlePadding: EdgeInsets.zero,
          content: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorResources.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: boldText(
                            "Transaction ${model.status![0].toUpperCase()}${model.status!.substring(1).toLowerCase()}",
                            ColorResources.blue1D3,
                            20),
                      ),
                      SizedBox(height: 3),
                      Center(
                        child: regularText(DateTime.now().toString(),
                            ColorResources.grey6B7, 13),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mobile_friendly_rounded,
                            color: ColorResources.blue1D3,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          boldText("$number", ColorResources.blue1D3, 16),
                        ],
                      ),
                      SizedBox(height: 18),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Operator ID :", ColorResources.grey6B7, 12),
                          boldText(model.payid, ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: regularText("Transaction ID : ",
                                  ColorResources.grey6B7, 12)),
                          Expanded(
                            child: Text(
                              model.refno.toString(),
                              textAlign: TextAlign.end,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontFamily: TextFontFamily.ROBOTO_BOLD,
                                  fontSize: 14,
                                  color: ColorResources.blue1D3),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Description - ", ColorResources.grey6B7, 12),
                          boldText(
                              model.description, ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mediumText("Amount : ", ColorResources.grey6B7, 16),
                          boldText("₹$amount", ColorResources.blue1D3, 20),
                        ],
                      ),
                      SizedBox(height: 20),
                      containerButton(() {
                        Get.offAll(RoutScreen());
                      }, "Ok"),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -70,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: model.status == 'success'
                          ? Colors.green
                          : (model.status == 'pending'
                              ? Color(0xFFDEBA28)
                              : Color(0xFFB72F12)),
                      shape: BoxShape.circle),
                  child: Center(
                      child: Icon(
                    model.status == 'success'
                        ? Icons.check_circle_outline_rounded
                        : (model.status == 'pending'
                            ? Icons.access_time_rounded
                            : Icons.close_rounded),
                    color: Colors.white,
                    size: 45,
                  )),
                ),
              ),
            ],
          ),
        );
      } else {
        Get.back();
        showBannerMessage(model.message ?? '', _context!);
      }
    } catch (e) {
      print(e.toString());
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }
}
