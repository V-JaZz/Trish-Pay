import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

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
        title: boldText("Edit Account", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 35, left: 25, right: 25),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText("Mobile Number", ColorResources.grey6B7, 16),
                SizedBox(height: 12),
                textField1("+91 12345 67890"),
                SizedBox(height: 25),
                boldText("Email", ColorResources.grey6B7, 16),
                SizedBox(height: 12),
                textField1("johndoe@gmail.com"),
                SizedBox(height: 25),
                boldText("Language", ColorResources.grey6B7, 16),
                SizedBox(height: 12),
                TextFormField(
                  cursorColor: ColorResources.black,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.ROBOTO_REGULAR,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: SvgPicture.asset(Images.arrowDownIcon,
                          color: ColorResources.blue1D3),
                    ),
                    hintText: "English (united States)",
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
                ),
                SizedBox(height: 180),
                containerButton(() {}, "Save"),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
