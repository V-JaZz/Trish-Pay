import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/Reports/recharge_reciepts.dart';
import 'package:screenshot/screenshot.dart';

import '../../Models/dmt_report_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/common_widget.dart';
import '../../Utils/images.dart';
import '../../constants/constants.dart';

class DMTReceipt extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();
  final Datum? report;

  DMTReceipt({Key? key, this.report}) : super(key: key);

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
          title: boldText("Receipt", ColorResources.black, 20),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorResources.blue1D3,
            onPressed: () {
              shareScreen(screenshotController);
            },
            child: Icon(Icons.share)),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: ColorResources.greyE1E,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText('$appName', ColorResources.blue1D3, 18),
                            lightText('$appWebsite', ColorResources.black, 14)
                          ]),
                      SvgPicture.asset(
                        Images.trishPayLog,
                        width: Get.width / 4,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Table(
                      columnWidths: {
                        0: FlexColumnWidth(5),
                        1: FlexColumnWidth(5)
                      },
                      border: TableBorder.all(
                          width: 1,
                          color: ColorResources.greyC1C,
                          borderRadius: BorderRadius.circular(3)),
                      children: [
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText('Agent Details',
                                    ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText(
                                    'Number', ColorResources.black111, 15))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: regularText(
                                    '${report?.username}',
                                    ColorResources.grey6B7,
                                    14,
                                    TextAlign.center)),
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: regularText('${report?.number}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                      ]),
                  SizedBox(height: 30),
                  Table(
                      columnWidths: {
                        0: FlexColumnWidth(5),
                        1: FlexColumnWidth(5),
                        2: FlexColumnWidth(5),
                        3: FlexColumnWidth(5)
                      },
                      border: TableBorder.all(
                          width: 1,
                          color: ColorResources.greyC1C,
                          borderRadius: BorderRadius.circular(3)),
                      children: [
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText(
                                    'Ref No', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText(
                                    'Txn ID', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText(
                                    'Amount', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                child: boldText(
                                    'Status', ColorResources.black111, 15))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: regularText(
                                    '${report?.txnid}',
                                    ColorResources.grey6B7,
                                    14,
                                    TextAlign.center)),
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: regularText(
                                    '${report?.payid}',
                                    ColorResources.grey6B7,
                                    14,
                                    TextAlign.center)),
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: regularText('${report?.amount}',
                                    ColorResources.grey6B7, 14)),
                            Container(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                child: mediumText(
                                    '${report?.status?.toUpperCase()}',
                                    report?.status == 'success'
                                        ? Colors.green
                                        : report?.status == 'failed'
                                            ? ColorResources.orangeFB9
                                            : ColorResources.blue1D3,
                                    14))
                          ],
                        )
                      ]),
                  SizedBox(height: 30),
                  Table(
                      columnWidths: {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(6)
                      },
                      border: TableBorder.all(
                          width: 1,
                          color: ColorResources.greyC1C,
                          borderRadius: BorderRadius.circular(3)),
                      children: [
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText('Date & Time',
                                    ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.createdAt}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'API Ref No', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.refno}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Service', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText(
                                    '${report?.product![0].toUpperCase()}${report?.product?.substring(1).toLowerCase()}',
                                    ColorResources.grey6B7,
                                    14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Amount', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText(
                                    getAmount(), ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Surcharge', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.profit}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText('Total Amount',
                                    ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.amount}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Name', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.option1}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Bank', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.option3}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'IFSC', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.option4}',
                                    ColorResources.grey6B7, 14))
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: EdgeInsets.all(6),
                                child: boldText(
                                    'Product', ColorResources.black111, 15)),
                            Container(
                                padding: EdgeInsets.all(6),
                                child: regularText('${report?.providername}',
                                    ColorResources.grey6B7, 14))
                          ],
                        )
                      ]),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText('Note/Special Instructions',
                            ColorResources.blue1D3, 15),
                        regularText(
                            'Receipt was created on computer and is valid\nwithout signature and seal',
                            ColorResources.blue1D3,
                            14)
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }

  String getAmount() {
    double? amount = double.tryParse('${report?.amount}');
    double? profit = double.tryParse('${report?.profit}');
    if (amount != null && profit != null) {
      double amt = amount - profit;
      return amt.toString();
    }
    return '${report?.amount}';
  }
}
