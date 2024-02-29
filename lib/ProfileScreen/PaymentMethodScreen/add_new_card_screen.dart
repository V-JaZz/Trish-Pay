import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';

class AddNewCardScreen extends StatelessWidget {
  AddNewCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        title: boldText("Add New Card", ColorResources.black, 20),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: SvgPicture.asset(Images.help),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText("Card Detail", ColorResources.blue1D3, 18),
            SizedBox(height: 15),
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
                  child: SvgPicture.asset(Images.masterCard),
                ),
                hintText: "Card number",
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
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: textField1("Expiry date"),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: textField1("CVV"),
                ),
              ],
            ),
            SizedBox(height: 15),
            textField1("Add a nickname (Optional)"),
            SizedBox(height: 11),
            regularText(
                "eg: Shopping Card, Mom’s Card", ColorResources.grey9CA, 14),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 52,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.greyC1C,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: boldText("ADD", ColorResources.white, 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
