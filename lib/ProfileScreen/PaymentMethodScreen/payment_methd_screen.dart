import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/ProfileScreen/PaymentMethodScreen/add_new_card_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

import '../../HomeScreen/home_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({Key? key}) : super(key: key);

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
        title: boldText("Payment methods", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Container(
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        regularText(
                            "Bank Accounts (1)", ColorResources.grey6B7, 14),
                        mediumText("+  Add Card", ColorResources.blue1D3, 14),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 130,
                      width: 222,
                      decoration: BoxDecoration(
                          color: ColorResources.greyDEE,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1,color: ColorResources.blue1D3)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boldText(bank, ColorResources.blue1D3, 18),
                          SizedBox(height: 10),
                          lightText(ifsc, ColorResources.blue1D3, 16),
                          SizedBox(height: 10),
                          mediumText("********${account?.substring(8) ?? ''}", ColorResources.blue1D3, 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.to(AddNewCardScreen());
              },
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      regularText(
                          "Credit/Debit Cards (0)", ColorResources.grey6B7, 14),
                      SizedBox(height: 15),
                      Container(
                        height: 130,
                        width: 222,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(Images.addCard),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
