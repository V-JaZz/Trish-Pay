import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_Payout/icici_payout.dart';
import 'package:gpayapp/Models/common_model.dart';
import 'package:gpayapp/Models/get_name_model.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/icici_payout_details_model.dart';
import 'package:http/http.dart' as http;
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';

class AddBankAccount extends StatefulWidget {
  final List<Bank> banks;

  AddBankAccount({Key? key, required this.banks}) : super(key: key);

  @override
  State<AddBankAccount> createState() => _AddBankAccount();
}

class _AddBankAccount extends State<AddBankAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController ifsc = TextEditingController();

  String bankName = 'Select Bank Name';
  String accountType = 'Select Account Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 18, top: 8, bottom: 8),
          child: InkWell(
            onTap: () {
              Get.off(ICICIPayout());
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
        title: boldText("Add Bank Account", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                height: 65,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorResources.greyF9F,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: DropdownSearch<String>(
                      dropdownBuilder: (context, selectedItem) {
                        return regularText(
                            bankName, ColorResources.blue1D3, 16);
                      },
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: false,
                        searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              hintText: 'Search',
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
                            cursorColor: ColorResources.blue1D3),
                      ),
                      items: widget.banks.map((Bank value) {
                        return value.bankName ?? '';
                      }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          floatingLabelStyle: TextStyle(
                              color: ColorResources.blue1D3, fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                      onChanged: (v) {
                        print(v);
                        setState(() {
                          bankName = v.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorResources.greyF9F,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 25),
                  child: DropdownButton<String>(
                    items: <String>['Saving', 'Current'].map((String v) {
                      return DropdownMenuItem(
                        value: v,
                        child: regularText(v, ColorResources.black, 16),
                      );
                    }).toList(),
                    onChanged: (v) {
                      print(v);
                      setState(() {
                        accountType = v.toString();
                      });
                    },
                    underline: SizedBox.shrink(),
                    hint: regularText(accountType, ColorResources.blue1D3, 16),
                    isExpanded: true,
                  ),
                ),
              ),
              SizedBox(height: 15),
              textField2("Account Number", account, TextInputType.number, true),
              SizedBox(height: 15),
              textField2("Ifsc", ifsc, TextInputType.name, false),
              SizedBox(height: 15),
              textField2("Name", name, TextInputType.name, false),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (checkString(ifsc.text) ||
                          checkString(account.text) ||
                          bankName == 'Select Bank Name' ||
                          accountType == 'Select Account Type') {
                        showBannerMessage('All fields are required', context);
                      } else {
                        getName();
                      }
                    },
                    child: Container(
                      height: 52,
                      width: Get.width / 3,
                      decoration: BoxDecoration(
                          color: ColorResources.greyF9F,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 1, color: ColorResources.blue1D3)),
                      child: Center(
                        child: boldText("Get Name", ColorResources.blue1D3, 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (checkString(ifsc.text) ||
                          checkString(account.text) ||
                          checkString(name.text) ||
                          bankName == 'Select Bank Name' ||
                          accountType == 'Select Account Type') {
                        showBannerMessage('All fields are required', context);
                      } else {
                        addBankAccount();
                      }
                    },
                    child: Container(
                      height: 52,
                      width: Get.width / 2,
                      decoration: BoxDecoration(
                        color: ColorResources.blue1D3,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: boldText("Continue", ColorResources.white, 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addBankAccount() async {
    Dialogs.showLoadingDialog(context, GlobalKey());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://trishpay.com/api/Android/ICICIPayout/doPayout/addbank'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId.toString(),
      'account_type': accountType,
      'bank': widget
          .banks[widget.banks.indexWhere((e) => e.bankName == bankName)].id
          .toString(),
      'account': account.text,
      'name': name.text,
      'ifsc': ifsc.text
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      CommonModel userModel = CommonModel.fromJson(parsed);
      if (userModel.statuscode == 'ERR') {
        Get.back();
        showBannerMessage(userModel.message.toString(), context);
      } else {
        Get.back();
        Get.off(ICICIPayout());
      }
    } else {
      Get.back();
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

  void getName() async {
    Dialogs.showLoadingDialog(context, GlobalKey());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://trishpay.com/api/Android/ICICIPayout/doPayout/getname'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId.toString(),
      'bank': widget
          .banks[widget.banks.indexWhere((e) => e.bankName == bankName)].id
          .toString(),
      'account': account.text,
      'ifsc': ifsc.text
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      GetNameModel userModel = GetNameModel.fromJson(parsed);
      Get.back();
      if (userModel.statuscode == 'ERR') {
        showBannerMessage(userModel.message.toString(), context);
      } else {
        setState(() {
          name.text = userModel.message ?? '';
        });
      }
    } else {
      Get.back();
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

// void doRegister() {
//   addBeneRepo.add(mNo: widget.mNo, beneName: name.text, beneBank: bankList[bankList.indexWhere((e) => e.bankName == bankName)].id.toString(), beneAccount: account.text, beneIfsc: ifsc.text, pinCode: pin.text, address: address.text, beneMobile: mobileNo.text);
// }
//
// void getBankList() async {
//   bankList = (await getDmtBankList.get())!;
//   setState(() {
//   });
// }
}
