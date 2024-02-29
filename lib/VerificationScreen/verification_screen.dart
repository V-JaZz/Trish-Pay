import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'otp_verify_repo.dart';

class VerificationScreen extends StatefulWidget {
  final String? countryCode;
  final String? phoneNo;
  final String? password;
  final String? deviceId;
  final String? lat;
  final String? long;

  VerificationScreen({required this.countryCode,
    required this.phoneNo,
    required this.deviceId,
    required this.password,
    required this.lat,
    required this.long});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late OtpVerifyRepository _otpVerifyRepository;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    );
  }

  @override
  void initState() {
    _otpVerifyRepository = OtpVerifyRepository(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            InkWell(
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
            SizedBox(height: 30),
            boldText("Verify it’s you", ColorResources.blue1D3, 24),
            SizedBox(height: 12),
            mediumText(
                "We send a code to ( ***** ${widget.phoneNo?.substring(
                    5)} ). Enter it here to verify your identity",
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
              validateOTP();
            }, "CONTINUE"),
          ],
        ),
      ),
    );
  }

  validateOTP() {
    print("countryCode : ${widget.countryCode}");
    print("phoneNo : ${widget.phoneNo}");
    print("password : ${widget.password}");
    print("deviceId : ${widget.deviceId}");
    print("latitude : ${widget.lat}");
    print("longitude : ${widget.long}");
    print("otp : ${_pinPutController.text}");

    _otpVerifyRepository.verify(
        cCode: widget.countryCode,
        pNo: widget.phoneNo,
        pass: widget.password,
        androidId: widget.deviceId,
        lat: widget.lat,
        long: widget.long,
        otp: _pinPutController.text);
  }
}
