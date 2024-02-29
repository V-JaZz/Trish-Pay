import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/check_bill_details_response_model.dart';
import '../../Models/do_bbps_response_model.dart';
import '../../RoutScreen/rout_screen.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import '../../Models/get_electricity_product_model.dart';

class ElectricityBillPaymentScreen extends StatelessWidget {
  final CheckBillDetailsResponseModel billDetails;
  final Map<String, String> formValues;
  final Datum biller;
  final String mobNo;

  ElectricityBillPaymentScreen(
      {Key? key,
      required this.billDetails,
      required this.formValues,
      required this.biller,
      required this.mobNo})
      : super(key: key);

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
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 18),
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
        title: boldText("Electricity Bill Payment", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            billDetails.statuscode.toString() != "TXN"
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorResources.white,
                      border:
                          Border.all(color: ColorResources.greyE5E, width: 1),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText("Failed", ColorResources.blue1D3, 16),
                          SizedBox(height: 4),
                          regularText(billDetails.status.toString(),
                              ColorResources.grey9CA, 13),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorResources.white,
                          border: Border.all(
                              color: ColorResources.greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Image.asset(Images.bill5),
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: regularText("Bill Number",
                                      ColorResources.grey6B7, 12),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: boldText(
                                      billDetails.data?.billNumber.toString(),
                                      ColorResources.blue1D3,
                                      16),
                                ),
                              ),
                              Divider(
                                  thickness: 1, color: ColorResources.greyE5E),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        regularText("Consumer Name:",
                                            ColorResources.grey6B7, 12),
                                        SizedBox(height: 10),
                                        regularText("Bill Number:",
                                            ColorResources.grey6B7, 12),
                                        SizedBox(height: 10),
                                        regularText("Bill Date:",
                                            ColorResources.grey6B7, 12),
                                        SizedBox(height: 10),
                                        regularText("Bill Due Date:",
                                            ColorResources.grey6B7, 12),
                                        SizedBox(height: 10),
                                        regularText("Bill Due Date:",
                                            ColorResources.grey6B7, 12),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          billDetails.data?.customerName,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.ROBOTO_BOLD,
                                              fontSize: 14,
                                              color: ColorResources.blue1D3),
                                        ),
                                        SizedBox(height: 10),
                                        boldText(
                                            billDetails.data?.billNumber
                                                .toString(),
                                            ColorResources.blue1D3,
                                            14),
                                        SizedBox(height: 10),
                                        boldText(
                                            billDetails.data?.billDate
                                                .toString(),
                                            ColorResources.blue1D3,
                                            14),
                                        SizedBox(height: 10),
                                        boldText(
                                            billDetails.data?.billDueDate
                                                .toString(),
                                            ColorResources.blue1D3,
                                            14),
                                        SizedBox(height: 10),
                                        boldText(
                                            billDetails.data?.billPeriod
                                                .toString(),
                                            ColorResources.blue1D3,
                                            14),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ColorResources.white,
                          border: Border.all(
                              color: ColorResources.greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText("₹ ${billDetails.data?.billAmount}",
                                  ColorResources.blue1D3, 16),
                              SizedBox(height: 4),
                              regularText(
                                  "Please verify your details before proceeding to "
                                  "payment No interest will be paid for advance "
                                  "payments",
                                  ColorResources.grey9CA,
                                  13),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            Spacer(),
            billDetails.statuscode.toString() != "TXN"
                ? containerButton(() {
                    Get.back();
                  }, "Go Back")
                : containerButton(() {
                    doBBPS(context);
                  }, "Proceed To Pay"),
          ],
        ),
      ),
    );
  }

  doBBPS(BuildContext context) async {
    Dialogs.showLoadingDialog(context, GlobalKey<State>());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/doBBPS'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'MobileNo': mobNo,
      'provider_id': biller.id.toString(),
      'amount': billDetails.data?.billAmount.toString() ?? '',
      'due_date': billDetails.data?.enquiryReferenceId.toString() ?? '',
      'biller_name': biller.name.toString(),
      'due_date': billDetails.data?.billDueDate.toString() ?? '',
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

      DoBbpsResponseModel userModel = DoBbpsResponseModel.fromJson(parsed);

      if (userModel.statuscode == 'TXN') {
        Get.defaultDialog(
          backgroundColor: ColorResources.white,
          contentPadding: EdgeInsets.zero,
          title: "",
          titlePadding: EdgeInsets.zero,
          content: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorResources.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: boldText(
                            "Transaction ${userModel.status![0].toUpperCase()}${userModel.status!.substring(1).toLowerCase()}",
                            ColorResources.blue1D3,
                            20),
                      ),
                      SizedBox(height: 3),
                      Center(
                        child: regularText(DateTime.now().toString(),
                            ColorResources.grey6B7, 13),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.electric_bolt_rounded,
                            color: ColorResources.blue1D3,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          boldText(userModel.data?.number.toString(),
                              ColorResources.blue1D3, 16),
                        ],
                      ),
                      SizedBox(height: 18),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Operator ID :", ColorResources.grey6B7, 12),
                          boldText(userModel.data?.id.toString(),
                              ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Transaction ID : ", ColorResources.grey6B7, 12),
                          boldText(userModel.data?.txnid.toString(),
                              ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regularText(
                              "Description - ", ColorResources.grey6B7, 12),
                          boldText(userModel.description.toString(),
                              ColorResources.blue1D3, 14),
                        ],
                      ),
                      SizedBox(height: 11),
                      Divider(thickness: 1, color: ColorResources.greyF3F),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mediumText("Amount : ", ColorResources.grey6B7, 16),
                          boldText("₹${userModel.data?.amount}",
                              ColorResources.blue1D3, 20),
                        ],
                      ),
                      SizedBox(height: 20),
                      containerButton(() {
                        Get.offAll(RoutScreen());
                      }, "Ok"),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -70,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: userModel.status == 'success'
                          ? Colors.green
                          : (userModel.status == 'pending'
                              ? Color(0xFFDEBA28)
                              : Color(0xFFB72F12)),
                      shape: BoxShape.circle),
                  child: Center(
                      child: Icon(
                    userModel.status == 'success'
                        ? Icons.check_circle_outline_rounded
                        : (userModel.status == 'pending'
                            ? Icons.access_time_rounded
                            : Icons.close_rounded),
                    color: Colors.white,
                    size: 45,
                  )),
                ),
              ),
            ],
          ),
        );
      } else {
        showBannerMessage('Failed!', context);
      }
      return;
    } else {
      print(streamedResponse.reasonPhrase);
      return;
    }
  }
}
