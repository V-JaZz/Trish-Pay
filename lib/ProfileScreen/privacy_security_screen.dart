import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/variable_controller.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class PrivacyAndSecurityScreen extends StatelessWidget {
  PrivacyAndSecurityScreen({Key? key}) : super(key: key);

  final VariableController variableController = Get.put(VariableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: boldText("Privacy & Security", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Images.dataPersonlizationImage),
                  ),
                ),
                title: mediumText(
                    "Data & Personalization", ColorResources.blue1D3, 16),
                subtitle: regularText("Manage how your info is saved and used",
                    ColorResources.grey6B7, 12),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Images.lockImage),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child:  mediumText("Enable app lock", ColorResources.blue1D3, 16),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: regularText(
                      "Secure your app using your screen"
                      "lock or Google PIN so only you can "
                      "access it",
                      ColorResources.grey6B7,
                      12),
                ),
                trailing: Obx(
                  () => Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      onChanged: (val) =>
                          variableController.switchIsOpen.toggle(),
                      value: variableController.switchIsOpen.value,
                      activeColor: ColorResources.green1DA,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: mediumText(
                    "Manage your app lock", ColorResources.green1DA, 14),
              ),
              SizedBox(height: 25),
              ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Images.otpImage),
                  ),
                ),
                title: mediumText("Get OTP code", ColorResources.blue1D3, 16),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: regularText(
                      "Enter this one-time code when you call \ngoogle Pay Support",
                      ColorResources.grey6B7,
                      12),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Images.blockedImage),
                  ),
                ),
                title: mediumText("Blocked people", ColorResources.blue1D3, 16),
                subtitle: regularText("See and edit people you’ve blocked",
                    ColorResources.grey6B7, 12),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(Images.search),
                  ),
                ),
                title: mediumText("How people find you on Google Pay",
                    ColorResources.blue1D3, 16),
                subtitle: regularText("Manage your profile preferences",
                    ColorResources.grey6B7, 12),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
