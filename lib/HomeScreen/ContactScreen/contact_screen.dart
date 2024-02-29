import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class ContactScreen extends StatelessWidget {
   ContactScreen({Key? key}) : super(key: key);

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
     {
       "image": Images.sarahSam,
       "text": "Sarah Sam",
     },
     {
       "image": Images.monicaJess,
       "text": "Monica Jess",
     },
     {
       "image": Images.loranHeliy,
       "text": "Loran Hailey",
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
          padding: EdgeInsets.only(top: 8,bottom: 8,left: 18),
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
        title: boldText("Contact", ColorResources.black, 20),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: textField("Search by name or number", Images.search),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: boldText("All People", ColorResources.grey6B7, 20),
              ),
              SizedBox(height: 25),
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allPeopleList.length,
                  padding: EdgeInsets.only(left: 20, right: 20),
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
      ),
    );
  }
}
