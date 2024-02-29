import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/rout_controller.dart';
import 'package:gpayapp/HistoryScreen/history_screen.dart';
import 'package:gpayapp/HomeScreen/home_screen.dart';
import 'package:gpayapp/ProfileScreen/profile_screen.dart';
import 'package:gpayapp/RoutScreen/customer_info_repo.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/kyc_screen/kyc_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/customer_info_response_model.dart';
import '../constants/constants.dart';

class RoutScreen extends StatefulWidget {
  @override
  State<RoutScreen> createState() => _RoutScreenState();
}

class _RoutScreenState extends State<RoutScreen> {
  final RoutController routController = Get.put(RoutController());
  final pages = [HomeScreen(), HistoryScreen(), ProfileScreen()];

  buildMyNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              blurRadius: 60,
              spreadRadius: 0,
              offset: Offset(0, 4),
              color: ColorResources.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => Column(
                children: [
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        routController.pageIndex.value = 0;
                      },
                      icon: routController.pageIndex.value == 0
                          ? SvgPicture.asset(Images.homeFillIcon)
                          : SvgPicture.asset(Images.homeBlankIcon)),
                  routController.pageIndex.value == 0
                      ? boldText("Home", ColorResources.blue1D3, 12)
                      : regularText("Home", ColorResources.grey6B7, 11),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      routController.pageIndex.value = 1;
                    },
                    icon: routController.pageIndex.value == 1
                        ? SvgPicture.asset(Images.historyFillIcon)
                        : SvgPicture.asset(Images.historyBlankIcon),
                  ),
                  routController.pageIndex.value == 1
                      ? boldText("Ledger", ColorResources.blue1D3, 12)
                      : regularText("Ledger", ColorResources.grey6B7, 11),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      routController.pageIndex.value = 2;
                    },
                    icon: routController.pageIndex.value == 2
                        ? SvgPicture.asset(Images.profileFillIcon)
                        : SvgPicture.asset(Images.profileBlankIcon),
                  ),
                  routController.pageIndex.value == 2
                      ? boldText("Profile", ColorResources.blue1D3, 12)
                      : regularText("Profile", ColorResources.grey6B7, 11),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            pages[routController.pageIndex.value],
            buildMyNavBar(context),
          ],
        ),
      ),
    );
  }
}
