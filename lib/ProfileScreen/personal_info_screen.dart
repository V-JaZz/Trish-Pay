import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/ProfileScreen/edit_account_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

import '../HomeScreen/home_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

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
        title: boldText("Personal info", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorResources.blue1D3,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorResources.white, width: 2),
                      color: ColorResources.blue1D3,
                    ),
                    child: Icon(Icons.edit_outlined,
                        color: ColorResources.white, size: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            boldText("Personal Info", ColorResources.grey6B7, 16),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.greyF3F, width: 1),
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        boldText("Mobile Number", ColorResources.grey6B7, 14),
                        SizedBox(height: 25),
                        boldText("Email", ColorResources.grey6B7, 14),
                        SizedBox(height: 25),
                        boldText("Language", ColorResources.grey6B7, 14),
                        SizedBox(height: 25),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 25),
                        boldText("+91 $mobile", ColorResources.blue1D3, 14),
                        SizedBox(height: 25),
                        boldText(email, ColorResources.blue1D3, 14),
                        SizedBox(height: 25),
                        boldText("English (united States)",
                            ColorResources.blue1D3, 14),
                        SizedBox(height: 25),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: (){
                Get.to(EditAccountScreen());
              },
              child: Container(
                height: 52,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ColorResources.greyF9F,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: boldText("Edit", ColorResources.blue1D3, 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
