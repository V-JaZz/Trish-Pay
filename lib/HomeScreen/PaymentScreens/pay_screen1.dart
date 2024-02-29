import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/PaymentScreens/pay_screen2.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class PayScreen1 extends StatelessWidget {
  PayScreen1({Key? key}) : super(key: key);

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
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: ColorResources.black,
              size: 25,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                // Get.back();
              },
              child: Icon(
                Icons.more_vert,
                color: ColorResources.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorResources.black, width: 1.5),
                color: ColorResources.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(Images.lindaJohn),
              ),
            ),
            SizedBox(height: 7),
            boldText("Paying Linda John", ColorResources.blue1D3, 22),
            SizedBox(height: 6),
            regularText("+91 ***** *7890", ColorResources.blue1D3, 14),
            regularText("Banking name: LINDA JOHN\nDOE", ColorResources.blue1D3,
                14, TextAlign.center),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldText("₹ 0", ColorResources.grey6B7, 40),
                SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: ColorResources.black,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    width: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.greyF3F,
              ),
              child: Center(
                child: regularText("Add a note", ColorResources.grey6B7, 14),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: containerButton(() {
                    Get.to(PayScreen2());
                  }, "Next"),
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
