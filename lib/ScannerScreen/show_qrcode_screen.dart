import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/home_screen.dart';
import 'package:gpayapp/ScannerScreen/scan_qrcode_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class ShowQrCodeScreen extends StatelessWidget {
  ShowQrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: ColorResources.greyE5E, width: 1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: ColorResources.blue1D3,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                boldText("Show QR Code", ColorResources.blue1D3, 20),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorResources.greyE5E, width: 1),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.more_horiz,
                      color: ColorResources.blue1D3,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            mediumText(name, ColorResources.blue1D3, 18),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorResources.greyF9F,
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                leading: Image.asset(Images.bobImage),
                title: boldText(bank, ColorResources.blue1D3, 16),
                subtitle: mediumText("********${account?.substring(8) ?? ''}", ColorResources.blue1D3, 16),
                trailing: SvgPicture.asset(
                  Images.arrowDownIcon,
                  color: ColorResources.grey9CA,
                ),
              ),
            ),
            Container(
              height: 260,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 0,
                    offset: Offset(2, 15),
                    color: ColorResources.grey6B7.withOpacity(0.06),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(60),
                child: SvgPicture.asset(Images.qrCode2),
              ),
            ),
            // regularText(
            //     "UPI ID: pavansahu78ps@oksbi >", ColorResources.blue1D3, 14),
            InkWell(
              onTap: () {
                Get.to(ScanQrCodeScreen());
              },
              child: Container(
                height: 40,
                width: 188,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResources.greyF1F.withOpacity(0.25),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      color: ColorResources.black111.withOpacity(0.02),
                    ),
                  ],
                  border: Border.all(
                    color: ColorResources.black.withOpacity(0.06),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images.scan),
                    SizedBox(width: 10),
                    mediumText("Open code Scanner", ColorResources.blue1D3, 14),
                  ],
                ),
              ),
            ),
            Image.asset(Images.bhimLogo,height: 100,width: 100),
          ],
        ),
      ),
    );
  }
}
