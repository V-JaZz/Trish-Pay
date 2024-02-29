import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class BankBalanceScreen extends StatelessWidget {
  BankBalanceScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.only(top: 8, left: 18, bottom: 8),
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
        title: boldText("Bank Balance", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorResources.white,
                border: Border.all(color: ColorResources.greyE5E, width: 1),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                title:
                    boldText("Bank of Baroda 3137", ColorResources.blue1D3, 16),
                subtitle:
                    mediumText("Saving Account", ColorResources.grey6B7, 12),
              ),
            ),
            SizedBox(height: 35),
            mediumText("Account balance", ColorResources.grey6B7, 14),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldText("₹", ColorResources.grey6B7, 38),
                SizedBox(width: 10),
                boldText("18,256", ColorResources.blue1D3, 38),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Image.asset(Images.powerdByLogo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
