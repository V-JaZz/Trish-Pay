import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/variable_controller.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:scratcher/scratcher.dart';

class RewardsDetailScreen extends StatefulWidget {
  RewardsDetailScreen({Key? key}) : super(key: key);

  @override
  State<RewardsDetailScreen> createState() => _RewardsDetailScreenState();
}

class _RewardsDetailScreenState extends State<RewardsDetailScreen> {
  final scratchKey = GlobalKey<ScratcherState>();

  bool isScratch = false;

  final VariableController variableController = Get.put(VariableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.blue1D3.withOpacity(0.6),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.rewardsFullImage),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, right: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.white,
                    ),
                    child: Icon(Icons.close, color: ColorResources.black, size: 25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Scratcher(
                  key: scratchKey,
                  brushSize: 50,
                  threshold: 50,
                  // color: ColorResources.pinkFFE,
                  image: Image.asset(Images.rewardsScratchImage),
                  onChange: (value) {
                    setState((){
                      if (value == 100) {
                        log("Scratch progress: $value%");
                        isScratch = true;
                        log("$isScratch************");
                      }
                    });
                  },
                  child: Container(
                    height: 300,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: SvgPicture.asset(Images.topEllipseImage),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(Images.bottomEllipseImage),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            boldText("₹11", ColorResources.blue1D3, 48),
                            SizedBox(height: 10),
                            regularText("Cashback", ColorResources.grey6B7, 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 5,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorResources.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: ColorResources.white),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 30,
                    left: 30,
                    right: 30,
                    bottom: isScratch == true ? 40 : 120),
                child: isScratch == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText("Congrats!", ColorResources.blue1D3, 28),
                          SizedBox(height: 22),
                          regularText(
                              "Earned on Jan 7, 2020 for paying Bombay Saloon",
                              ColorResources.blue1D3,
                              16),
                          SizedBox(height: 5),
                          regularText("Google ref ID:BDW350F4U635PFLI",
                              ColorResources.blue1D3, 16),
                          SizedBox(height: 60),
                          containerButton(() {}, "Tell your friends"),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText("Scratch Card", ColorResources.blue1D3, 28),
                          SizedBox(height: 22),
                          regularText(
                              "Scratch the card above and you could earn rewards!",
                              ColorResources.blue1D3,
                              16),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
