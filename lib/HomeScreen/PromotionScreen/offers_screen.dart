import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({Key? key}) : super(key: key);

  final List<Map> offerList = [
    {
      "image": Images.offer1,
      "color" : ColorResources.whiteEDF,
      "text1": "Mobile Recharge Offer Use Code FIRST20",
      "text2":
          "Get 20 % Instant cashback upto Rs 50 on your firs mobile recharge. T&C apply",
      "text3": "",
    },
    {
      "image": Images.offer2,
      "color" : ColorResources.orangeFFE,
      "text1": "DTH Recharge Offer Use Code FIRSDTHT20",
      "text2":
          "Get 20 % Instant cashback upto Rs 50 on your first DTH recharge. T&C apply",
      "text3": "",
    },
    {
      "image": Images.offer3,
      "color" : ColorResources.greenEDF.withOpacity(0.41),
      "text1": "Flipcart Shopping Offer",
      "text2":
          "Shop on Flipcart using our payment system to get upto 50% cashback . T&C appply",
      "text3": "",
    },
    {
      "image": Images.offer4,
      "color" : ColorResources.yellowFFF,
      "text1": "Money Transfer Offer",
      "text2":
          "Get a scratch card with assuerd casbck and coupons on Money Transfer of Rs 500 or more . T&C apply",
      "text3": "",
    },
    {
      "image": Images.offer5,
      "color" : ColorResources.purpleF2E,
      "text1": "Rs 50 Off on Flights",
      "text2":
          "Get instant discount on flat 50 Rs on Flight ticket booking. T&C apply",
      "text3": "Go to offer page",
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
        title: boldText("Offers", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 15,left: 20,right: 20),
          itemCount: offerList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: offerList[index]["color"],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Image.asset(
                        offerList[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(offerList[index]["text1"],
                                ColorResources.blue1D3, 15),
                            SizedBox(height: 10),
                            regularText(offerList[index]["text2"],
                                ColorResources.grey9CA, 10),
                            SizedBox(height: 10),
                            boldText(offerList[index]["text3"],
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
