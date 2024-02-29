import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';

class SelectBankScreen extends StatefulWidget {
  SelectBankScreen({Key? key}) : super(key: key);

  @override
  State<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  FocusNode onFocus = FocusNode();
  bool nearByFocus = false;
  final TextEditingController searchController = TextEditingController();

  @override
  // ignore: must_call_super
  void initState() {
    onFocus.addListener(() {
      print(onFocus.hasFocus);
      setState(() {
        nearByFocus = onFocus.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> popularBanksList1 = [
      {
        "image": Images.axisBankImage,
        "text": "Axis Bank",
      },
      {
        "image": Images.hdfcBankImage,
        "text": "HDFC Bank",
      },
      {
        "image": Images.icicBankImage,
        "text": "ICICI Bank",
      },
      {
        "image": Images.statBankImage,
        "text": "State Bank of i..",
      },
      {
        "image": Images.bankOfIndiaImage,
        "text": "Bank of India",
      },
      {
        "image": Images.bankOfBarodaImage,
        "text": "Bank of Baroda",
      },
    ];

    final List<Map> popularBanksList2 = [
      {
        "image": Images.bank1Image,
        "text": "A P Mahesh Bank",
      },
      {
        "image": Images.bank1Image,
        "text": "AU Small Finance Bank",
      },
      {
        "image": Images.bank2Image,
        "text": "Abhyuday Cooperative Bank Ltd",
      },
      {
        "image": Images.bank1Image,
        "text": "Adarsh Co-operative Bank Limited",
      },
      {
        "image": Images.bank1Image,
        "text": "Ahmednagar Merchants Cooperative \nBank Ltd",
      },
      {
        "image": Images.bank3Image,
        "text": "Airtel Payments Bank",
      },
      {
        "image": Images.bank1Image,
        "text": "Ajantha Urban Co-op Bank Ltd",
      },
    ];

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
        title: boldText("Select your bank", ColorResources.black, 20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: ColorResources.black,
                        controller: searchController,
                        focusNode: onFocus,
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
                          hintText: "Search..",
                          hintStyle: TextStyle(
                            color: ColorResources.grey9CA,
                            fontSize: 16,
                            fontFamily: TextFontFamily.ROBOTO_REGULAR,
                          ),
                          filled: true,
                          fillColor: ColorResources.greyF9F,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.greyF9F, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.greyF9F, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorResources.greyF9F, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    nearByFocus
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child:
                                boldText("Cancel", ColorResources.blue1D3, 16),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: boldText("Popular banks", ColorResources.grey6B7, 20),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                        color: ColorResources.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => GridView.count(
                      padding: EdgeInsets.only(top: 15, left: 2, right: 2),
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 3.5 /2.5,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        popularBanksList1.length,
                        (index) => Padding(
                          padding:  EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: [
                              Image.asset(popularBanksList1[index]["image"],
                                  height: 55, width: 55),
                              SizedBox(height: 5),
                              mediumText(popularBanksList1[index]["text"],
                                  ColorResources.blue1D3, 13, TextAlign.center),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: boldText("Popular banks", ColorResources.grey6B7, 20),
              ),
              SizedBox(height: 18),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: popularBanksList2.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              popularBanksList2[index]["image"],
                              height: 45,
                              width: 45,
                            ),
                            SizedBox(width: 10),
                            mediumText(popularBanksList2[index]["text"],
                                ColorResources.blue1D3, 14),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                    ],
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
