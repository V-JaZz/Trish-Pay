import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ChatScreens/chat_screen2.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class PeopleScreen extends StatelessWidget {
   PeopleScreen({Key? key}) : super(key: key);

   final List<Map> peopleList = [
     {
       "image": Images.jenny,
       "text": "Jenny",
     },
     {
       "image": Images.bessie,
       "text": "Bessie",
     },
     {
       "image": Images.jImage,
       "text": "Jacob",
     },
     {
       "image": Images.darlene,
       "text": "Darlene",
     },
     {
       "image": Images.a1Image,
       "text": "Annette",
     },
     {
       "image": Images.darlene,
       "text": "Darlene",
     },
     {
       "image": Images.dImage,
       "text": "Darlene",
     },
     {
       "image": Images.jenny,
       "text": "Jenny ",
     },
     {
       "image": Images.a2Image,
       "text": "Annette",
     },
     {
       "image": Images.jenny,
       "text": "Jenny",
     },
     {
       "image": Images.darlene,
       "text": "Darlene",
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
          padding: EdgeInsets.only(top: 8,bottom: 8,left:18 ),
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
        title: boldText("People", ColorResources.black, 20),
      ),
      body:  LayoutBuilder(
        builder: (context, constraints) => GridView.count(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20),
          childAspectRatio:
          MediaQuery.of(context).size.aspectRatio * 3.5 / 2.4,
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            peopleList.length,
                (index) => Column(
              children: [
                InkWell(
                  onTap: (){
                    Get.to(ChatScreen2());
                  },
                  child: Image.asset(
                    peopleList[index]["image"],
                  ),
                ),
                SizedBox(height: 5),
                regularText(peopleList[index]["text"],
                    ColorResources.grey6B7, 14, TextAlign.center),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }
}
