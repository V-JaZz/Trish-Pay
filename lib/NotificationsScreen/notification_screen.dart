import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final List<Map> todayList = [
    {
      "image": Images.award,
      "text1": "Rewards",
      "text2": "Loyal user rewards!😘",
      "text3": "5m ago",
    },
    {
      "image": Images.moneySend,
      "text1": "Money Transfer",
      "text2": "You have successfully sent money to Linda of...",
      "text3": "25m ago",
    },
  ];

  final List<Map> thisWeekList = [
    {
      "image": Images.creditCard,
      "text1": "Payment Notification",
      "text2": "Successfully paid!🤑",
      "text3": "Mar 20",
    },
    {
      "image": Images.moneySend,
      "text1": "Top Up",
      "text2": "Your top up is successfully!",
      "text3": "Mar 13",
    },
    {
      "image": Images.moneySend,
      "text1": "Money Transfer",
      "text2": "You have successfully sent money to Linda of...",
      "text3": "Mar 09",
    },
    {
      "image": Images.discount,
      "text1": "Cashback 25%",
      "text2": "You have successfully sent money to Linda of...",
      "text3": "Mar 20",
    },
    {
      "image": Images.creditCard,
      "text1": "Payment Notification",
      "text2": "Successfully paid!🤑",
      "text3": "Mar 13",
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
          padding: EdgeInsets.only(top: 8,bottom: 8,left: 18),
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
        title: boldText("Notifications", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                mediumText("You will see your notifications here!", ColorResources.greyC1C, 14,TextAlign.center),
                // boldText("Today", ColorResources.grey6B7, 16),
                // SizedBox(height: 20),
                // ListView.builder(
                //   padding: EdgeInsets.zero,
                //   itemCount: todayList.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => Padding(
                //     padding: EdgeInsets.only(bottom: 10),
                //     child: ListTile(
                //       contentPadding: EdgeInsets.zero,
                //       leading: Container(
                //         height: 48,
                //         width: 48,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: ColorResources.greyF6F,
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.all(10),
                //           child: SvgPicture.asset(todayList[index]["image"]),
                //         ),
                //       ),
                //       title: boldText(todayList[index]["text1"],
                //           ColorResources.blue1D3, 16),
                //       subtitle: Padding(
                //         padding: EdgeInsets.only(top: 4),
                //         child: regularText(todayList[index]["text2"],
                //             ColorResources.grey6B7, 12),
                //       ),
                //       trailing: Padding(
                //         padding: EdgeInsets.only(bottom: 33),
                //         child: regularText(todayList[index]["text3"],
                //             ColorResources.grey6B7, 12),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                // boldText("This Week", ColorResources.grey6B7, 16),
                // SizedBox(height: 20),
                // ListView.builder(
                //   padding: EdgeInsets.zero,
                //   itemCount: thisWeekList.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => Padding(
                //     padding: EdgeInsets.only(bottom: 10),
                //     child: ListTile(
                //       contentPadding: EdgeInsets.zero,
                //       leading: Container(
                //         height: 48,
                //         width: 48,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: ColorResources.greyF6F,
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.all(10),
                //           child: SvgPicture.asset(
                //             thisWeekList[index]["image"],
                //             color: index == 4 ? ColorResources.orangeFB9 : null,
                //           ),
                //         ),
                //       ),
                //       title: boldText(thisWeekList[index]["text1"],
                //           ColorResources.blue1D3, 16),
                //       subtitle: Padding(
                //         padding: EdgeInsets.only(top: 4),
                //         child: regularText(thisWeekList[index]["text2"],
                //             ColorResources.grey6B7, 12),
                //       ),
                //       trailing: Padding(
                //         padding: EdgeInsets.only(bottom: 33),
                //         child: regularText(thisWeekList[index]["text3"],
                //             ColorResources.grey6B7, 12),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
