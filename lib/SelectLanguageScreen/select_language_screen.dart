import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/variable_controller.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class SelectLanguageScreen extends StatelessWidget {
  SelectLanguageScreen({Key? key}) : super(key: key);

  final VariableController variableController = Get.put(VariableController());

  final List<Map> selectLanguageList = [
    {
      "image": Images.englishFlagImage,
      "text": "English (US)",
    },
    {
      "image": Images.englishFlagImage2,
      "text": "English (ENG)",
    },
    {
      "image": Images.indonesiaFlagImage,
      "text": "Indonesian",
    },
    {
      "image": Images.russiaFlagImage,
      "text": "Russia",
    },
    {
      "image": Images.frenchFlagImage,
      "text": "French",
    },
    {
      "image": Images.indiaFlagImage,
      "text": "India",
    },
    {
      "image": Images.japanFlagImage,
      "text": "Japanese",
    },
    {
      "image": Images.germanyFlagImage,
      "text": "Germany",
    },
    {
      "image": Images.netherlandFlagImage,
      "text": "Netherland",
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
        title: boldText("Select Language", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
        child: Column(
          children: [
            textField("Search", Images.search),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                // height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResources.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      spreadRadius: 0,
                      offset: Offset(2, 15),
                      color: ColorResources.grey6B7.withOpacity(0.06),
                    ),
                  ],
                ),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: selectLanguageList.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                selectLanguageList[index]["image"],
                              ),
                              SizedBox(width: 16),
                              mediumText(selectLanguageList[index]["text"],
                                  ColorResources.black0F1, 16),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GetBuilder<VariableController>(
                                    init: VariableController(),
                                    builder: (controller) =>
                                        InkWell(
                                          onTap: () {
                                            variableController.onIndexChange(
                                                index);
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: variableController
                                                  .selectedIndex ==
                                                  index
                                                  ? ColorResources.blue1D3
                                                  : ColorResources.white,
                                              border: Border.all(
                                                  color:
                                                  variableController
                                                      .selectedIndex ==
                                                      index
                                                      ? ColorResources.blue1D3
                                                      : ColorResources.greyE5E,
                                                  width: 1),
                                            ),
                                            child: Center(
                                              child: Icon(Icons.check,
                                                  color: ColorResources.white,
                                                  size: 12),
                                            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
