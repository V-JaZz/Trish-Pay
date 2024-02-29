import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/TransactionSuccessFulScreen/transaction_successful_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class PayScreen2 extends StatelessWidget {
  PayScreen2({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  Padding(
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 25, left: 125, right: 125),
                          child: Divider(
                              thickness: 6, color: ColorResources.greyE1E),
                        ),
                        boldText(
                            "Select your bank", ColorResources.blue1D3, 20),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorResources.white,
                            border: Border.all(
                                color: ColorResources.greyE5E, width: 1),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            leading: Image.asset(Images.bobImage),
                            title: boldText("Bank of Baroda ****3137",
                                ColorResources.blue1D3, 16),
                            subtitle: mediumText(
                                "Saving Account", ColorResources.blue1D3, 16),
                            trailing: SvgPicture.asset(
                              Images.checkIcon,
                              color: ColorResources.green1DA,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorResources.greyF9F,
                          ),
                          child: ListTile(
                            leading: SvgPicture.asset(Images.addNewBankImage),
                            title: boldText(
                                "Add new bank", ColorResources.blue1D3, 16),
                            trailing: Icon(Icons.arrow_forward_ios,
                                size: 14, color: ColorResources.blue1D3),
                          ),
                        ),
                        SizedBox(height: 60),
                        containerButton(() {
                          Get.back();
                        }, "Confirm"),
                      ],
                    ),
                  ),
                  backgroundColor: ColorResources.white,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorResources.white,
                  border: Border.all(color: ColorResources.greyE5E, width: 1),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  leading: Image.asset(Images.bobImage),
                  title: boldText(
                      "Bank of Baroda ****3137", ColorResources.blue1D3, 16),
                  subtitle:
                      mediumText("Saving Account", ColorResources.blue1D3, 16),
                  trailing: SvgPicture.asset(
                    Images.arrowDownIcon,
                    color: ColorResources.grey9CA,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            boldText("₹ 100", ColorResources.blue1D3, 40),
            SizedBox(height: 25),
            Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.greyF3F,
              ),
              child: Center(
                child: regularText("Food", ColorResources.grey6B7, 14),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: containerButton(() {
                  Get.to(TransactionSuccessFulScreen());
                }, "Pay ₹100"),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset(Images.powerdByLogo),
            ),
          ],
        ),
      ),
    );
  }
}
