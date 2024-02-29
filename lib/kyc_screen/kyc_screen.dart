import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/common/common.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gpayapp/kyc_screen/update_customer_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class KycScreen extends StatefulWidget {
  final String? kycStatus;
  final String? remark;

  KycScreen({required this.kycStatus, required this.remark});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController outletName = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController panCardNo = TextEditingController();
  TextEditingController aadhaarCardNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  String? aadhaarFront;
  String? aadhaarBack;
  String? panCard;
  String? cheque;
  late UpdateCustomerRepo _updateCustomerRepo;

  @override
  void initState() {
    _updateCustomerRepo = UpdateCustomerRepo(context);
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
        titleSpacing: 27,
        elevation: 0,
        title: boldText("KYC details", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('Status :  ${widget.kycStatus}',
                style: TextStyle(color: ColorResources.blue1D3, fontSize: 15)),
            SizedBox(height: 9),
            Text('Remarks :  ${widget.remark}',
                style: TextStyle(color: ColorResources.blue1D3)),
            SizedBox(height: 15),
            widget.kycStatus == 'submitted'
                ? SizedBox.shrink()
                : Column(
              children: [
                textField2("Name", name, TextInputType.name, false),
                SizedBox(height: 15),
                textField2(
                    "Outlet name", outletName, TextInputType.name, false),
                SizedBox(height: 15),
                textField2(
                    "Pincode", pinCode, TextInputType.number, true),
                SizedBox(height: 15),
                textField2("Pancard number", panCardNo,
                    TextInputType.text, false),
                SizedBox(height: 15),
                textField2("Aadhaar card number", aadhaarCardNo,
                    TextInputType.number, true),
                SizedBox(height: 15),
                textField2("Address", address,
                    TextInputType.streetAddress, false),
                SizedBox(height: 15),
                textField2("State", state, TextInputType.name, false),
                SizedBox(height: 15),
                textField2("City", city, TextInputType.name, false),
                SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    aadhaarFront = await pickImageFile(context);
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
                    child: Text(
                      'Select aadhaar card front image >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                aadhaarFront.toString() != 'null'
                    ? Text(aadhaarFront.toString(),
                    style: TextStyle(
                        color:
                        ColorResources.blue1D3.withOpacity(0.7),
                        fontSize: 12))
                    : SizedBox.shrink(),
                SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    aadhaarBack = await pickImageFile(context);
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
                    child: Text(
                      'Select aadhaar card back image >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                aadhaarBack.toString() != 'null'
                    ? Text(aadhaarBack.toString(),
                    style: TextStyle(
                        color:
                        ColorResources.blue1D3.withOpacity(0.7),
                        fontSize: 12))
                    : SizedBox.shrink(),
                SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    panCard = await pickImageFile(context);
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
                    child: Text(
                      'Select pan card image >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                panCard.toString() != 'null'
                    ? Text(panCard.toString(),
                    style: TextStyle(
                        color:
                        ColorResources.blue1D3.withOpacity(0.7),
                        fontSize: 12))
                    : SizedBox.shrink(),
                SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    cheque = await pickImageFile(context);
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
                    child: Text(
                      'Select Cheque image >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                cheque.toString() != 'null'
                    ? Text(cheque.toString(),
                    style: TextStyle(
                        color:
                        ColorResources.blue1D3.withOpacity(0.7),
                        fontSize: 12))
                    : SizedBox.shrink(),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    updateCustomerInfo();
                  },
                  child: Container(
                    height: 52,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.blue1D3,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child:
                      boldText("Continue", ColorResources.white, 16),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                regularText(
                    "This information will be securely saved as per"
                        "Google Pay Terms of Service and Privacy Policy",
                    ColorResources.grey9CA,
                    14,
                    TextAlign.center),
              ],
            )
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

  void updateCustomerInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    _updateCustomerRepo.update(
      name: name.text,
      outletName: outletName.text,
      token: tok,
      aadhaarBack: aadhaarBack,
      aadhaarCardNo: aadhaarCardNo.text,
      aadhaarFront: aadhaarFront,
      address: address.text,
      cheque: cheque,
      city: city.text,
      dId: dId,
      panCard: panCard,
      panCardNo: panCardNo.text,
      pinCode: pinCode.text,
      state: state.text,
      uId: uId.toString(),
    );
  }
}
