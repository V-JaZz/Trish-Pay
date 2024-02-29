import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/ScannerScreen/show_qrcode_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class ScanQrCodeScreen extends StatefulWidget {
  ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qrViewController;

  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  void dispose() {
    qrViewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteF0F,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.canvas),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                        color: ColorResources.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: ColorResources.white.withOpacity(0.25),
                            width: 1),
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
                  boldText("Scan QR Code", ColorResources.white, 20),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorResources.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: ColorResources.white.withOpacity(0.25),
                          width: 1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.more_horiz,
                        color: ColorResources.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 80),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: QRView(
                    key: qrKey,
                    overlay: QrScannerOverlayShape(
                      cutOutSize: MediaQuery.of(context).size.width * 0.7,
                      borderRadius: 10,
                      borderWidth: 10,
                      borderColor: ColorResources.blue1D3,
                      // overlayColor: ColorResources.black
                    ),
                    onQRViewCreated: (QRViewController controller) {
                      setState(() {
                        qrViewController = controller;
                      });
                    },
                  ),
                ),
              ),
              // SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.to(ShowQrCodeScreen());
                },
                child: Container(
                  height: 40,
                  width: 188,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.white.withOpacity(0.25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 16,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                        color: ColorResources.black111.withOpacity(0.02),
                      ),
                    ],
                    border: Border.all(
                      color: ColorResources.white.withOpacity(0.06),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Images.qrCodeScan),
                      SizedBox(width: 10),
                      mediumText(
                          "Scan QR code ready", ColorResources.white, 14),
                    ],
                  ),
                ),
              ),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.white.withOpacity(0.25),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      color: ColorResources.black111.withOpacity(0.02),
                    ),
                  ],
                  border: Border.all(
                    color: ColorResources.white.withOpacity(0.06),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(Images.star),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
