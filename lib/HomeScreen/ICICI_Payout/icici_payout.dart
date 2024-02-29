import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/send_beneficiary_repo.dart';
import 'package:gpayapp/Models/common_model.dart';
import 'package:gpayapp/ProfileScreen/edit_account_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/bene_transfer_response_model.dart';
import '../../Models/doMoneyTransferResponseModel.dart';
import '../../Models/icici_payout_details_model.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'add_bank_account.dart';

class ICICIPayout extends StatefulWidget {
  @override
  State<ICICIPayout> createState() => _ICICIPayout();
}

class _ICICIPayout extends State<ICICIPayout> {
  TextEditingController amount = TextEditingController();
  IciciPayoutDetailModel? model;

  @override
  void initState() {
    loadPayoutDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorResources.greyE5E, width: 1),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: ColorResources.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        title: boldText("ICICI Payout", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              boldText("Bank Details", ColorResources.grey6B7, 16),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.off(AddBankAccount(banks: model!.banks!));
                },
                child: Container(
                  height: 36,
                  width: Get.width / 3,
                  decoration: BoxDecoration(
                    color: ColorResources.blue1D3,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: boldText("+ Add Bank", ColorResources.white, 14),
                  ),
                ),
              ),
              for (int i = 0; i < (model?.bankList?.length ?? 0); i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.greyF3F, width: 1),
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(top: 25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 15),
                              boldText("Name", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText(
                                  "Bank Name ", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText(
                                  "Account Number", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText("IFSC", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText("Status", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              if (model?.bankList![i].status == 1)
                                InkWell(
                                  onTap: () {
                                    sendPayoutDailog(
                                      model?.bankList![i].name,
                                      model?.bankList![i].bankname,
                                      model?.bankList![i].account,
                                      model?.bankList![i].ifsc,
                                      model?.bankList![i].id.toString(),
                                      model?.bankList![i].userId.toString(),
                                    );
                                  },
                                  child: Container(
                                    height: 36,
                                    width: Get.width / 4,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: ColorResources.blue1D3),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: boldText(
                                          "Send", ColorResources.blue1D3, 14),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 15),
                              boldText(model?.bankList![i].name,
                                  ColorResources.blue1D3, 14, TextAlign.right),
                              SizedBox(height: 15),
                              Text(
                                model?.bankList![i].bankname ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: TextFontFamily.ROBOTO_BOLD,
                                    fontSize: 14,
                                    color: ColorResources.blue1D3),
                              ),
                              SizedBox(height: 15),
                              boldText(model?.bankList![i].account,
                                  ColorResources.blue1D3, 14),
                              SizedBox(height: 15),
                              boldText(model?.bankList![i].ifsc,
                                  ColorResources.blue1D3, 14),
                              SizedBox(height: 15),
                              boldText(
                                  model?.bankList![i].status == 0
                                      ? 'Deactivated'
                                      : 'Active',
                                  model?.bankList![i].status == 0
                                      ? ColorResources.orangeFB9
                                      : Colors.green,
                                  14),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void loadPayoutDetails() async {
    Future.delayed(Duration(microseconds: 500), () {
      Dialogs.showLoadingDialog(context, GlobalKey<State>());
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://trishpay.com/api/Android/ICICIPayout/doPayout/index'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? ''
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      IciciPayoutDetailModel userModel =
          IciciPayoutDetailModel.fromJson(parsed);
      print('payout');
      print(userModel.toJson());
      setState(() {
        model = userModel;
      });
      return null;
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

  void sendPayoutDailog(String? name, String? bankname, String? accno,
      String? ifsc, String? id, String? bId) {
    String sendType = 'IMPS';
    Get.defaultDialog(
        title: '$name',
        textConfirm: 'Send',
        confirmTextColor: Colors.white,
        buttonColor: ColorResources.blue1D3,
        cancelTextColor: ColorResources.blue1D3,
        titlePadding: EdgeInsets.only(top: 20),
        textCancel: 'Cancel',
        onConfirm: () {
          Dialogs.showLoadingDialog(context, GlobalKey<State>());
          sendBeneficiary(amount.text,
              sendType == 'IMPS' ? '1' : (sendType == 'NEFT' ? '2' : '3'), id);
        },
        contentPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              mediumText("Bank Name", ColorResources.grey6B7, 14),
              SizedBox(height: 5),
              mediumText(bankname, ColorResources.blue1D3, 14),
              SizedBox(height: 10),
              mediumText("Account Number", ColorResources.grey6B7, 14),
              SizedBox(height: 5),
              mediumText(accno, ColorResources.blue1D3, 14),
              // SizedBox(height: 15),
              // mediumText("IFSC", ColorResources.grey6B7, 14),
              // SizedBox(height: 5),
              // mediumText(ifsc, ColorResources.blue1D3, 14),
              // SizedBox(height: 15),
              SizedBox(height: 15),
              Container(
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResources.greyF9F,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    items: <String>['IMPS', 'NEFT', 'RTGS'].map((String v) {
                      return DropdownMenuItem(
                        value: v,
                        child: mediumText(v, ColorResources.blue1D3, 16),
                      );
                    }).toList(),
                    onChanged: (v) {
                      print(v);
                      setState(() {
                        sendType = v.toString();
                      });
                    },
                    underline: SizedBox.shrink(),
                    hint: mediumText(sendType, ColorResources.blue1D3, 16),
                    isExpanded: true,
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: textField2(
                    "Enter amount", amount, TextInputType.number, true),
              ),
            ],
          ),
        ));
  }

  void sendBeneficiary(String amount, String type, String? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://trishpay.com/api/Android/ICICIPayout/doPayout/transfer'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'bank_id': id ?? '',
      'mode': type,
      'amount': amount
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(parsed.toString());

      BeneTransferResponseModel model =
          BeneTransferResponseModel.fromJson(parsed);

      if (model.statuscode == "TXN") {
        Navigator.of(context).pop();
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
                        child: boldText(model.message ?? 'null',
                            ColorResources.blue1D3, 20),
                      ),
                      SizedBox(height: 3),
                      Center(
                        child: regularText(
                            model.date ?? 'null', ColorResources.grey6B7, 13),
                      ),
                      SizedBox(height: 18),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Account Number :", ColorResources.grey6B7, 12),
                          boldText(model.accno ?? 'null',
                              ColorResources.blue1D3, 14),
                        ],
                      ),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText("IFSC :", ColorResources.grey6B7, 12),
                          boldText(
                              model.ifsc ?? 'null', ColorResources.blue1D3, 14),
                        ],
                      ),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "UTR/RRN Number :", ColorResources.grey6B7, 12),
                          boldText(model.payid ?? 'null',
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
                              "Transaction ID : ", ColorResources.grey6B7, 12),
                          boldText(model.txnid ?? 'null',
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
                              "Description - ", ColorResources.grey6B7, 12),
                          boldText(model.message ?? 'null',
                              ColorResources.blue1D3, 14),
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
                        // Get.offAll(RoutScreen());
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
        Navigator.of(context).pop();
        showBannerMessage(model.message ?? '', context);
      }
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }
}
