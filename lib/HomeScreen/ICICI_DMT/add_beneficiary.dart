import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:http/http.dart' as http;
import 'package:gpayapp/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/dmt_bank_list_model.dart';
import '../../Models/get_name_model.dart';
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';
import 'add_beneficiary_repo.dart';
import 'get_dmt_bank_list_repo.dart';

class AddBeneficiary extends StatefulWidget {
  final String mNo;

  AddBeneficiary({Key? key, required this.mNo}) : super(key: key);

  @override
  State<AddBeneficiary> createState() => _AddBeneficiary();
}

class _AddBeneficiary extends State<AddBeneficiary> {
  TextEditingController mobileNo = TextEditingController(text: '1234567890');
  TextEditingController name = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController account2 = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController address = TextEditingController(text: 'not required');
  TextEditingController pin = TextEditingController(text: '012345');
  late AddBeneficiaryRepo addBeneRepo;
  late GetDmtBankList getDmtBankList;
  List<Bank> bankList = [];
  String bankName = 'Select Bank Name';

  @override
  void initState() {
    addBeneRepo = AddBeneficiaryRepo(context);
    getDmtBankList = GetDmtBankList(context);
    getBankList();
    super.initState();
  }

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
        title: boldText("Add Beneficiary", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // regularText(
              //     "Manage your money better by adding another account to make self transfers",
              //     ColorResources.grey6B7,
              //     15),
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
                      items: bankList.map((Bank value) {
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
              textField2("Beneficiary Account Number", account,
                  TextInputType.number, true),
              SizedBox(height: 15),
              textField2("Confirm Beneficiary Account Number", account2,
                  TextInputType.number, true),
              SizedBox(height: 15),
              textField2(
                  "Beneficiary Ifsc Code", ifsc, TextInputType.name, false),
              SizedBox(height: 15),
              textField2("Beneficiary Name", name, TextInputType.name, false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (account.text == account2.text) {
                        if (checkString(ifsc.text) ||
                            checkString(account.text) ||
                            bankName == 'Select Bank Name') {
                          showBannerMessage('All fields are required', context);
                        } else {
                          Dialogs.showLoadingDialog(context, GlobalKey());
                          getName();
                        }
                      } else {
                        showBannerMessage('Account Number Mismatched', context);
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
                      if (account.text == account2.text) {
                        if (checkString(ifsc.text) ||
                            checkString(account.text) ||
                            checkString(name.text) ||
                            bankName == 'Select Bank Name') {
                          showBannerMessage('All fields are required', context);
                        } else {
                          doRegister();
                        }
                      } else {
                        showBannerMessage('Account Number Mismatched', context);
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

  void doRegister() {
    addBeneRepo.add(
        mNo: widget.mNo,
        beneName: name.text,
        beneBank: bankList[bankList.indexWhere((e) => e.bankName == bankName)]
            .bankId
            .toString(),
        beneAccount: account.text,
        beneIfsc: ifsc.text,
        pinCode: pin.text,
        address: address.text,
        beneMobile: mobileNo.text);
  }

  void getBankList() async {
    bankList = (await getDmtBankList.get()) ?? [];
    setState(() {});
  }

  void getName() async {
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
      'bank': bankList[bankList.indexWhere((e) => e.bankName == bankName)]
          .id
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
      if (userModel.statuscode == 'ERR') {
        Get.back();
        showBannerMessage(userModel.message.toString(), context);
      } else {
        Get.back();
        setState(() {
          name.text = userModel.message ?? '';
        });
      }
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }
}
