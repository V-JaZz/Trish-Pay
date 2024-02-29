import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/rout_controller.dart';
import 'package:gpayapp/RoutScreen/rout_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class TransactionSuccessFulScreen extends StatelessWidget {
  TransactionSuccessFulScreen({Key? key}) : super(key: key);

  final RoutController routController = Get.put(RoutController());

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
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.only(left: 55,right: 25),
              child: SvgPicture.asset(Images.transactionSuccessFulImage),
            ),
            SizedBox(height: 40),
            boldText("Transfer Successful", ColorResources.blue1D3, 24),
            SizedBox(height: 12),
            regularText(
                "Transfers are reviewed which may result in\n delays or funds being frozen",
                ColorResources.grey6B7,
                11,
                TextAlign.center),
            SizedBox(height: 40),
            Container(
              height: 65,
              width: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.greyF9F,
              ),
              child: Center(
                child: boldText("₹ 100", ColorResources.blue1D3, 32),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: containerButton(() {
                    routController.pageIndex.value == 2;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RoutScreen()),
                        (Route<dynamic> route) => false);
                  }, "Back to Home"),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
