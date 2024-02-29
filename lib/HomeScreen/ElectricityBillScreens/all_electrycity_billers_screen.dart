import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import '../../Models/get_electricity_product_model.dart';
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'all_electricity_billers_screen2.dart';

class AllElectriCityBillersScreen extends StatefulWidget {
  final String providerType;

  AllElectriCityBillersScreen({Key? key, required this.providerType})
      : super(key: key);

  @override
  State<AllElectriCityBillersScreen> createState() =>
      _AllElectriCityBillersScreenState();
}

class _AllElectriCityBillersScreenState
    extends State<AllElectriCityBillersScreen> {
  String _searchQuery = '';
  List<Datum>? billersList;
  Future<List<Datum>?>? future;

  @override
  void initState() {
    future = loadBillersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Datum> filteredBillersList =
        _searchQuery.isEmpty ? (billersList ?? []) : _searchList(_searchQuery);
    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 18, top: 8, bottom: 8),
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
        title: boldText(widget.providerType, ColorResources.black, 20),
      ),
      body: Column(
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
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: boldText("All Billers", ColorResources.grey6B7, 20),
          ),
          SizedBox(height: 18),
          Expanded(
            child: FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (filteredBillersList.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredBillersList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: ColorResources.blue1D3,
                                child: Icon(
                                  Icons.business_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              title: mediumText(
                                  filteredBillersList[index].name ?? '',
                                  ColorResources.blue1D3,
                                  14),
                              onTap: () {
                                Get.to(AllElectricityBillersScreen2(
                                    biller: filteredBillersList[index]));
                              },
                            ),
                            SizedBox(height: 10),
                            Divider(
                                thickness: 1, color: ColorResources.greyF3F),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                        padding: EdgeInsets.only(top: Get.width / 3),
                        alignment: Alignment.center,
                        child: mediumText(
                            'Not Found!', ColorResources.greyC1C, 18));
                  }
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: Get.width / 3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.blue1D3,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Datum>?> loadBillersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/getProducts'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'Type': widget.providerType.replaceAll(' ', '').toLowerCase()
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      GetElectricityProductModel userModel =
          GetElectricityProductModel.fromJson(parsed);
      setState(() {
        billersList = userModel.data;
      });
      return [Datum(), Datum()];
    } else {
      print(streamedResponse.reasonPhrase);
      return [];
    }
  }

  void _updateQuery(String value) {
    setState(() {
      _searchQuery = value.trim().toLowerCase();
    });
  }

  List<Datum> _searchList(String query) {
    List<Datum> filteredList = billersList
            ?.where((i) => i.name!.toLowerCase().contains(query.toLowerCase()))
            .toList() ??
        [];
    return filteredList;
  }
}
