import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/PromotionScreen/VoucherScreen/voucher_detail_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({Key? key}) : super(key: key);

  final List<Map> voucherList = [
    {
      "image": Images.amazonImage,
      "text1": "20% Cashback",
      "text2": "Amazon",
      "text3": "Aug 16-17",
    },
    {
      "image": Images.airBnbImage,
      "text1": "50% Off",
      "text2": "Airbnb",
      "text3": "Aug 16-17",
    },
    {
      "image": Images.mcdonaldsImage,
      "text1": "15% Off",
      "text2": "Macdonalds",
      "text3": "Aug 16-17",
    },
    {
      "image": Images.starbucksImage,
      "text1": "30% Cashback",
      "text2": "Starbucks",
      "text3": "Aug 16-17",
    },
    {
      "image": Images.kfcImage,
      "text1": "23% Off",
      "text2": "Kfc",
      "text3": "Aug 16-17",
    },
    {
      "image": Images.nikeImage,
      "text1": "40% Cashback",
      "text2": "Nike",
      "text3": "Aug 16-17",
    },
  ];

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
        title: boldText("Voucher", ColorResources.black, 20),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ScrollConfiguration(
          behavior: MyBehavior(),
          child: GridView.count(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2.6 / 1.7,
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: List.generate(
              voucherList.length,
              (index) => InkWell(
                onTap: () {},
                child: InkWell(
                  onTap: () {
                    Get.to(VoucherDetailScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorResources.white,
                      border:
                          Border.all(color: ColorResources.greyE5E, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 25, bottom: 15, left: 12, right: 12),
                      child: Column(
                        children: [
                          Image.asset(
                            voucherList[index]["image"],
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 20),
                          boldText(voucherList[index]["text1"],
                              ColorResources.blue1D3, 18),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              regularText(voucherList[index]["text2"],
                                  ColorResources.blue1D3, 13),
                              regularText(voucherList[index]["text3"],
                                  ColorResources.grey6B7, 11),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
