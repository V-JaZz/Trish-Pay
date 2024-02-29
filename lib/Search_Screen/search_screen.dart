import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

import '../HomeScreen/ElectricityBillScreens/all_electrycity_billers_screen.dart';
import '../HomeScreen/ICICI_AEPS/icici_aeps.dart';
import '../HomeScreen/ICICI_DMT/icici_dmt.dart';
import '../HomeScreen/ICICI_Payout/icici_payout.dart';
import '../HomeScreen/LoadWallet/load_wallet.dart';
import '../HomeScreen/MobileRechargeScreen/mobile_recharge_screen.dart';
import '../HomeScreen/SelectProviderBillScreens/select_provider_screen.dart';
import '../Utils/font_family.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map> searchList = [
    {
      "image": Images.mobileRechargeImage,
      "text": "Mobile recharge",
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
      "text": "Cable",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Cable'));
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
      "text": "FASTag recharge",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Fast Tag'));
      },
    },
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
      "text": "Gas Cylinder",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Gas Cylinder'));
      },
    },
    {
      "image": Images.insuranceImage,
      "text": "Insurance",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Insurance'));
      },
    },
    {
      "image": Images.emiImage,
      "text": "Loan Payment",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Loan'));
      },
    },
    {
      "image": Images.card,
      "text": "Credit Card",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Card'));
      },
    },
    {
      "image": Images.municipalTaxImage,
      "text": "Mutual Funds",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Mutualfund'));
      },
    },
    {
      "image": Images.housingImage,
      "text": "Housing Society",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Housing Society'));
      },
    },
    {
      "image": Images.bankTransfer,
      "text": "Request Funds",
      "bg": ColorResources.blue1D3,
      "onTap": () {
        Get.to(LoadWallet());
      },
    },
    {
      "image": Images.aeps,
      "text": "Aeps",
      "bg": ColorResources.blue1D3,
      "onTap": () {
        Get.to(ICICIAEPS());
      },
    },
    {
      "image": Images.selfTransfer,
      "text": "DMT",
      "bg": ColorResources.blue1D3,
      "onTap": () {
        Get.to(ICICIDMT());
      },
    },
    {
      "image": Images.bankTransfer,
      "text": "Payout",
      "bg": ColorResources.blue1D3,
      "onTap": () {
        Get.to(ICICIPayout());
      },
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map> filteredList =
        _searchQuery.isEmpty ? searchList : _searchList(_searchQuery);
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 18),
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
        title: boldText("Search", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: ColorResources.black,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.ROBOTO_REGULAR,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: SvgPicture.asset(Images.search),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: ColorResources.grey9CA,
                      fontSize: 16,
                      fontFamily: TextFontFamily.ROBOTO_REGULAR,
                    ),
                    filled: true,
                    fillColor: ColorResources.greyF9F,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: _updateQuery,
                ),
              ),
              SizedBox(height: 25),
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.only(bottom: 20),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            filteredList[index]["bg"] ?? ColorResources.greyF1F,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            color: ColorResources.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child:
                              SvgPicture.asset(filteredList[index]["image"])),
                    ),
                    title: boldText(filteredList[index]["text"],
                        ColorResources.blue1D3, 16),
                    onTap: filteredList[index]["onTap"],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateQuery(String value) {
    setState(() {
      _searchQuery = value.trim().toLowerCase();
    });
  }

  List<Map> _searchList(String query) {
    List<Map> filteredList = searchList
        .where((i) => i["text"].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList;
  }
}
