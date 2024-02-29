import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ElectricityBillScreens/electricity_bill_payment_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import '../../Models/check_bill_details_response_model.dart';
import '../../Models/get_bbps_billers_info_model.dart';
import '../../Models/get_electricity_product_model.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllElectricityBillersScreen2 extends StatefulWidget {
  final Datum biller;

  AllElectricityBillersScreen2({Key? key, required this.biller})
      : super(key: key);

  @override
  State<AllElectricityBillersScreen2> createState() =>
      _AllElectricityBillersScreen2State();
}

class _AllElectricityBillersScreen2State
    extends State<AllElectricityBillersScreen2> {
  Map<String, String> formValues = {};
  TextEditingController mobileNo = TextEditingController();
  late BillersData billerInfo;
  bool viewForm = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          widget.biller.name ?? '',
          style: TextStyle(
              fontFamily: TextFontFamily.ROBOTO_BOLD,
              fontSize: 20,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textField2("Mobile number", mobileNo, TextInputType.number, true,
                (value) {
              if (mobileNo.text.length == 10) {
                getBillerInfo();
              }
            }, 10, viewForm),
            if (viewForm)
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < (billerInfo.parameters?.length ?? 0);
                          i++)
                        TextFormField(
                            cursorColor: ColorResources.black,
                            textInputAction: TextInputAction.next,
                            keyboardType:
                                billerInfo.parameters?[i].inputType == "NUMERIC"
                                    ? TextInputType.number
                                    : TextInputType.text,
                            // controller: TEC,
                            inputFormatters:
                                billerInfo.parameters?[i].inputType == "NUMERIC"
                                    ? <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^[1-9][0-9]*'))
                                      ]
                                    : [],
                            style: TextStyle(
                              color: ColorResources.black,
                              fontSize: 16,
                              fontFamily: TextFontFamily.ROBOTO_REGULAR,
                            ),
                            decoration: InputDecoration(
                              hintText: billerInfo.parameters![i].desc,
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
                            validator: (value) {
                              if (billerInfo.parameters![i].mandatory == 1 &&
                                  value == '') {
                                return 'Please enter a ${billerInfo.parameters![i].desc}';
                              } else if (value!.length <
                                  (billerInfo.parameters![i].minLength ?? 0)) {
                                return '${billerInfo.parameters![i].desc} must be at least ${billerInfo.parameters![i].minLength} characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (formValues.keys
                                  .contains(billerInfo.parameters![i].name!)) {
                                formValues.update(
                                    billerInfo.parameters![i].name!,
                                    (v) => v = value!);
                              } else {
                                formValues[billerInfo.parameters![i].name!] =
                                    (value!);
                              }
                            },
                            maxLength: billerInfo.parameters?[i].maxLength),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate() == true) {
                            _formKey.currentState!.save();
                            checkBillDetails();
                          }
                        },
                        child: Container(
                          height: 52,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ColorResources.blue1D3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child:
                                boldText("Confirm", ColorResources.white, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<BillersData?> getBillerInfo() async {
    Dialogs.showLoadingDialog(context, GlobalKey<State>());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/checkBiller'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'MobileNo': mobileNo.text,
      'provider_id': widget.biller.id.toString()
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      GetBbpsBillerInfoModel userModel =
          GetBbpsBillerInfoModel.fromJson(parsed);
      if (userModel.statuscode == 'ERR') {
        showBannerMessage(userModel.status ?? "Invalid billerId", context);
        return null;
      } else {
        setState(() {
          billerInfo = userModel.data ?? BillersData();
          if (userModel.data != null) {
            setState(() {
              viewForm = true;
            });
          }
        });
        return billerInfo;
      }
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

  void checkBillDetails() async {
    Dialogs.showLoadingDialog(context, GlobalKey<State>());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/checkBillDetails'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'MobileNo': mobileNo.text,
      'provider_id': widget.biller.id.toString(),
      'Type': 'GET_BILLER_DETAILS',
      for (int i = 0; i < formValues.length; i++)
        formValues.keys.elementAt(i): formValues.values.elementAt(i),
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());

      CheckBillDetailsResponseModel userModel =
          CheckBillDetailsResponseModel.fromJson(parsed);
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      Get.to(ElectricityBillPaymentScreen(
          billDetails: userModel,
          formValues: formValues,
          biller: widget.biller,
          mobNo: mobileNo.text));
      return;
    } else {
      print(streamedResponse.reasonPhrase);
      return;
    }
  }
}
