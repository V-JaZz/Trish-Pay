import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/WelcomeScreen/welcome_screen.dart';
import 'package:gpayapp/constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int index = 0;
  List pageViewList = [
    {
      "image": Images.onboarding1,
      "text1": "Welcome to $appName",
      "text2": "Simple and secure way to send, spend, and manage your money."
    },
    {
      "image": Images.onboarding2,
      "text1": "Real-time Payments",
      "text2": "Payments that are initiated and settled "
          "nearly instantaneously from one bank account to another"
    },
    {
      "image": Images.onboarding3,
      "text1": "24/7 Support",
      "text2": "Customers can get help and find "
          "answers to questions as soon as they come up and in real-time."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: pageViewList.length,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (i) {
              setState(
                () {
                  index = i;
                },
              );
            },
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 50, right: 15, bottom: 140),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    index == 0 || index == 1
                        ? InkWell(
                            onTap: () {
                              Get.to(WelcomeScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                lightText("Skip", ColorResources.black, 14),
                                SizedBox(width: 5),
                                Icon(Icons.arrow_forward_ios,
                                    size: 16, color: ColorResources.greyAEA),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    boldText(pageViewList[index]["text1"],
                        ColorResources.blue1D3, 24),
                    Center(
                      child: SizedBox(
                        height: index == 2 ?230:260,
                        width: Get.width,
                        child: SvgPicture.asset(
                          pageViewList[index]["image"],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, bottom: index == 0 ? 20 : 0),
                      child: lightText(pageViewList[index]["text2"],
                          ColorResources.grey6B7, 22, TextAlign.center),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pageViewList.length,
                (position) => Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == position
                          ? ColorResources.blue1D3
                          : ColorResources.greyB3B,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          index == 2
              ? Get.off(WelcomeScreen())
              : pageController.nextPage(
                  duration: 300.milliseconds, curve: Curves.ease);
        },
        elevation: 0,
        backgroundColor: ColorResources.blue1D3,
        child: Icon(
          Icons.arrow_forward_ios,
          color: ColorResources.white,
          size: 25,
        ),
      ),
    );
  }
}
