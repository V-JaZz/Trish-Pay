import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ContactScreen/contact_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class MobileNumberScreen extends StatelessWidget {
  MobileNumberScreen({Key? key}) : super(key: key);

  final List<Map> allPeopleList = [
    {
      "image": Images.lindaJohn,
      "text": "Linda John",
    },
    {
      "image": Images.davidWilliam,
      "text": "David William",
    },
    {
      "image": Images.susanCharles,
      "text": "Susan Charles",
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText("Enter a phone number", ColorResources.blue1D3, 20),
            SizedBox(height: 7),
            regularText("Pay someone using a UPI verified phone number",
                ColorResources.grey6B7, 14),
            SizedBox(height: 12),
            TextFormField(
              cursorColor: ColorResources.black,
              style: TextStyle(
                color: ColorResources.black,
                fontSize: 16,
                fontFamily: TextFontFamily.ROBOTO_REGULAR,
              ),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(15),
                  child: mediumText("+91", ColorResources.blue1D3, 18),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      Get.to(ContactScreen());
                    },
                    child: SvgPicture.asset(Images.noteIcon),
                  ),
                ),
                hintText: "Enter Mobile Number",
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
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: ColorResources.greyF9F, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: ColorResources.greyF9F, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 15),
            boldText("People", ColorResources.grey6B7, 20),
            SizedBox(height: 25),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: allPeopleList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    AssetImage(allPeopleList[index]["image"]),
                  ),
                  title: boldText(allPeopleList[index]["text"],
                      ColorResources.blue1D3, 16),
                  subtitle: regularText(
                      "+91 12345 67890", ColorResources.grey6B7, 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
