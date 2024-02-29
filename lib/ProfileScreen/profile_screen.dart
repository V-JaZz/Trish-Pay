import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/ProfileScreen/PaymentMethodScreen/payment_methd_screen.dart';
import 'package:gpayapp/ProfileScreen/PaymentMethodScreen/select_bank_screen.dart';
import 'package:gpayapp/ProfileScreen/setting_screen.dart';
import 'package:gpayapp/ScannerScreen/show_qrcode_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeScreen/home_screen.dart';
import '../WelcomeScreen/welcome_screen.dart';
import '../constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                boldText("Profile", ColorResources.black, 20),
                SizedBox(height: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                          color: ColorResources.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(ShowQrCodeScreen());
                          },
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: ColorResources.blue1D3,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  left: 40,
                                  child: Image.asset(Images.qrCodeImage,
                                      height: 40, width: 40)),
                            ],
                          ),
                          contentPadding: EdgeInsets.only(top: 15, left: 10),
                          title: boldText(
                              '${name ?? ''} ', ColorResources.blue1D3, 20),
                          subtitle: regularText(
                              "+91 $mobile", ColorResources.grey6B7, 14),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 30,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                            color: ColorResources.greyF9F,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(Images.rewardsEarnedImage),
                              // SizedBox(width: 10),
                              // boldText("₹ 182", ColorResources.blue1D3, 16),
                              // SizedBox(width: 6),
                              // regularText(
                              //     "Rewards Earned", ColorResources.grey6B7, 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SvgPicture.asset(Images.gift),
                    SizedBox(width: 13),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText("Invite friends, get rewards",
                            ColorResources.blue1D3, 12),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            regularText(
                                "Share this code", ColorResources.grey6B7, 12),
                            SizedBox(width: 5),
                            boldText("abcd5j", ColorResources.blue1D3, 12),
                            SizedBox(width: 5),
                            Icon(Icons.copy,
                                color: ColorResources.blue1D3, size: 15),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: boldText("Share", ColorResources.green1B7, 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Get.to(SettingScreen());
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.settings),
                      SizedBox(width: 15),
                      mediumText("Settings", ColorResources.blue1D3, 16),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SvgPicture.asset(Images.help),
                    SizedBox(width: 15),
                    mediumText("Help and feedback", ColorResources.blue1D3, 16),
                  ],
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      backgroundColor: ColorResources.white,
                      contentPadding: EdgeInsets.zero,
                      title: "",
                      titlePadding: EdgeInsets.zero,
                      content: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            boldText("Sign out", ColorResources.blue1D3, 18),
                            SizedBox(height: 10),
                            regularText(
                                "You can always access your content by Signing back in",
                                ColorResources.grey6B7,
                                16,
                                TextAlign.center),
                            SizedBox(height: 20),
                            Divider(
                                color: ColorResources.greyEDE, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: regularText(
                                      "Cancel", ColorResources.blue1D3, 16),
                                ),
                                SizedBox(width: 30),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: ColorResources.greyEDE,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 0,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 30),
                                InkWell(
                                  onTap: () async {
                                    initLoad = 0;
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(tokenKey, '');
                                    Get.offAll(WelcomeScreen());
                                  },
                                  child: mediumText(
                                      "Logout", ColorResources.redD90, 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.logOutImage),
                      SizedBox(width: 15),
                      mediumText("Sign out", ColorResources.blue1D3, 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
