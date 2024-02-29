// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/aeps_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../RoutScreen/rout_screen.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class AepsTransactionRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  AepsTransactionRepo(this._context);

  Future<AepsResponseModel?> doAeps(
      {String? tType,
      String? mobNo,
      String? ANo,
      String? amt,
      String? nBIN,
      String? data}) async {
    print('nBIN');
    print(nBIN);
    if (checkString(mobNo) ||
        checkString(ANo) ||
        checkString(amt) ||
        checkString(nBIN)) {
      showBannerMessage("All fields are required", _context!);
    } else {
      Dialogs.showLoadingDialog(Get.context ?? _context!, _keyLoader);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tok = prefs.getString(tokenKey);
      String? dId = prefs.getString(deviceIdKey);
      int? uId = prefs.getInt(uIdKey);
      String tTypeCode;
      // String? lat = '43.242142';
      // String? long = '43.242140';

      if (tType == 'Balance Enquiry') {
        tTypeCode = 'BE';
      } else if (tType == 'Mini Statement') {
        tTypeCode = 'MS';
      } else if (tType == 'Cash Withdraw') {
        tTypeCode = 'CW';
      } else {
        tTypeCode = 'M';
      }

      // String bd = """<?xml version="1.0"?>
      // <PidData>
      //   <Resp errCode="0" errInfo="Success." fCount="1" fType="2" nmPoints="43" qScore="73" />
      //   <DeviceInfo dpId="MANTRA.MSIPL" rdsId="MANTRA.WIN.001" rdsVer="1.0.8" mi="MFS100" mc="" dc="0dd351d6-0882-4299-9c19-2173fd894408">
      //     <additional_info>
      //       <Param name="srno" value="2337343" />
      //       <Param name="sysid" value="6C3FEBFB286FABEFBFF0" />
      //       <Param name="ts" value="2023-02-16T16:40:18+05:30" />
      //     </additional_info>
      //   </DeviceInfo>
      //   <Skey ci="20250923"></Skey>
      //   <Hmac></Hmac>
      //   <Data type="X"></Data>
      // </PidData>""";

      try {
        final response = await _helper.post(
            ApiBaseHelper.doAeps,
            jsonEncode(<String, String>{
              'Token': tok ?? '',
              'UserId': uId.toString(),
              'DeviceId': dId ?? '',
              'transactionType': tTypeCode,
              'mobileNumber': mobNo ?? '',
              'adhaarNumber': ANo ?? '',
              'nationalBankIdentificationNumber': nBIN ?? '',
              'biodata': data ?? '',
              // 'biodata': bd,
              'transactionAmount': amt ?? '',
              // 'Lat': lat??'',
              // 'Log': long??'',
            }),
            "");

        print("posting params");
        print(jsonEncode.toString());

        AepsResponseModel model = AepsResponseModel.fromJson(
            _helper.returnResponse(_context!, response));
        // TXN,success,failed,ERR,ISE
        if (model.status == 'TXN' ||
            model.status == 'ERR' ||
            model.status == 'ISE') {
          Get.back();
          showBannerMessage(
              model.message ?? '',
              _context!,
              model.status == 'TXN'
                  ? ColorResources.green1B7
                  : ColorResources.redD90);
          // return model;
        } else if (model.status == 'success' || model.status == 'failure') {
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
                        if (model.transactionType != 'BE')
                          Column(
                            children: [
                              SizedBox(height: 18),
                              Center(
                                child: boldText(model.message.toString(),
                                    ColorResources.blue1D3, 20),
                              ),
                              SizedBox(height: 3),
                              Center(
                                child: regularText(model.createdAt.toString(),
                                    ColorResources.grey6B7, 13),
                              ),
                            ],
                          ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            boldText(model.title.toString(),
                                ColorResources.blue1D3, 16),
                          ],
                        ),
                        SizedBox(height: 18),
                        Divider(thickness: 1, color: ColorResources.greyF3F),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            regularText("Bank :", ColorResources.grey6B7, 12),
                            boldText(model.bank.toString(),
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                        SizedBox(height: 11),
                        Divider(thickness: 1, color: ColorResources.greyF3F),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            regularText(
                                "Aadhaar Number :", ColorResources.grey6B7, 12),
                            boldText(model.aadhar.toString(),
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                        SizedBox(height: 11),
                        Divider(thickness: 1, color: ColorResources.greyF3F),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            regularText(
                                "Transaction ID :", ColorResources.grey6B7, 12),
                            boldText(model.id.toString(),
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                        SizedBox(height: 11),
                        Divider(thickness: 1, color: ColorResources.greyF3F),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            regularText(
                                "UTR/RRN Number :", ColorResources.grey6B7, 12),
                            boldText(model.rrn.toString(),
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                        SizedBox(height: 11),
                        Divider(thickness: 1, color: ColorResources.greyF3F),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            regularText(
                                "Balance :", ColorResources.grey6B7, 12),
                            boldText(model.balance.toString(),
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                        if (model.transactionType == 'MS') SizedBox(height: 11),
                        if (model.transactionType == 'MS')
                          Divider(thickness: 1, color: ColorResources.greyF3F),
                        if (model.transactionType == 'MS') SizedBox(height: 11),
                        if (model.transactionType == 'MS')
                          SizedBox(
                            width: Get.width,
                            height: Get.height / 6,
                            child: ListView(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: [
                                Container(
                                  child: Table(columnWidths: {
                                    0: FlexColumnWidth(6),
                                    1: FlexColumnWidth(3),
                                    2: FlexColumnWidth(5),
                                    3: FlexColumnWidth(7),
                                  }, children: [
                                    TableRow(
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text('DATE',
                                                style: TextStyle(
                                                    color:
                                                        ColorResources.blue1D3,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text('TYPE',
                                                style: TextStyle(
                                                    color:
                                                        ColorResources.blue1D3,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text('AMOUNT',
                                                style: TextStyle(
                                                    color:
                                                        ColorResources.blue1D3,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text('NARRATION',
                                                style: TextStyle(
                                                    color:
                                                        ColorResources.blue1D3,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    )
                                  ]),
                                ),
                                Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(6),
                                      1: FlexColumnWidth(3),
                                      2: FlexColumnWidth(5),
                                      3: FlexColumnWidth(7),
                                    },
                                    border: TableBorder.all(
                                        width: 1,
                                        color: ColorResources.greyC1C,
                                        borderRadius: BorderRadius.circular(3),
                                        style: BorderStyle.solid),
                                    children: List.generate(
                                        model.data?.length ?? 0, (index) {
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                                child: Text(
                                              model.data![index].date ?? '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                                child: Text(
                                              model.data![index].txnType ?? '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                                child: Text(
                                              '₹${double.parse(model.data![index].amount ?? '0').toStringAsFixed(1)}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                                child: Text(
                                              model.data![index].narration ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            )),
                                          ),
                                        ],
                                      );
                                    }))
                              ],
                            ),
                          ),
                        model.transactionType == 'CW' ||
                                model.transactionType == 'M'
                            ? SizedBox(height: 11)
                            : SizedBox.shrink(),
                        model.transactionType == 'CW' ||
                                model.transactionType == 'M'
                            ? Divider(
                                thickness: 1, color: ColorResources.greyF3F)
                            : SizedBox.shrink(),
                        model.transactionType == 'CW' ||
                                model.transactionType == 'M'
                            ? SizedBox(height: 11)
                            : SizedBox.shrink(),
                        model.transactionType == 'CW' ||
                                model.transactionType == 'M'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  mediumText(
                                      "Amount :", ColorResources.grey6B7, 16),
                                  boldText("₹${model.amount}",
                                      ColorResources.blue1D3, 20),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(height: 20),
                        containerButton(() {
                          Get.back();
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
          return model;
        } else {
          Get.back();
          showBannerMessage(model.message ?? '', _context!);
        }
      } catch (e) {
        Get.back();
        print(e.toString());
      }
    }
    return null;
  }
}
