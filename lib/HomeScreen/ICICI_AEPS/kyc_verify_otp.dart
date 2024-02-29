import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/common_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

import 'icici_aeps.dart';

class KycVerifyOTP extends StatefulWidget {
  final String mobile;

  const KycVerifyOTP({
    Key? key,
    required this.mobile,
  }) : super(key: key);

  @override
  State<KycVerifyOTP> createState() => _KycVerifyOTPState();
}

class _KycVerifyOTPState extends State<KycVerifyOTP> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    );
  }

  @override
  void initState() {
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
            SizedBox(height: 30),
            boldText("Verify it’s you", ColorResources.blue1D3, 24),
            SizedBox(height: 12),
            mediumText(
                "We send a code to ( ***** ${widget.mobile.substring(5)} ). Enter it here to verify your identity",
                ColorResources.grey9CA,
                16),
            SizedBox(height: 27),
            Container(
              color: ColorResources.white,
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(
                  fontFamily: TextFontFamily.ROBOTO_BOLD,
                  fontSize: 24,
                  color: ColorResources.blue1D3,
                ),
                // cursorColor: ColorResources.orangeF97,
                eachFieldHeight: 50,
                eachFieldWidth: 50,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorResources.blue1D3,
                  ),
                  color: ColorResources.greyF9F,
                ),
                selectedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: ColorResources.blue1D3,
                  // ),
                  color: ColorResources.greyF9F,
                ),
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: ColorResources.blue1D3,
                  // ),
                  color: ColorResources.greyF9F,
                ),
                disabledDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResources.greyF9F,
                  border: Border.all(
                    color: ColorResources.blue1D3,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: boldText("Resend Code", ColorResources.green1DA, 16),
            ),
            SizedBox(height: 65),
            containerButton(() {
              Dialogs.showLoadingDialog(context, GlobalKey());
              validateOTP();
            }, "CONTINUE"),
          ],
        ),
      ),
    );
  }

  void validateOTP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/Paysprint/doAeps'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId.toString(),
      'transactionType': 'useronboard_otp',
      'otp': _pinPutController.text
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      CommonModel userModel = CommonModel.fromJson(parsed);
      if (userModel.status == 'TXN') {
        Get.back();
        await Get.dialog(AlertDialog(
          title: Text('Verified'),
          content: Text(userModel.message.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                  Get.off(ICICIAEPS());
                },
                child: const Text('Okay',
                    style: TextStyle(color: ColorResources.blue1D3)))
          ],
        ));
      } else {
        Get.back();
        showBannerMessage(userModel.message!, context);
      }
    } else {
      Get.back();
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }
}
