import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);
  final List<Map> aboutList = [
    {
      "image":Images.termsOfServicesImage,
      "text": "Terms of service",
    },
    {
      "image":Images.privacyPolicyImage,
      "text": "Privacy policy",
    },
    {
      "image":Images.softwareLicensesImage,
      "text": "Software licenses",
    },
    {
      "image":Images.aboutImage,
      "text": "Version 150.1.5\n(arm64-v8a_release_flutter)",
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
          padding: EdgeInsets.all(8.0),
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
        title: boldText("About", ColorResources.black, 20),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 40),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: aboutList.length,
        itemBuilder: (context, index) =>
            Padding(
              padding:  EdgeInsets.only(bottom: 15),
              child: ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.greyF6F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(aboutList[index]["image"]),
                  ),
                ),
                title: mediumText(
                    aboutList[index]["text"], ColorResources.blue1D3, 16),
              ),
            ),
      ),
    );
  }
}
