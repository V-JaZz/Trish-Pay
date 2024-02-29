import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/NotificationsScreen/notification_screen.dart';
import 'package:gpayapp/Search_Screen/search_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home_screen.dart';
import '../Models/main_aeps_report_model.dart';
import '../Utils/font_family.dart';
import '../constants/constants.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(27),
                bottomLeft: Radius.circular(27),
              ),
              color: ColorResources.blue1D3,
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 54, bottom: 20, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(SearchScreen());
                      },
                      child: SvgPicture.asset(Images.search,
                          color: ColorResources.white)),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(ScanQrCodeScreen());
                  //   },
                  //   child: SvgPicture.asset(Images.scanIcon),
                  // ),

                  SizedBox(
                    height: 32,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MAIN : ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              'AEPS : ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹ $s1',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              '₹ $s2',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(NotificationScreen());
                      },
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Padding(
                  padding: EdgeInsets.only(top: 110, bottom: 100),
                  child: Column(
                    children: [
                      TabBar(
                        indicatorColor: ColorResources.blue1D3,
                        labelColor: ColorResources.blue1D3,
                        tabs: [
                          Tab(
                            text: "MAIN",
                          ),
                          Tab(
                            text: "AEPS",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            MainWalletReport(type: 'awalletstatement'),
                            AepsWalletReport(type: 'aepsstatement')
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
// ScrollConfiguration(
// behavior: MyBehavior(),
// child: Padding(
// padding: EdgeInsets.only(top: 80, bottom: 100)
// ),
// ),

class AepsWalletReport extends StatefulWidget {
  final String type;

  const AepsWalletReport({Key? key, required this.type}) : super(key: key);

  @override
  State<AepsWalletReport> createState() => _AepsWalletReportState();
}

class _AepsWalletReportState extends State<AepsWalletReport> {
  List<Report>? reports;
  Future<MainAepsReportModel?>? fReports;
  bool listVisible = true;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<DateTime?>? dateList;

  @override
  void initState() {
    fReports = getReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listVisible,
      replacement: Center(
        child: CircularProgressIndicator(
          color: ColorResources.blue1D3,
        ),
      ),
      child: FutureBuilder(
        future: fReports,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            dateList = await showCalendarDatePicker2Dialog(
                                context: context,
                                config:
                                    CalendarDatePicker2WithActionButtonsConfig(
                                        calendarType:
                                            CalendarDatePicker2Type.range,
                                        selectedDayTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                        selectedDayHighlightColor:
                                            ColorResources.blue1D3,
                                        centerAlignModePicker: true,
                                        customModePickerIcon: SizedBox(),
                                        lastDate: DateTime.now()),
                                dialogSize: const Size(325, 400),
                                value: dateList ?? [],
                                borderRadius: BorderRadius.circular(15));
                            print(dateList?.first);
                            print(dateList?.last);
                            setState(() {
                              listVisible = false;
                              fReports = getReports();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    width: 1, color: ColorResources.blue1D3)),
                            child: Center(
                              child: boldText("Select Time Range",
                                  ColorResources.blue1D3, 14),
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
                  reports != null && reports != [] && reports!.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(top: 0),
                            physics: BouncingScrollPhysics(),
                            children: List.generate(reports?.length ?? 0, (i) {
                              return InkWell(
                                onTap: () {
                                  showReportInfo(reports![i]);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: ColorResources.greyF3F,
                                        width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      regularText(
                                          reports![i].createdAt.toString(),
                                          Colors.grey,
                                          14),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              boldText(
                                                  '₹${reports?[i].balance?.toStringAsFixed(1)}',
                                                  ColorResources.blue1D3,
                                                  18),
                                              SizedBox(height: 4),
                                              mediumText(
                                                  reports![i].txnid.toString(),
                                                  ColorResources.grey6B7,
                                                  16),
                                              regularText(
                                                  getAepsType(
                                                      reports?[i].aepstype),
                                                  Colors.grey,
                                                  14),
                                              SizedBox(height: 4),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              boldText(
                                                  '${reports![i].type == 'debit' ? '-' : '+'} ₹${reports![i].amount?.round()}',
                                                  reports![i].type == 'debit' ||
                                                          reports![i].status ==
                                                              'failed'
                                                      ? ColorResources.orangeFB9
                                                      : ColorResources.green00B,
                                                  20),
                                              if (reports![i].status ==
                                                  'failed')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.orangeFB9,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'pending')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.orangeFB9,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'refunded')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.green00B,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'success')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].type?.toUpperCase()}',
                                                      reports![i].type ==
                                                              'debit'
                                                          ? ColorResources
                                                              .orangeFB9
                                                          : ColorResources
                                                              .green00B,
                                                      14),
                                                )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: Get.width / 3),
                          alignment: Alignment.center,
                          child: mediumText(
                              'Not Data Found!', ColorResources.greyC1C, 18)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
                padding: EdgeInsets.only(bottom: Get.width / 3),
                alignment: Alignment.center,
                child: mediumText(
                    '${snapshot.error}', ColorResources.greyC1C, 18));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ColorResources.blue1D3,
              ),
            );
          }
        },
      ),
    );
  }

  Future<MainAepsReportModel?> getReports() async {
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
      'Type': widget.type,
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
      MainAepsReportModel walletTransReportModel =
          MainAepsReportModel.fromJson(parsed);
      setState(() {
        reports = walletTransReportModel.data;
        listVisible = true;
      });
      return walletTransReportModel;
    } else {
      print(streamedResponse.reasonPhrase);
    }

    return null;
  }

  showReportInfo(Report report) {
    Get.defaultDialog(
      backgroundColor: ColorResources.white,
      contentPadding: EdgeInsets.zero,
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Container(
        height: Get.height * 0.7,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorResources.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: boldText(report.status?.toUpperCase(),
                        ColorResources.blue1D3, 18),
                  ),
                  SizedBox(height: 3),
                  Center(
                    child: regularText(report.createdAt.toString(),
                        ColorResources.grey6B7, 14),
                  ),
                  SizedBox(height: 16),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: regularText(
                              "Name :", ColorResources.grey6B7, 12)),
                      Expanded(
                        flex: 2,
                        child: Text(
                          report.username.toString(),
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
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
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
                          report.bank.toString().toUpperCase(),
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
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("Product :", ColorResources.grey6B7, 12),
                      boldText(report.product.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("Number :", ColorResources.grey6B7, 12),
                      boldText(report.mobile.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText(
                          "Transaction ID : ", ColorResources.grey6B7, 12),
                      boldText(report.refno.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("ST Type : ", ColorResources.grey6B7, 12),
                      boldText(report.rtype.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText("Amount : ", ColorResources.grey6B7, 16),
                      boldText(
                          '${report.type == 'debit' ? '-' : '+'}${report.amount}',
                          ColorResources.blue1D3,
                          20),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText(
                          "Closing Balance : ", ColorResources.grey6B7, 16),
                      boldText(report.balance.toString(),
                          ColorResources.blue1D3, 20),
                    ],
                  ),
                ],
              ),
              containerButton(() {
                Get.back();
                // Get.offAll(RoutScreen());
              }, "Ok")
            ],
          ),
        ),
      ),
    );
  }

  String getAepsType(String? aepstype) {
    String tType = '';

    if (aepstype == 'BE') {
      tType = 'Balance Enquiry';
    } else if (aepstype == 'MS') {
      tType = 'Mini Statement';
    } else if (aepstype == 'CW') {
      tType = 'Cash Withdraw';
    } else {
      tType = 'Aadhaar Pay';
    }
    return tType;
  }
}

class MainWalletReport extends StatefulWidget {
  final String type;

  const MainWalletReport({Key? key, required this.type}) : super(key: key);

  @override
  State<MainWalletReport> createState() => _MainWalletReportState();
}

class _MainWalletReportState extends State<MainWalletReport> {
  List<Report>? reports;
  Future<MainAepsReportModel?>? fReports;
  bool listVisible = true;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<DateTime?>? dateList;

  @override
  void initState() {
    fReports = getReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: listVisible,
      replacement: Center(
        child: CircularProgressIndicator(
          color: ColorResources.blue1D3,
        ),
      ),
      child: FutureBuilder(
        future: fReports,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            dateList = await showCalendarDatePicker2Dialog(
                                context: context,
                                config:
                                    CalendarDatePicker2WithActionButtonsConfig(
                                        calendarType:
                                            CalendarDatePicker2Type.range,
                                        selectedDayTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                        selectedDayHighlightColor:
                                            ColorResources.blue1D3,
                                        centerAlignModePicker: true,
                                        customModePickerIcon: SizedBox(),
                                        lastDate: DateTime.now()),
                                dialogSize: const Size(325, 400),
                                value: dateList ?? [],
                                borderRadius: BorderRadius.circular(15));
                            print(dateList?.first);
                            print(dateList?.last);
                            setState(() {
                              listVisible = false;
                              fReports = getReports();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    width: 1, color: ColorResources.blue1D3)),
                            child: Center(
                              child: boldText("Select Time Range",
                                  ColorResources.blue1D3, 14),
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
                  reports != null && reports != [] && reports!.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(top: 0),
                            physics: BouncingScrollPhysics(),
                            children: List.generate(reports?.length ?? 0, (i) {
                              return InkWell(
                                onTap: () {
                                  showReportInfo(reports![i]);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: ColorResources.greyF3F,
                                        width: 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      regularText(
                                          reports![i].createdAt.toString(),
                                          Colors.grey,
                                          14),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              boldText(
                                                  '₹${reports?[i].balance?.toStringAsFixed(1)}',
                                                  ColorResources.blue1D3,
                                                  18),
                                              SizedBox(height: 4),
                                              mediumText(
                                                  reports![i].txnid.toString(),
                                                  ColorResources.grey6B7,
                                                  16),
                                              regularText(
                                                  reports?[i]
                                                          .product
                                                          ?.toUpperCase() ??
                                                      '',
                                                  Colors.grey,
                                                  14),
                                              SizedBox(height: 4),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              boldText(
                                                  '${reports![i].transType == 'debit' ? '-' : '+'} ₹${reports![i].amount?.round()}',
                                                  reports![i].status ==
                                                              'failed' ||
                                                          reports![i]
                                                                  .transType ==
                                                              'debit'
                                                      ? ColorResources.orangeFB9
                                                      : ColorResources.green00B,
                                                  20),
                                              if (reports![i].status ==
                                                  'failed')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.orangeFB9,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'pending')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.orangeFB9,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'refunded')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                                      ColorResources.green00B,
                                                      14),
                                                ),
                                              if (reports![i].status ==
                                                  'success')
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: regularText(
                                                      '${reports![i].transType?.toUpperCase()}',
                                                      reports![i].transType ==
                                                              'debit'
                                                          ? ColorResources
                                                              .orangeFB9
                                                          : ColorResources
                                                              .green00B,
                                                      14),
                                                )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: Get.width / 3),
                          alignment: Alignment.center,
                          child: mediumText(
                              'Not Data Found!', ColorResources.greyC1C, 18)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
                padding: EdgeInsets.only(bottom: Get.width / 3),
                alignment: Alignment.center,
                child: mediumText(
                    '${snapshot.error}', ColorResources.greyC1C, 18));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ColorResources.blue1D3,
              ),
            );
          }
        },
      ),
    );
  }

  Future<MainAepsReportModel?> getReports() async {
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
      'Type': widget.type,
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
      MainAepsReportModel walletTransReportModel =
          MainAepsReportModel.fromJson(parsed);
      setState(() {
        reports = walletTransReportModel.data;
        listVisible = true;
      });
      return walletTransReportModel;
    } else {
      print(streamedResponse.reasonPhrase);
    }

    return null;
  }

  showReportInfo(Report report) {
    Get.defaultDialog(
      backgroundColor: ColorResources.white,
      contentPadding: EdgeInsets.zero,
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Container(
        height: Get.height * 0.7,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorResources.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: boldText(report.status?.toUpperCase(),
                        ColorResources.blue1D3, 18),
                  ),
                  SizedBox(height: 3),
                  Center(
                    child: regularText(report.createdAt.toString(),
                        ColorResources.grey6B7, 14),
                  ),
                  SizedBox(height: 16),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: regularText(
                              "Name :", ColorResources.grey6B7, 12)),
                      Expanded(
                        flex: 2,
                        child: Text(
                          report.username.toString(),
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
                  if (report.option3 != null) SizedBox(height: 9),
                  if (report.option3 != null)
                    Divider(thickness: 1, color: ColorResources.greyF3F),
                  if (report.option3 != null) SizedBox(height: 9),
                  if (report.option3 != null)
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
                            report.option3.toString().toUpperCase(),
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
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("Product :", ColorResources.grey6B7, 12),
                      boldText(report.product.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("Number :", ColorResources.grey6B7, 12),
                      boldText(report.mobile.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText(
                          "Transaction ID : ", ColorResources.grey6B7, 12),
                      boldText(report.refno.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      regularText("ST Type : ", ColorResources.grey6B7, 12),
                      boldText(report.rtype.toString().toUpperCase(),
                          ColorResources.blue1D3, 14),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText("Amount : ", ColorResources.grey6B7, 16),
                      boldText(
                          '${report.transType == 'debit' ? '-' : '+'}${report.amount}',
                          ColorResources.blue1D3,
                          20),
                    ],
                  ),
                  SizedBox(height: 9),
                  Divider(thickness: 1, color: ColorResources.greyF3F),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText(
                          "Closing Balance : ", ColorResources.grey6B7, 16),
                      boldText(report.balance.toString(),
                          ColorResources.blue1D3, 20),
                    ],
                  ),
                ],
              ),
              containerButton(() {
                Get.back();
                // Get.offAll(RoutScreen());
              }, "Ok")
            ],
          ),
        ),
      ),
    );
  }

  String getAepsType(String? aepstype) {
    String tType = '';

    if (aepstype == 'BE') {
      tType = 'Balance Enquiry';
    } else if (aepstype == 'MS') {
      tType = 'Mini Statement';
    } else if (aepstype == 'CW') {
      tType = 'Cash Withdraw';
    } else {
      tType = 'Aadhaar Pay';
    }
    return tType;
  }
}
