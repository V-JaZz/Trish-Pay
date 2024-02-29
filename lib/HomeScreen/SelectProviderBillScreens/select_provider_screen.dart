import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/SelectProviderBillScreens/select_provider_bill_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/get_customers_product_response_model.dart';
import '../../constants/constants.dart';

class RechargeDishTv extends StatefulWidget {
  RechargeDishTv({Key? key}) : super(key: key);

  @override
  State<RechargeDishTv> createState() => _RechargeDishTvState();
}

class _RechargeDishTvState extends State<RechargeDishTv> {
  Future<GetCustomerProductsResponseModel?>? fdata ;
  List<Datum>? providers;
  // final List<Map> selectProviderList = [
  //   {
  //     "image": Images.airtelCard2,
  //     "text": "Airtel Digital TV",
  //   },
  //   {
  //     "image": Images.dishTvImage,
  //     "text": "Dish TV",
  //   },
  //   {
  //     "image": Images.sunDirectImage,
  //     "text": "Sun Direct",
  //   },
  //   {
  //     "image": Images.tataPlayImage,
  //     "text": "Tata Play (Formerly Tatasky)",
  //   },
  //   {
  //     "image": Images.d2hImage,
  //     "text": "D2H",
  //   },
  // ];

  @override
  void initState() {
    fdata = getProviders();
    super.initState();
  }
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
        title: boldText("Select Provider", ColorResources.black, 20),
      ),
      body:
      FutureBuilder(
        future: fdata,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: providers?.length??0,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(SelectProviderBillScreen(provider: providers![index],));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorResources.white,
                          border: Border.all(color: ColorResources.greyE5E, width: 1),
                        ),
                        child: ListTile(
                          title: boldText(providers?[index].name.toString(),
                              ColorResources.blue1D3, 16),
                        ),
                      ),
                    ),
                  ),
                ),
              );
          }else{
            return Padding(
              padding: EdgeInsets.only(bottom: Get.width/3),
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorResources.blue1D3,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<GetCustomerProductsResponseModel?> getProviders() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('https://trishpay.com/api/Android/getProducts'));
    request.bodyFields = {
      'Token': tok??'',
      'UserId': uId.toString(),
      'DeviceId': dId??'',
      'Type': 'dth'
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    // Get.back();
    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      GetCustomerProductsResponseModel userModel= GetCustomerProductsResponseModel.fromJson(parsed);
      setState(() {
        providers = userModel.data;
      });
      return userModel;
    }
    else{
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

}
