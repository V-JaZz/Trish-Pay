import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';

class SelectProviderBillPaymentScreen extends StatelessWidget {
  SelectProviderBillPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: true,
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
        title: boldText("Airtel Digital TV", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorResources.white,
                border: Border.all(color: ColorResources.greyE5E, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(Images.airtelCard2, height: 50, width: 50),
                        SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                                "Subscriber ID", ColorResources.grey6B7, 12),
                            boldText("98155846", ColorResources.blue1D3, 16),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(thickness: 1, color: ColorResources.greyE5E),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                                "Consumer Name:", ColorResources.grey6B7, 12),
                            SizedBox(height: 10),
                            regularText(
                                "Monthly Amount:", ColorResources.grey6B7, 12),
                          ],
                        ),
                        SizedBox(width: 35),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText("John Doe", ColorResources.blue1D3, 14),
                            SizedBox(height: 5),
                            boldText("₹400", ColorResources.blue1D3, 14),
                          ],
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
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: boldText("₹", ColorResources.blue1D3, 30),
                        ),
                        hintText: "Enter amount",
                        hintStyle: TextStyle(
                          color: ColorResources.grey9CA,
                          fontSize: 20,
                          fontFamily: TextFontFamily.ROBOTO_MEDIUM,
                        ),
                        filled: true,
                        fillColor: ColorResources.greyF9F,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.greyF9F, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.greyF9F, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.greyF9F, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    regularText("Recommended", ColorResources.grey6B7, 10),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorResources.white,
                            border: Border.all(
                                color: ColorResources.blue1D3, width: 0.5),
                          ),
                          child: Center(
                            child: boldText("₹400", ColorResources.blue1D3, 16),
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorResources.white,
                            border: Border.all(
                                color: ColorResources.blue1D3, width: 0.5),
                          ),
                          child: Center(
                            child: boldText("₹500", ColorResources.blue1D3, 16),
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorResources.white,
                            border: Border.all(
                                color: ColorResources.blue1D3, width: 0.5),
                          ),
                          child: Center(
                            child: boldText(
                                "₹1,400", ColorResources.blue1D3, 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            containerButton(() {}, "Proceed To Pay"),
          ],
        ),
      ),
    );
  }
}
