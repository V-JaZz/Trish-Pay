import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/get_customers_product_response_model.dart';
import '../../Networking/api_base_helper.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';

class GetCustomerProductRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  GetCustomerProductRepo(this.context);

  Future<GetCustomerProductsResponseModel?> getProduct() async {

    // Dialogs.showLoadingDialog(context, _keyLoader);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

      try {
        final response = await _helper.post(
            ApiBaseHelper.getProducts,
            jsonEncode(<String, String>{
              'Token': tok??'',
              'Type': 'mobile',
              'DeviceId': dId??'',
              'UserId': uId.toString()??'',
            }),
            "");
        print("posting params");
        print(jsonEncode.toString());
        GetCustomerProductsResponseModel model =
        GetCustomerProductsResponseModel.fromJson(_helper.returnResponse(context, response));
        // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        if (model.status == 'success') {
          print("model response");
          print(model.status);
          // StorageUtil.setData(StorageUtil.keyLoginData, jsonEncode(model.data));
          // StorageUtil.setData(StorageUtil.keyLoginToken, model.data!.token);
          // StorageUtil.setData(StorageUtil.keyEmail, model.data!.email);
          // StorageUtil.setData(
          //     StorageUtil.keyRestaurantId, model.data!.restaurantId);
          // emailID = model.data!.email!;

          // final SharedPreferences prefs = await _prefs;
          // restaurantID = model.data!.restaurantId!;
          print("success");
          return model;
          // print(restaurantID);
          // prefs.setString('restaurant', restaurantID);
          // Get.to(VerificationScreen(countryCode: cCode,deviceId: deviceToken,phoneNo: pNo,password: pass,lat: lat,long: long));
        } else {
          showBannerMessage(model.message!, context);
        }
      } catch (e) {
        print(e.toString());
      }
      return null;
  }
}
