import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_AEPS/kyc_verify_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/common_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import 'package:http/http.dart' as http;

import '../../common/common.dart';
import '../../constants/constants.dart';

class KycCheck extends StatefulWidget {
  final String mobile;
  final String panCard;
  final String aadhaarCard;
  final String email;

  const KycCheck(
      {Key? key,
      required this.mobile,
      required this.panCard,
      required this.aadhaarCard,
      required this.email})
      : super(key: key);

  @override
  State<KycCheck> createState() => _KycCheckState();
}

class _KycCheckState extends State<KycCheck> {
  TextEditingController mobile = TextEditingController();
  TextEditingController panCard = TextEditingController();
  TextEditingController aadhaarCard = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    mobile.text = widget.mobile;
    panCard.text = widget.panCard;
    aadhaarCard.text = widget.aadhaarCard;
    email.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 18, top: 8, bottom: 8),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            mediumText("Mobile Number  ", ColorResources.grey6B7, 13),
            SizedBox(height: 5),
            textField2(widget.mobile, mobile, TextInputType.name, false,
                (value) {}, null, true),
            SizedBox(height: 15),
            mediumText("Email Address  ", ColorResources.grey6B7, 13),
            SizedBox(height: 5),
            textField2(widget.email, email, TextInputType.name, false,
                (value) {}, null, true),
            SizedBox(height: 15),
            mediumText("Pan Card Number  ", ColorResources.grey6B7, 13),
            SizedBox(height: 5),
            textField2(widget.panCard, panCard, TextInputType.name, false,
                (value) {}, null, true),
            SizedBox(height: 15),
            mediumText("Aadhaar Card Number  ", ColorResources.grey6B7, 13),
            SizedBox(height: 5),
            textField2(widget.aadhaarCard, aadhaarCard, TextInputType.name,
                false, (value) {}, null, true),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Dialogs.showLoadingDialog(context, GlobalKey());
                sendOTP();
              },
              child: Container(
                height: 52,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.blue1D3,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: boldText("Verify", ColorResources.white, 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendOTP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
      'POST',
      Uri.parse('https://trishpay.com/api/Android/Paysprint/doAeps'),
    );
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId.toString(),
      'transactionType': 'useronboard',
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse streamedResponse =
          await request.send().timeout(const Duration(seconds: 30));

      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body);
        print(parsed.toString());
        CommonModel userModel = CommonModel.fromJson(parsed);
        if (userModel.status == 'TXN') {
          Get.back();
          Get.off(KycVerifyOTP(mobile: widget.mobile));
        } else {
          Get.back();
          showBannerMessage(userModel.message!, context);
        }
      } else {
        Get.back();
        print(streamedResponse.reasonPhrase);
      }
    } catch (e) {
      Get.back();
      showBannerMessage('Request timed out, please try again later!', context);
      print('Request timed out, please try again later!');
    }
  }
}
