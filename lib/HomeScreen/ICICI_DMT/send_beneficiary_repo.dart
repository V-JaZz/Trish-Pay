// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/register_dmt.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/remitter_details.dart';
import 'package:gpayapp/Models/doMoneyTransferResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/bene_transfer_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../RoutScreen/rout_screen.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class SendBenefeciaryRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  // late String restaurantID;
  // late String emailID;

  SendBenefeciaryRepo(this._context);

  send({
    required String mNo,
    required String beneid,
    required String amount,
    required String benename,
    required String beneaccount,
    required String beneifsc,
    required String benebank,
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
            'type': 'transfer_new',
            'mobile': mNo,
            'beneid': beneid,
            'amount': amount,
            'benename': benename,
            'beneaccount': beneaccount,
            'beneifsc': beneifsc,
            'benebank': benebank,
            'name': benename
          }),
          "");
      print("posting params");
      print(jsonEncode.toString());
      BeneTransferResponseModel model = BeneTransferResponseModel.fromJson(
          _helper.returnResponse(_context!, response));

      if (model.statuscode == "TXN") {
        Get.back();
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
                        child:
                            boldText(model.message, ColorResources.blue1D3, 20),
                      ),
                      SizedBox(height: 3),
                      Center(
                        child:
                            regularText(model.date, ColorResources.grey6B7, 13),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send_to_mobile_rounded,
                            color: ColorResources.blue1D3,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          boldText(benename, ColorResources.blue1D3, 16),
                        ],
                      ),
                      SizedBox(height: 18),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Account Number :", ColorResources.grey6B7, 12),
                          boldText(model.accno, ColorResources.blue1D3, 14),
                        ],
                      ),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText("IFSC :", ColorResources.grey6B7, 12),
                          boldText(model.ifsc, ColorResources.blue1D3, 14),
                        ],
                      ),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "UTR/RRN Number :", ColorResources.grey6B7, 12),
                          boldText(model.payid, ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Transaction ID : ", ColorResources.grey6B7, 12),
                          boldText(model.txnid, ColorResources.blue1D3, 14),
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
                          boldText(model.message, ColorResources.blue1D3, 14),
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
                        Get.back();
                        Get.off(RoutScreen());
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
        Get.back();
        showBannerMessage(model.message ?? '', _context!);
      }
    } catch (e) {
      print(e.toString());
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }
}
