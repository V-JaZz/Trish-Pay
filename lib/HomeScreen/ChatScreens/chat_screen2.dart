import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/PaymentScreens/pay_screen1.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class ChatScreen2 extends StatelessWidget {
  ChatScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Column(
        children: [
          Container(
            color: ColorResources.blue1D3,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorResources.blue1D3,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: ColorResources.greyE5E.withOpacity(0.15),
                            width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: ColorResources.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(Images.lindaJohn, height: 50, width: 50),
                  SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText("Linda John", ColorResources.white, 18),
                      regularText("+91 12345 67890", ColorResources.white, 13),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(Images.lindaJohn, height: 100, width: 100),
                    SizedBox(height: 6),
                    boldText("Linda John", ColorResources.blue1D3, 24),
                    SizedBox(height: 4),
                    regularText("+91 ***** *7890", ColorResources.blue1D3, 16),
                    regularText(
                        "Joined September 2020", ColorResources.grey6B7, 13),
                    SizedBox(height: 14),
                    Container(
                      height: 28,
                      width: 95,
                      decoration: BoxDecoration(
                        color: ColorResources.greyF3F,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: regularText(
                            "May 20, 2022", ColorResources.grey6B7, 12),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 25, bottom: 20),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorResources.greyF9F,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                                color: ColorResources.black.withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText("₹ 500", ColorResources.blue1D3, 26),
                                SizedBox(height: 6),
                                Divider(
                                    thickness: 0.5,
                                    color: ColorResources.greyDEE),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    SvgPicture.asset(Images.checkIcon),
                                    SizedBox(width: 5),
                                    regularText("Payment to You",
                                        ColorResources.blue1D3, 12),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: regularText(
                                      "9:40 PM", ColorResources.grey6B7, 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 95,
                      decoration: BoxDecoration(
                        color: ColorResources.greyF3F,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: regularText(
                            "May 22, 2022", ColorResources.grey6B7, 12),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20, right: 25, bottom: 20),
                        child: Container(
                          height: 45,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: ColorResources.blue1D3,
                          ),
                          child: Center(
                            child: mediumText("Hii", ColorResources.white, 14),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 25, bottom: 20),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorResources.greyF9F,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                                color: ColorResources.black.withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText("₹ 100", ColorResources.blue1D3, 26),
                                SizedBox(height: 6),
                                Divider(
                                    thickness: 0.5,
                                    color: ColorResources.greyDEE),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    SvgPicture.asset(Images.checkIcon),
                                    SizedBox(width: 5),
                                    regularText("Payment to linda",
                                        ColorResources.blue1D3, 12),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: regularText(
                                      "10:11 AM", ColorResources.grey6B7, 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorResources.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                  color: ColorResources.black.withOpacity(0.15),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: containerButton(() {
                          Get.to(PayScreen1());
                        }, "Pay"),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: containerButton(() {}, "Request"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: ColorResources.black,
                    style: TextStyle(
                      color: ColorResources.black,
                      fontSize: 16,
                      fontFamily: TextFontFamily.ROBOTO_REGULAR,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: SvgPicture.asset(Images.doubalArrow),
                      ),
                      hintText: "Write A Message..",
                      hintStyle: TextStyle(
                        color: ColorResources.grey9CA,
                        fontSize: 16,
                        fontFamily: TextFontFamily.ROBOTO_REGULAR,
                      ),
                      filled: true,
                      fillColor: ColorResources.greyF9F,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorResources.greyF9F, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorResources.greyF9F, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorResources.greyF9F, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
