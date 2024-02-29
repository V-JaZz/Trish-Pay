import 'dart:convert';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/dmt_report_model.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'dmt_receipts.dart';

class DMTReport extends StatefulWidget {
  @override
  State<DMTReport> createState() => _DMTReport();
}

class _DMTReport extends State<DMTReport> {
  TextEditingController amount = TextEditingController();
  DmtReportModel? model;
  List<Datum>? reports;
  Future<List<Datum>?>? fReports;
  bool listVisible = true;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<DateTime?>? dateList;

  @override
  void initState() {
    fReports = loadDmtReport();
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
          padding: EdgeInsets.all(8.0),
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
        title: boldText("DMT Report", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
                        listVisible = false;
                        fReports = loadDmtReport();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorResources.blue1D3,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: boldText(
                            "Select Time Range", ColorResources.white, 14),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'From:  ${dateFormat.format(dateList?.first ?? DateTime.now())}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'To:  ${dateFormat.format(dateList?.last ?? DateTime.now())}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Visibility(
                  visible: listVisible,
                  replacement: Center(
                    child: CircularProgressIndicator(
                      color: ColorResources.blue1D3,
                    ),
                  ),
                  child: FutureBuilder(
                    future: fReports,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        if (reports != null &&
                            reports != [] &&
                            reports!.isNotEmpty) {
                          return Container(
                            padding: EdgeInsets.only(top: 15),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children:
                                  List.generate(reports?.length ?? 0, (i) {
                                return ListTile(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 15, top: 15),
                                    onTap: () {
                                      Get.to(DMTReceipt(report: reports![i]));
                                    },
                                    leading: Container(
                                      decoration: BoxDecoration(
                                          color: reports![i].status == 'success'
                                              ? Colors.green
                                              : (reports![i].status == 'pending'
                                                  ? Color(0xFFDEBA28)
                                                  : Color(0xFFB72F12)),
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                            reports![i].status == 'success'
                                                ? Icons
                                                    .check_circle_outline_rounded
                                                : (reports![i].status ==
                                                        'pending'
                                                    ? Icons.access_time_rounded
                                                    : Icons.close_rounded),
                                            color: Colors.white,
                                            size: 24),
                                      ),
                                    ),
                                    title: boldText(reports![i].number,
                                        ColorResources.blue1D3, 18),
                                    subtitle: regularText(reports![i].updatedAt,
                                        ColorResources.grey6B7, 14),
                                    trailing:
                                        // index == 3 || index == 8 ?
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        boldText(
                                            '₹${reports![i].amount}',
                                            reports![i].status == 'success'
                                                ? ColorResources.green00B
                                                : reports![i].status ==
                                                        'pending'
                                                    ? Color(0xFFDEBA28)
                                                    : ColorResources.redF53,
                                            21),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: regularText(
                                              '${reports![i].status![0].toUpperCase()}${reports![i].status!.substring(1).toLowerCase()}',
                                              reports![i].status == 'success'
                                                  ? ColorResources.green00B
                                                  : reports![i].status ==
                                                          'pending'
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
                          );
                        } else {
                          return Container(
                              padding: EdgeInsets.only(bottom: Get.width / 3),
                              alignment: Alignment.center,
                              child: mediumText('Not Data Found!',
                                  ColorResources.greyC1C, 18));
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorResources.blue1D3,
                          ),
                        );
                      }
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Datum>?> loadDmtReport() async {
    // Future.delayed(Duration(microseconds: 500),() {
    //   Dialogs.showLoadingDialog(context, GlobalKey<State>());
    // });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/getTransaction'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
      'Type': 'dmtstatement',
      'StartDate': dateFormat.format(dateList?.first ?? DateTime.now()),
      'EndDate': dateFormat.format(dateList?.last ?? DateTime.now())
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
      DmtReportModel userModel = DmtReportModel.fromJson(parsed);
      setState(() {
        model = userModel;
        reports = model?.data;
        listVisible = true;
      });
      return reports;
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }
}
