import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/ProfileScreen/about_screen.dart';
import 'package:gpayapp/ProfileScreen/help_fedback_screen.dart';
import 'package:gpayapp/ProfileScreen/personal_info_screen.dart';
import 'package:gpayapp/ProfileScreen/privacy_security_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../WelcomeScreen/welcome_screen.dart';
import '../constants/constants.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final List<Map> List1 = [
    {
      "image": Images.profileBlankIcon,
      "text": "Personal info",
      "onTap": () {
        Get.to(PersonalInfoScreen());
      },
    },
    {
      "image": Images.privacyAndSecurityImage,
      "text": "Privacy & security",
      "onTap": () {
        Get.to(PrivacyAndSecurityScreen());
      },
    },
  ];

  final List<Map> List2 = [
    {
      "image": Images.lockImage,
      "text": "Lock app",
      "onTap": () {},
    },
    {
      "image": Images.help,
      "text": "Help & feedback",
      "onTap": () {
        Get.to(HelpAndFeedBackScreen());
      },
    },
    {
      "image": Images.aboutImage,
      "text": "About",
      "onTap": () {
        Get.to(AboutScreen());
      },
    },
    // {
    //   "image": Images.logOutImage,
    //   "text": "Sign out",
    //   "onTap": () {
    //     Get.defaultDialog(
    //       backgroundColor: ColorResources.white,
    //       contentPadding: EdgeInsets.zero,
    //       title: "",
    //       titlePadding: EdgeInsets.zero,
    //       content: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20),
    //         child: Column(
    //           children: [
    //             boldText("Sign out", ColorResources.blue1D3, 18),
    //             SizedBox(height: 10),
    //             regularText(
    //                 "You can always access your content by Signing back in",
    //                 ColorResources.grey6B7,
    //                 16,
    //                 TextAlign.center),
    //             SizedBox(height: 20),
    //             Divider(color: ColorResources.greyEDE, thickness: 1),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     Get.back();
    //                   },
    //                   child: regularText("Cancel", ColorResources.blue1D3, 16),
    //                 ),
    //                 SizedBox(width: 30),
    //                 SizedBox(
    //                   height: 50,
    //                   child: VerticalDivider(
    //                     color: ColorResources.greyEDE,
    //                     thickness: 1,
    //                     indent: 10,
    //                     endIndent: 0,
    //                     width: 20,
    //                   ),
    //                 ),
    //                 SizedBox(width: 30),
    //                 InkWell(
    //                   onTap: () async {
    //                     final SharedPreferences prefs = await SharedPreferences.getInstance();
    //                     await prefs.setString(tokenKey,'');
    //                     Get.offAll(WelcomeScreen());
    //                   },
    //                   child: mediumText("Logout", ColorResources.redD90, 16),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // },
  ];

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
        title: boldText("Settings", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: List1.length,
                padding: EdgeInsets.only(top: 30, left: 25, right: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: List1[index]["onTap"],
                    child: Container(
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
                      child: ListTile(
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorResources.greyF6F,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              List1[index]["image"],
                            ),
                          ),
                        ),
                        title: mediumText(
                            List1[index]["text"], ColorResources.blue1D3, 16),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: ColorResources.grey6B7, size: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 1, color: ColorResources.greyF3F),
              ListView.builder(
                itemCount: List2.length,
                padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: List2[index]["onTap"],
                    child: Container(
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
                      child: ListTile(
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorResources.greyF6F,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              List2[index]["image"],
                            ),
                          ),
                        ),
                        title: mediumText(
                            List2[index]["text"], ColorResources.blue1D3, 16),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: ColorResources.grey6B7, size: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
