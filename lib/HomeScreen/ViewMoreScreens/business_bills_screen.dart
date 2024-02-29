import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ChatScreens/chat_screen1.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class BusinessAndBillsScreen extends StatelessWidget {
  BusinessAndBillsScreen({Key? key}) : super(key: key);

  final List<Map> businessAndBillsList = [
    {
      "image": Images.redBus,
      "text": "redBus",
    },
    {
      "image": Images.makeMyTrip,
      "text": "MakeMyTrip",
    },
    {
      "image": Images.pImage,
      "text": "Patel Soda",
    },
    {
      "image": Images.yatra,
      "text": "Yatra",
    },
    {
      "image": Images.barista,
      "text": "Barista",
    },
    {
      "image": Images.macDonalds,
      "text": "Mcdonald’S",
    },
    {
      "image": Images.zomato,
      "text": "Zomato",
    },
    {
      "image": Images.tataSky,
      "text": "Tata Sky",
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
        title: boldText("Businesses and Bills", ColorResources.black, 20),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GridView.count(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20),
          childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3.3 / 2.6,
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            businessAndBillsList.length,
            (index) => Column(
              children: [
                InkWell(
                  onTap: () {
                    // Get.to(ChatScreen1());
                  },
                  child: Image.asset(
                    businessAndBillsList[index]["image"],
                  ),
                ),
                SizedBox(height: 5),
                regularText(businessAndBillsList[index]["text"],
                    ColorResources.grey6B7, 14, TextAlign.center),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }
}
