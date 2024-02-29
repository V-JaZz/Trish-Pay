// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/RoutScreen/rout_screen.dart';
import '../Models/login_response_model.dart';
import '../Networking/api_base_helper.dart';
import '../VerificationScreen/verification_screen.dart';
import '../common/common.dart';
import 'package:http/http.dart' as http;

class UpdateCustomerRepo {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final BuildContext? _context;

  final GlobalKey<State> _keyLoader =  GlobalKey<State>();

  UpdateCustomerRepo(this._context);

  update(
      { String? token,
        String? dId,
        String? uId ,
        String? name,
        String? outletName,
        String? pinCode ,
        String? panCardNo,
        String? aadhaarCardNo ,
        String? address ,
        String? state ,
        String? city ,
        String? aadhaarFront,
        String? aadhaarBack,
        String? panCard,
        String? cheque
      }) async {
    if (checkString(name) || checkString(outletName) || checkString(pinCode) || checkString(panCardNo) || checkString(aadhaarCardNo) || checkString(address) || checkString(state) || checkString(city) || checkString(aadhaarFront) || checkString(aadhaarBack) || checkString(panCard) || checkString(cheque)) {
      showBannerMessage("All fields are required", _context!);
    }else{
      Dialogs.showLoadingDialog(_context!, _keyLoader); //invoking login
      try {
        var request = http.MultipartRequest('POST', Uri.parse(ApiBaseHelper.baseURL + ApiBaseHelper.customerInfoUpdate));
      request.fields.addAll({
        'Token': token??'',
        'UserId': uId??'',
        'DeviceId': dId??'',
        'Name': name??'',
        'OutletName': outletName??'',
        'Pincode': pinCode??'',
        'Pancard': panCardNo??'',
        'Address': address??'',
        'State': state??'',
        'City': city??'',
        'AadharNo': aadhaarCardNo??''
      });
      request.files.add(await http.MultipartFile.fromPath('AadharFront', aadhaarFront??''));
      request.files.add(await http.MultipartFile.fromPath('AadharBack', aadhaarBack??''));
      request.files.add(await http.MultipartFile.fromPath('PancardPic', panCard??''));
      request.files.add(await http.MultipartFile.fromPath('ChequePic', cheque??''));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

      }

      print("posting params");
        // LoginResponseModel model = loginResponseModelFromJson(await response.stream.bytesToString());

        Get.offAll(RoutScreen());

        // if (model.status == 'success') {
        //   print("model response");
        //   print(model.status);
        //
        //   print("updated info");
        //   Get.offAll(RoutScreen());
        // } else {
        //   showMessage(model.message!, _context!);
        // }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
