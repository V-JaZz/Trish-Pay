import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_AEPS/kyc_check.dart';
import 'package:gpayapp/Models/kyc_verify_model.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/aeps_bank_list_response_model.dart';
import '../../Models/aeps_response_model.dart';
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';
import 'do_aeps_trasaction_repo.dart';
import 'get_aeps_bank_list_repo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

class ICICIAEPS extends StatefulWidget {
  ICICIAEPS({Key? key}) : super(key: key);

  @override
  State<ICICIAEPS> createState() => _ICICIAEPSState();
}

class _ICICIAEPSState extends State<ICICIAEPS> {
  late AepsBankListRepo _aepsBankListRepo;
  late AepsTransactionRepo _aepsTransactionRepo;
  AepsBankListModel? aepsBankListModel;
  AepsResponseModel? aepsResponseModel;
  List<Datum> bankList = [];
  bool verified = false;
  List<String> transactionTypeList = <String>[
    'Balance Enquiry',
    'Mini Statement',
    'Cash Withdraw',
    'Aadhaar Pay'
  ];
  String bankName = 'Select Bank Name';
  String transactionType = 'Balance Enquiry';
  TextEditingController mobileNo = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();
  TextEditingController amount = TextEditingController();

  // String infoMessage = 'message';
  String? dataMessage = 'data';

  // PidData? pidData;
  Color continueC = ColorResources.greyC1C;
  bool amountV = false;
  String? _selectedItem;

  static const MethodChannel _channel = MethodChannel('msf100');

  @override
  void initState() {
    _aepsBankListRepo = AepsBankListRepo(context);
    _aepsTransactionRepo = AepsTransactionRepo(context);
    checkKyc();
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
              ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
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
        title: boldText("ICICI Aeps", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: verified
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 65,
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ColorResources.greyF9F,
                      ),
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
                                        color: ColorResources.greyF9F,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorResources.greyF9F,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorResources.greyF9F,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                cursorColor: ColorResources.blue1D3),
                          ),
                          items: bankList.map((Datum value) {
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
                    SizedBox(height: 15),
                    textField2("Customer Mobile number", mobileNo,
                        TextInputType.phone, true),
                    SizedBox(height: 15),
                    textField2("Aadhaar number", aadhaarNo,
                        TextInputType.number, true),
                    SizedBox(height: 15),
                    Container(
                      height: 55,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: ColorResources.greyF9F,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton<String>(
                          items: transactionTypeList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: regularText(
                                  value ?? '', ColorResources.black, 16),
                            );
                          }).toList(),
                          onChanged: (v) {
                            print(v);
                            setState(() {
                              transactionType = v.toString();
                              if (v == 'Balance Enquiry' ||
                                  v == 'Mini Statement') {
                                amountV = false;
                              } else {
                                amountV = true;
                              }
                            });
                          },
                          underline: SizedBox.shrink(),
                          hint: regularText(
                              transactionType, ColorResources.blue1D3, 16),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    amountV == true ? SizedBox(height: 15) : SizedBox.shrink(),
                    amountV == true
                        ? textField2(
                            "Amount", amount, TextInputType.number, true)
                        : SizedBox.shrink(),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        captureFromDevice();
                      },
                      child: Container(
                        height: 52,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorResources.blue1D3,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: boldText(
                              "Capture Fingerprint", ColorResources.white, 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (dataMessage!.contains('errCode="0"')) {
                          doAepsTrans();
                        } else {
                          showBannerMessage(
                              'Capture Fingerprint to continue', context);
                        }
                      },
                      child: Container(
                        height: 52,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: continueC,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: boldText("Continue", ColorResources.white, 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: ColorResources.blue1D3,
                ),
              ),
      ),
    );
  }

  void getBankList() async {
    aepsBankListModel = await _aepsBankListRepo.getBanks();
    if (aepsBankListModel != null) {
      setState(() {
        bankList = aepsBankListModel!.data ?? [];
        verified = true;
      });
    }
  }

  Future<void> captureFromDevice() async {
    // try {
    //   pidData = await Msf100.capture();
    //
    // } on PlatformException catch (e) {
    //   if (mounted) {
    //     setState(() {
    //       infoMessage = e.message ?? 'Unknown exception';
    //       print(e);
    //       print(e);
    //     });
    //   }
    //   return;
    // }
    // if (!mounted) return;
    //   infoMessage = pidData?.resp.errInfo ?? 'Unknown Error';
    dataMessage = await _channel.invokeMethod('capture');
    updateState();
  }

  void doAepsTrans() {
    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
    if (!amountV) {
      amount.text = '0';
    }
    if (bankName == 'Select Bank Name') {
      showBannerMessage("Select Bank Name", context);
      return;
    }
    _aepsTransactionRepo.doAeps(
        nBIN: bankList[bankList.indexWhere((e) => e.bankName == bankName)]
            .bankIin,
        mobNo: mobileNo.text,
        amt: amount.text,
        ANo: aadhaarNo.text,
        data: dataMessage,
        tType: transactionType);
  }

  void updateState() {
    if (dataMessage!.contains('errCode="0"')) {
      continueC = ColorResources.blue1D3;
    } else {
      continueC = ColorResources.greyC1C;
    }
    setState(() {});
  }

  void checkKyc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/Paysprint/doAeps'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId.toString(),
      'transactionType': 'kyc_check'
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      KycVerifyModel userModel = KycVerifyModel.fromJson(parsed);
      if (userModel.statuscode == 'KNF') {
        Get.off(KycCheck(
          mobile: userModel.mobile!,
          aadhaarCard: userModel.aadhaar!,
          panCard: userModel.pan!,
          email: userModel.email!,
        ));
      } else {
        getBankList();
      }
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }
}
