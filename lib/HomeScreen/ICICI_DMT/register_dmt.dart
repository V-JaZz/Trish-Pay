import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/do_money_transfer_repo.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/register_dmt_repo.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class RegisterDMT extends StatefulWidget {
  final String mNo;
  final String stateRep;

  RegisterDMT({Key? key, required this.mNo, required this.stateRep})
      : super(key: key);

  @override
  State<RegisterDMT> createState() => _RegisterDMT();
}

class _RegisterDMT extends State<RegisterDMT> {
  late TextEditingController mobileNo;
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController otp = TextEditingController();
  late RegisterDmtRepo registerDmtRepo;

  @override
  void initState() {
    registerDmtRepo = RegisterDmtRepo(context);
    mobileNo = TextEditingController(text: widget.mNo);
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
          padding: EdgeInsets.only(left: 18, top: 8, bottom: 8),
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
        title: boldText("Register", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // regularText(
            //     "Manage your money better by adding another account to make self transfers",
            //     ColorResources.grey6B7,
            //     15),
            SizedBox(height: 15),
            textField2("First name", fName, TextInputType.name, false),
            SizedBox(height: 15),
            textField2("Last Name", lName, TextInputType.name, false),
            SizedBox(height: 15),
            textField2("Mobile number", mobileNo, TextInputType.number, true,
                (value) => {}, null, true),
            SizedBox(height: 15),
            textField2("Pin code", pinCode, TextInputType.number, true),
            SizedBox(height: 15),
            textField2("OTP", otp, TextInputType.number, true),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                doRegister();
              },
              child: Container(
                height: 52,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.blue1D3,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: boldText("Continue", ColorResources.white, 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doRegister() {
    registerDmtRepo.register(
        mNo: mobileNo.text,
        fName: fName.text,
        lName: lName.text,
        pinCode: pinCode.text,
        stateResp: widget.stateRep,
        otp: otp.text);
  }
}
