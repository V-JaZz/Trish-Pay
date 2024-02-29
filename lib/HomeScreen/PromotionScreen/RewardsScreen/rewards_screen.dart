import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/variable_controller.dart';
import 'package:gpayapp/HomeScreen/PromotionScreen/RewardsScreen/rewards_detail_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:scratcher/scratcher.dart';

// ignore: must_be_immutable
class RewardsScreen extends StatelessWidget {
  RewardsScreen({Key? key}) : super(key: key);

  final VariableController variableController = Get.put(VariableController());

  final List<Map> collectRewardsList = [
    {
      "image": Images.collectRewards1,
      "text1": "Flat 50 off On food Delivery",
      "text2": "On orders above 99 on Swaggy, Somato",
    },
    {
      "image": Images.collectRewards2,
      "text1": "20% Cashback On Amazon",
      "text2": "Up to Rs 150 Minimum Order 1000",
    },
  ];

  final scratchKey = GlobalKey<ScratcherState>();

  bool isScratch = false;

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
        title: boldText("Rewards", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorResources.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          spreadRadius: 0,
                          color: ColorResources.purple4D5.withOpacity(0.3),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          boldText(
                              "Casbacks earned", ColorResources.blue1D3, 15),
                          SizedBox(height: 6),
                          boldText("₹507", ColorResources.grey6B7, 20),
                          SizedBox(height: 6),
                          regularText(
                              "+ 88 Rs This month", ColorResources.grey9CA, 15),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              height: 42,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResources.whiteEDF,
                              ),
                              child: Center(
                                child: mediumText("View your cashback history",
                                    ColorResources.blue1D3, 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                boldText("Scrachcards won", ColorResources.blue1D3, 15),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(RewardsDetailScreen());
                          // Get.bottomSheet(
                          //   Column(
                          //     children: [
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 50, right: 25),
                          //         child: Align(
                          //           alignment: Alignment.topRight,
                          //           child: InkWell(
                          //             onTap: () {
                          //               Get.back();
                          //             },
                          //             child: Container(
                          //               height: 50,
                          //               width: 50,
                          //               decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: ColorResources.white,
                          //               ),
                          //               child: Icon(Icons.close,
                          //                   color: ColorResources.black,
                          //                   size: 30),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(height: 20),
                          //       Padding(
                          //         padding: EdgeInsets.symmetric(horizontal: 55),
                          //         child: ClipRRect(
                          //           borderRadius: BorderRadius.circular(30),
                          //           child: Scratcher(
                          //             key: scratchKey,
                          //             brushSize: 50,
                          //             threshold: 50,
                          //             color: ColorResources.pinkFFE,
                          //             image: Image.asset(Images.rewardsPng1),
                          //             onChange: (value) {
                          //               if (value == 100) {
                          //                 print("Scratch progress: $value%");
                          //                 isScratch = true;
                          //                 print("$isScratch************");
                          //               }
                          //
                          //
                          //             },
                          //             // onThreshold: () {
                          //             //   isScratch = true;
                          //             //   print("$isScratch************");
                          //             // },
                          //             child: Container(
                          //               height: 300,
                          //               width: Get.width,
                          //               decoration: BoxDecoration(
                          //                 color: ColorResources.white,
                          //                 borderRadius:
                          //                 BorderRadius.circular(30),
                          //               ),
                          //               child: Stack(
                          //                 alignment: Alignment.center,
                          //                 children: [
                          //                   Positioned(
                          //                     top: 0,
                          //                     left: 0,
                          //                     child: SvgPicture.asset(
                          //                         Images.topEllipseImage),
                          //                   ),
                          //                   Positioned(
                          //                     bottom: 0,
                          //                     right: 0,
                          //                     child: SvgPicture.asset(
                          //                         Images.bottomEllipseImage),
                          //                   ),
                          //                   Column(
                          //                     mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                     children: [
                          //                       boldText("₹11",
                          //                           ColorResources.blue1D3, 48),
                          //                       SizedBox(height: 10),
                          //                       regularText("Cashback",
                          //                           ColorResources.grey6B7, 30),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Align(
                          //           alignment: Alignment.bottomCenter,
                          //           child: Container(
                          //             height: 5,
                          //             width: 55,
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(100),
                          //               color: ColorResources.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(height: 5),
                          //       Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(40),
                          //               topRight: Radius.circular(40),
                          //             ),
                          //             color: ColorResources.white),
                          //         child: Padding(
                          //           padding: EdgeInsets.only(
                          //               top: 30,
                          //               left: 30,
                          //               right: 30,
                          //               bottom: isScratch == true ? 40 : 120),
                          //           child: isScratch == true
                          //               ? Column(
                          //             crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //             children: [
                          //               mediumText("Congrats!",
                          //                   ColorResources.blue1D3, 28),
                          //               SizedBox(height: 22),
                          //               regularText(
                          //                   "Earned on Jan 7, 2020 for paying Bombay Saloon",
                          //                   ColorResources.blue1D3,
                          //                   16),
                          //               SizedBox(height: 5),
                          //               regularText(
                          //                   "Google ref ID:BDW350F4U635PFLI",
                          //                   ColorResources.blue1D3,
                          //                   16),
                          //               SizedBox(height: 60),
                          //               containerButton(
                          //                       () {}, "Tell your friends"),
                          //             ],
                          //           )
                          //               : Column(
                          //             crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //             children: [
                          //               mediumText("Scratch Card",
                          //                   ColorResources.blue1D3, 28),
                          //               SizedBox(height: 22),
                          //               regularText(
                          //                   "Scratch the card above and you could earn rewards!",
                          //                   ColorResources.blue1D3,
                          //                   16),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          //   backgroundColor: Colors.transparent,
                          //   isScrollControlled: true,
                          // );
                        },
                        child: Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorResources.pinkFFE,
                          ),
                          child: Center(
                            child: SvgPicture.asset(Images.rewards1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(RewardsDetailScreen());
                        },
                        child: Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorResources.purpleEDE,
                          ),
                          child: Center(
                            child: SvgPicture.asset(Images.rewards2),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(RewardsDetailScreen());
                        },
                        child: Container(
                          height: 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorResources.greenFDF,
                          ),
                          child: Center(
                            child: SvgPicture.asset(Images.rewards3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                boldText("Collect Rewards", ColorResources.blue1D3, 15),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: collectRewardsList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.whiteEDF,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 25, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 75,
                              width: 75,
                              child: Image.asset(
                                collectRewardsList[index]["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(collectRewardsList[index]["text1"],
                                    ColorResources.blue1D3, 15),
                                SizedBox(height: 10),
                                regularText(collectRewardsList[index]["text2"],
                                    ColorResources.grey9CA, 10),
                                SizedBox(height: 10),
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorResources.whiteD9F,
                                  ),
                                  child: Center(
                                    child: mediumText("Collect Now",
                                        ColorResources.blue1D3, 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
