import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ElectricityBillScreens/all_electrycity_billers_screen.dart';
import 'package:gpayapp/HomeScreen/GooglePlayScreen/google_play_screen.dart';
import 'package:gpayapp/HomeScreen/MobileRechargeScreen/mobile_recharge_screen.dart';
import 'package:gpayapp/HomeScreen/SelectProviderBillScreens/select_provider_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class PaymentCategoriesScreen extends StatelessWidget {
  PaymentCategoriesScreen({Key? key}) : super(key: key);
  final List<Map> rechargeList = [
    {
      "image": Images.mobileRechargeImage,
      "text": "Mobile\nrecharge",
      "onTap": () {
        Get.to(MobileRechargeScreen());
      },
    },
    {
      "image": Images.monitorImage,
      "text": "DTH",
      "onTap": () {
        Get.to(RechargeDishTv());
      },
    },
    {
      "image": Images.monitorImage,
      "text": "Cable TV",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Cable TV'));
      },
    },
    {
      "image": Images.fastagRecharge,
      "text": "FASTag\nrecharge",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Fastag'));
      },
    },
  ];

  final List<Map> utilityBillsList = [
    {
      "image": Images.electricityImage,
      "text": "Electricity",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Electricity'));
      },
    },
    {
      "image": Images.landLineImage,
      "text": "Broadband",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Broadband'));
      },
    },
    {
      "image": Images.landLineImage,
      "text": "Landline",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Landline'));
      },
    },
    {
      "image": Images.mobileRechargeImage,
      "text": "Postpaid",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Postpaid'));
      },
    },
    {
      "image": Images.waterImage,
      "text": "Water",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Water'));
      },
    },
    {
      "image": Images.pipedGasImage,
      "text": "Piped gas",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Gas Piped'));
      },
    },
    {
      "image": Images.cylinderImage,
      "text": "Gas \nCylinder",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Gas Cylinder'));
      },
    },
  ];

  final List<Map> financeAndTaxList = [
    {
      "image": Images.insuranceImage,
      "text": "Insurance",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Insurance'));
      },
    },
    {
      "image": Images.emiImage,
      "text": "Loan \nPayment",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Loan'));
      },
    },
    {
      "image": Images.card,
      "text": "Credit\nCard",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Card'));
      },
    },
    {
      "image": Images.municipalTaxImage,
      "text": "Mutual\nFunds",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Mutual Fund'));
      },
    },
  ];

  final List<Map> otherList = [
    {
      "image": Images.housingImage,
      "text": "Housing\nSociety",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Housing Society'));
      },
    },
  ];

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
        title: boldText("Payment categories", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText("RECHARGE", ColorResources.blue1D3, 16),
                SizedBox(height: 15),
                LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 3.6 / 2.8,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      rechargeList.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: rechargeList[index]["onTap"],
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.greyF1F,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    color:
                                        ColorResources.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                    rechargeList[index]["image"]),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                              child: regularText(
                                  rechargeList[index]["text"],
                                  ColorResources.grey6B7,
                                  14,
                                  TextAlign.center)),
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                SizedBox(height: 25),
                boldText("UTILITY BILLS", ColorResources.blue1D3, 16),
                SizedBox(height: 15),
                LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 2.2 / 2,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      utilityBillsList.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: utilityBillsList[index]["onTap"],
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.greyF1F,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    color:
                                        ColorResources.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                    utilityBillsList[index]["image"]),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          regularText(utilityBillsList[index]["text"],
                              ColorResources.grey6B7, 14, TextAlign.center),
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                SizedBox(height: 10),
                boldText("FINANCE & TAX", ColorResources.blue1D3, 16),
                SizedBox(height: 15),
                LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 3 / 3,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      financeAndTaxList.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: financeAndTaxList[index]["onTap"],
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.greyF1F,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    color:
                                        ColorResources.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                    financeAndTaxList[index]["image"]),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          regularText(financeAndTaxList[index]["text"],
                              ColorResources.grey6B7, 14, TextAlign.center),
                        ],
                      ),
                    ).toList(),
                  ),
                ),
                SizedBox(height: 10),
                boldText("OTHERS", ColorResources.blue1D3, 16),
                SizedBox(height: 15),
                LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 2.3 / 2,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      otherList.length,
                      (index) => Column(
                        children: [
                          InkWell(
                            onTap: otherList[index]["onTap"],
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.greyF1F,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    color:
                                        ColorResources.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child:
                                    SvgPicture.asset(otherList[index]["image"]),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          regularText(otherList[index]["text"],
                              ColorResources.grey6B7, 13, TextAlign.center),
                        ],
                      ),
                    ).toList(),
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
