import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class VoucherDetailScreen extends StatelessWidget {
  VoucherDetailScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.only(left: 18,top: 8,bottom: 8),
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
        title: boldText("Amazon", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(Images.amazonImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                boldText("23% Off", ColorResources.blue1D3, 24),
                regularText("Aug 16-17", ColorResources.grey6B7, 13),
                SizedBox(height: 12),
                Divider(thickness: 1, color: ColorResources.greyE5E),
                SizedBox(height: 12),
                boldText("What’s inside", ColorResources.blue1D3, 18),
                SizedBox(height: 6),
                regularText(
                    "A Limited time 40% cashback on every product"
                    "you buy on amazon Website.",
                    ColorResources.grey6B7,
                    15),
                SizedBox(height: 22),
                boldText("How to redeem", ColorResources.blue1D3, 18),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle,size: 6,color: ColorResources.grey6B7),
                    ),
                    SizedBox(width: 10),
                    regularText(
                        "Once you claim the voucher, you’ll directed to"
                        "\nthe amazon website ",
                        ColorResources.grey6B7,
                        15),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle,size: 6,color: ColorResources.grey6B7),
                    ),
                    SizedBox(width: 10),
                    regularText(
                        "you have 72 hours to use this code after"
                        "\nactivations before the code expires.",
                        ColorResources.grey6B7,
                        15),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.circle,size: 6,color: ColorResources.grey6B7),
                    SizedBox(width: 10),
                    regularText(
                        "you will get 40% cash back within 24 hours",
                        ColorResources.grey6B7,
                        15),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.circle,size: 6,color: ColorResources.grey6B7),
                    SizedBox(width: 10),
                    regularText(
                        "after the order.",
                        ColorResources.grey6B7,
                        15),
                  ],
                ),
                SizedBox(height: 70),
                containerButton((){}, "CLAIM"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
