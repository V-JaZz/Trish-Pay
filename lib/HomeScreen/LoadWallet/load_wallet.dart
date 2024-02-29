import 'dart:convert';
import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/common_model.dart';
import '../../Models/get_fund_banks_response_model.dart';
import '../../Models/wallet_trans_report_model.dart';
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';
import 'get_fund_banks_repo.dart';

class LoadWallet extends StatefulWidget {
  @override
  State<LoadWallet> createState() => _LoadWalletState();
}

class _LoadWalletState extends State<LoadWallet> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  TextEditingController refNo = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController remark = TextEditingController();

  String? paySlipImage;
  String bankName = 'Select Bank';
  String payMode = 'Select Pay Mode';

  List<DateTime?>? payDate;
  List<Bank> bankList = [];
  List<Paymode> payModeList = [];

  GetFundBanksResponseModel? gfbrm;
  late GetFundBanksRepo getFundBanksRepo;

  List<String> titles = ['Enter Details', 'History'];
  String title = 'Enter Details';

  @override
  void initState() {
    getFundBanksRepo = GetFundBanksRepo(context);
    getBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorResources.blue1D3,
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
                  color: ColorResources.blue1D3,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: ColorResources.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          title: boldText(title, ColorResources.white, 20),
          bottom: TabBar(
            indicatorColor: ColorResources.orangeFB9,
            onTap: (i) {
              if (title == 'History') {}
              setState(() {
                title = titles[i];
              });
            },
            tabs: [
              Tab(
                text: "Request",
              ),
              Tab(
                text: "Reports",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
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
                        items: bankList.map((Bank value) {
                          return DropdownMenuItem(
                            value: value.name,
                            child: mediumText(
                                value.name ?? '', ColorResources.blue1D3, 16),
                          );
                        }).toList(),
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            bankName = v.toString();
                          });
                        },
                        underline: SizedBox.shrink(),
                        hint: regularText(bankName, ColorResources.blue1D3, 16),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  bankName != 'Select Bank'
                      ? SizedBox(height: 6)
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? Text(
                          ' Account :  ${bankList[bankList.indexWhere((e) => e.name == bankName)].account.toString()}',
                          style: TextStyle(
                              color: ColorResources.blue1D3, fontSize: 15))
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? SizedBox(height: 6)
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? Text(
                          ' Branch :  ${bankList[bankList.indexWhere((e) => e.name == bankName)].branch.toString()}',
                          style: TextStyle(color: ColorResources.blue1D3))
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? SizedBox(height: 6)
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? Text(
                          ' IFSC :  ${bankList[bankList.indexWhere((e) => e.name == bankName)].ifsc.toString()}',
                          style: TextStyle(color: ColorResources.blue1D3))
                      : SizedBox.shrink(),
                  bankName != 'Select Bank'
                      ? SizedBox(height: 6)
                      : SizedBox.shrink(),
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
                        items: payModeList.map((Paymode value) {
                          return DropdownMenuItem(
                            value: value.name,
                            child: mediumText(
                                value.name ?? '', ColorResources.blue1D3, 16),
                          );
                        }).toList(),
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            payMode = v.toString();
                          });
                        },
                        underline: SizedBox.shrink(),
                        hint: regularText(payMode, ColorResources.blue1D3, 16),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  textField2("Reference No", refNo, TextInputType.name, false),
                  SizedBox(height: 15),
                  textField2("Amount", amount, TextInputType.number, true),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () async {
                      payDate = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: CalendarDatePicker2WithActionButtonsConfig(),
                          dialogSize: const Size(325, 400),
                          value: payDate ?? [],
                          borderRadius: BorderRadius.circular(15));
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12),
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorResources.greyE5E,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: lightText(
                          'Select pay date >', ColorResources.black, 16),
                    ),
                  ),
                  SizedBox(height: 3),
                  payDate.toString() != 'null'
                      ? Text(
                          '  ${payDate?.first?.day}-${payDate?.first?.month}-${payDate?.first?.year}',
                          style: TextStyle(
                              color: ColorResources.blue1D3.withOpacity(0.7),
                              fontSize: 12))
                      : SizedBox.shrink(),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      paySlipImage = await pickImageFile(context);
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12),
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorResources.greyE5E,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: lightText(
                          'Select pay slips image >', ColorResources.black, 16),
                    ),
                  ),
                  SizedBox(height: 3),
                  paySlipImage.toString() != 'null'
                      ? Text(paySlipImage.toString(),
                          style: TextStyle(
                              color: ColorResources.blue1D3.withOpacity(0.7),
                              fontSize: 12))
                      : SizedBox.shrink(),
                  SizedBox(height: 15),
                  textField2("Remarks", remark, TextInputType.text, false),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (checkString(refNo.text) ||
                          checkString(amount.text) ||
                          checkString(remark.text) ||
                          bankName == 'Select Bank' ||
                          payMode == 'Select Pay Mode' ||
                          payDate == null ||
                          bankList == [] ||
                          payModeList == []) {
                        showBannerMessage('All fields are required', context);
                      } else {
                        requestFund();
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
                        child: boldText("Continue", ColorResources.white, 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Reports()
          ],
        ),
      ),
    );
  }

  Future<String?> pickImageFile(BuildContext context) async {
    print('pick image');
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      print(platformFile.name);
      print(platformFile.size);
      print(platformFile.extension);
      print(platformFile.path);
      showBannerMessage('Selected ${platformFile.name}', context);

      final file = File(platformFile.path.toString());
      List<int> imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return file.path;
    } else {
      print('canceled');
      // User canceled the picker
      return null;
    }
  }

  void requestFund() async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://trishpay.com/api/Android/getFund'));
    request.fields.addAll({
      'Type': 'request',
      'Token': tok ?? '',
      'UserId': uId.toString() ?? '',
      'DeviceId': dId ?? '',
      'fundbank_id': bankList[bankList.indexWhere((e) => e.name == bankName)]
          .id
          .toString(),
      'paymode': payMode,
      'amount': amount.text,
      'ref_no': refNo.text,
      'paydate':
          '${payDate?.first?.year}-${payDate?.first?.month}-${payDate?.first?.day}',
      'remark': remark.text
    });
    request.files
        .add(await http.MultipartFile.fromPath('payslips', paySlipImage ?? ''));

    print(request.toString());

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    Get.back();
    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      CommonModel userModel = CommonModel.fromJson(parsed);
      if (userModel.status == "success") {
        clearFields();
        showBannerMessage("Requested Successfully!", context);
      } else {
        showBannerMessage(userModel.message ?? '', context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void getBanks() async {
    gfbrm = await getFundBanksRepo.get();
    if (gfbrm != null) {
      bankList = gfbrm?.data?.banks ?? [];
      payModeList = gfbrm?.data?.paymodes ?? [];
      setState(() {});
    }
  }

  void clearFields() {
    setState(() {
      refNo.text = '';
      amount.text = '';
      remark.text = '';
      bankName = 'Select Bank';
      payMode = 'Select Pay Mode';
      payDate = null;
      bankList = [];
      payModeList = [];
      paySlipImage = null;
    });
  }
}

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List<TInfo>? reports;
  Future<WalletTransReportModel?>? fReports;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<DateTime?>? dateList;

  @override
  void initState() {
    fReports = getReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  dateList = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                          calendarType: CalendarDatePicker2Type.range,
                          selectedDayTextStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                          selectedDayHighlightColor: ColorResources.blue1D3,
                          centerAlignModePicker: true,
                          customModePickerIcon: SizedBox(),
                          lastDate: DateTime.now()),
                      dialogSize: const Size(325, 400),
                      value: dateList ?? [],
                      borderRadius: BorderRadius.circular(15));
                  print(dateList?.first);
                  print(dateList?.last);
                  setState(() {
                    fReports = getReports();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(width: 1, color: ColorResources.blue1D3)),
                  child: Center(
                    child: boldText(
                        "Select Time Range", ColorResources.blue1D3, 14),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'From:  ${dateFormat.format(dateList?.first ?? DateTime.now())}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.blue1D3),
                  ),
                  Text(
                    'To:  ${dateFormat.format(dateList?.last ?? DateTime.now())}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorResources.blue1D3),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: fReports,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return reports != null && reports != [] && reports!.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: 8),
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: List.generate(reports?.length ?? 0, (i) {
                            return ListTile(
                                contentPadding: EdgeInsets.only(bottom: 30),
                                onTap: () {
                                  showReportInfo(reports![i]);
                                },
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: reports![i].status == 'approved'
                                          ? Colors.green
                                          : (reports![i].status == 'pending'
                                              ? Color(0xFFDEBA28)
                                              : Color(0xFFB72F12)),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: reports![i].status == 'rejected'
                                        ? const EdgeInsets.all(8.0)
                                        : EdgeInsets.all(0),
                                    child: Icon(
                                        reports![i].status == 'approved'
                                            ? Icons.check_circle_outline_rounded
                                            : (reports![i].status == 'pending'
                                                ? Icons.access_time_rounded
                                                : Icons.close_rounded),
                                        color: Colors.white,
                                        size: reports![i].status == 'rejected'
                                            ? 24
                                            : 45),
                                  ),
                                ),
                                title: boldText(reports![i].paymode,
                                    ColorResources.blue1D3, 18),
                                subtitle: regularText(reports![i].paydate,
                                    ColorResources.grey6B7, 14),
                                trailing:
                                    // index == 3 || index == 8 ?
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    boldText(
                                        '₹${reports![i].amount}',
                                        reports![i].status == 'approved'
                                            ? ColorResources.green00B
                                            : reports![i].status == 'pending'
                                                ? Color(0xFFDEBA28)
                                                : ColorResources.redF53,
                                        21),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: regularText(
                                          '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                          reports![i].status == 'approved'
                                              ? ColorResources.green00B
                                              : reports![i].status == 'pending'
                                                  ? Color(0xFFDEBA28)
                                                  : ColorResources.redF53,
                                          14),
                                    ),
                                  ],
                                )
                                // : boldText(
                                // historyList[index]["text3"],
                                // index == 0 || index == 5
                                //     ? ColorResources.green00B
                                //     : index == 3 || index == 8
                                //     ? ColorResources.black.withOpacity(0.35)
                                //     : ColorResources.redF53,
                                // 21),
                                );
                          }),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(bottom: Get.width / 3),
                        alignment: Alignment.center,
                        child: mediumText(
                            'Not Data Found!', ColorResources.greyC1C, 18));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.blue1D3,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  Future<WalletTransReportModel?> getReports() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/getTransaction'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString() ?? '',
      'DeviceId': dId ?? '',
      'Type': 'fundrequest',
      'StartDate': dateFormat.format(dateList?.first ?? DateTime.now()),
      'EndDate': dateFormat.format(dateList?.last ?? DateTime.now())
    };
    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body.toString());

      var parsed = jsonDecode(response.body);
      WalletTransReportModel walletTransReportModel =
          WalletTransReportModel.fromJson(parsed);
      reports = walletTransReportModel.data;
      return walletTransReportModel;
    } else {
      print(streamedResponse.reasonPhrase);
    }

    return null;
  }

  showReportInfo(TInfo tInfo) {
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
            height: Get.height * 0.7,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorResources.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: boldText(
                        "Transaction ${tInfo.status![0].toUpperCase()}${tInfo.status!.substring(1).toLowerCase()}",
                        ColorResources.blue1D3,
                        20),
                  ),
                  SizedBox(height: 3),
                  Center(
                    child:
                        regularText(tInfo.paydate, ColorResources.grey6B7, 13),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_to_mobile_rounded,
                        color: ColorResources.blue1D3,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      boldText(tInfo.paymode, ColorResources.blue1D3, 16),
                    ],
                  ),
                  SizedBox(height: 18),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText(
                          "Account Number :", ColorResources.grey6B7, 12),
                      boldText(
                          tInfo.fundbank?.account, ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 11),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: regularText(
                              "Bank Name :", ColorResources.grey6B7, 12)),
                      Expanded(
                        flex: 2,
                        child: Text(
                          tInfo.fundbank?.name.toString() ?? '',
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontFamily: TextFontFamily.ROBOTO_BOLD,
                              fontSize: 14,
                              color: ColorResources.blue1D3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 11),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("IFSC :", ColorResources.grey6B7, 12),
                      boldText(
                          tInfo.fundbank?.ifsc, ColorResources.blue1D3, 14),
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
                      boldText(tInfo.refNo, ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 11),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("Remarks : ", ColorResources.grey6B7, 12),
                      boldText(tInfo.remark, ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 11),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText("Amount : ", ColorResources.grey6B7, 12),
                      boldText(
                          tInfo.amount.toString(), ColorResources.blue1D3, 20),
                    ],
                  ),
                  SizedBox(height: 11),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText("Pay Slip : ", ColorResources.grey6B7, 12),
                      SizedBox(
                        width: Get.width / 3,
                        child: Image.network(
                          'https://trishpay.com/public/deposit_slip/${tInfo.payslip}',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  containerButton(() {
                    Get.back();
                    // Get.offAll(RoutScreen());
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
                  color: tInfo.status == 'approved'
                      ? Colors.green
                      : (tInfo.status == 'pending'
                          ? Color(0xFFDEBA28)
                          : Color(0xFFB72F12)),
                  shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                tInfo.status == 'approved'
                    ? Icons.check_circle_outline_rounded
                    : (tInfo.status == 'pending'
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
  }
}
