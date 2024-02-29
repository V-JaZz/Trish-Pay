import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/send_beneficiary_repo.dart';
import 'package:gpayapp/ProfileScreen/edit_account_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/doMoneyTransferResponseModel.dart';
import '../../Utils/font_family.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import 'add_beneficiary.dart';
import 'do_money_transfer_repo.dart';

class RemitterDetails extends StatefulWidget {
  final DoMoneyTransferResponseModel dmt;

  const RemitterDetails({Key? key, required this.dmt}) : super(key: key);

  @override
  State<RemitterDetails> createState() => _RemitterDetailsState();
}

class _RemitterDetailsState extends State<RemitterDetails> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  late DoMoneyTransferRepo doMoneyTransferRepo;
  late SendBenefeciaryRepo sendBenefeciaryRepo;
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    doMoneyTransferRepo = DoMoneyTransferRepo(context);
    sendBenefeciaryRepo = SendBenefeciaryRepo(context);
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
        title: boldText("Remitter Details", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              boldText("Personal Info", ColorResources.grey6B7, 16),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.greyF3F, width: 1),
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          boldText("Mobile Number", ColorResources.grey6B7, 14),
                          SizedBox(height: 25),
                          boldText("First Name", ColorResources.grey6B7, 14),
                          SizedBox(height: 25),
                          boldText("Last Name", ColorResources.grey6B7, 14),
                          SizedBox(height: 25)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 25),
                          boldText(widget.dmt.data?.mobile,
                              ColorResources.blue1D3, 14),
                          SizedBox(height: 25),
                          boldText(widget.dmt.data?.fname,
                              ColorResources.blue1D3, 14),
                          SizedBox(height: 25),
                          boldText(widget.dmt.data?.lname,
                              ColorResources.blue1D3, 14),
                          SizedBox(height: 25),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              boldText("Beneficiary Info", ColorResources.grey6B7, 16),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Get.to(AddBeneficiary(mNo: widget.dmt.data?.mobile ?? ''));
                },
                child: Container(
                  height: 36,
                  width: Get.width / 2.5,
                  decoration: BoxDecoration(
                    color: ColorResources.blue1D3,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child:
                        boldText("+ Add Beneficiary", ColorResources.white, 14),
                  ),
                ),
              ),
              for (int i = 0; i < (widget.dmt.data?.benedata?.length ?? 0); i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.greyF3F, width: 1),
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(top: 25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 15),
                              boldText("Name", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText(
                                  "Bank Name \n", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText(
                                  "Account Number", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              boldText("IFSC", ColorResources.grey6B7, 14),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  sendBeneficiaryDailog(
                                    widget.dmt.data?.benedata![i].name,
                                    widget.dmt.data?.benedata![i].bankname,
                                    widget.dmt.data?.benedata![i].accno,
                                    widget.dmt.data?.benedata![i].ifsc,
                                    widget.dmt.data?.benedata![i].beneId
                                        .toString(),
                                    widget.dmt.data?.benedata![i].bankid
                                        .toString(),
                                  );
                                },
                                child: Container(
                                  height: 36,
                                  width: Get.width / 4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: ColorResources.blue1D3),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: boldText(
                                        "Send", ColorResources.blue1D3, 14),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 15),
                              boldText(widget.dmt.data?.benedata![i].name,
                                  ColorResources.blue1D3, 14, TextAlign.end),
                              SizedBox(height: 15),
                              Text(
                                widget.dmt.data?.benedata![i].bankname ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: TextFontFamily.ROBOTO_BOLD,
                                    fontSize: 14,
                                    color: ColorResources.blue1D3),
                              ),
                              SizedBox(height: 15),
                              boldText(widget.dmt.data?.benedata![i].accno,
                                  ColorResources.blue1D3, 14),
                              SizedBox(height: 15),
                              boldText(widget.dmt.data?.benedata![i].ifsc,
                                  ColorResources.blue1D3, 14),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: 'Confirm Delete?',
                                    middleText: 'Beneficiary will be deleted',
                                    textConfirm: 'Yes',
                                    confirmTextColor: Colors.white,
                                    buttonColor: ColorResources.blue1D3,
                                    cancelTextColor: ColorResources.blue1D3,
                                    textCancel: 'Cancel',
                                    onConfirm: () {
                                      deleteBene(
                                          widget.dmt.data?.benedata![i].beneId);
                                    },
                                  );
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.delete,
                                        color: ColorResources.blue1D3),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void deleteBene(int? beneId) async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST',
        Uri.parse('https://trishpay.com/api/Android/ICICI/doMoneyTransfer'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString() ?? '',
      'DeviceId': dId ?? '',
      'type': 'benedelete',
      'mobile': widget.dmt.data?.mobile ?? '',
      'bene_id': beneId.toString() ?? ''
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Get.back();
    Get.back();
    doMoneyTransferRepo.validate(mNo: widget.dmt.data?.mobile ?? '');
  }

  void sendBeneficiaryDailog(String? name, String? bankname, String? accno,
      String? ifsc, String? id, String? bId) {
    Get.defaultDialog(
        title: name ?? '',
        textConfirm: 'Send',
        confirmTextColor: Colors.white,
        buttonColor: ColorResources.blue1D3,
        cancelTextColor: ColorResources.blue1D3,
        titlePadding: EdgeInsets.only(top: 20),
        textCancel: 'Cancel',
        onConfirm: () {
          sendBeneficiary(name, bankname, accno, ifsc, id, bId);
        },
        contentPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // mediumText("Name", ColorResources.grey6B7, 14),
              // SizedBox(height: 5),
              // mediumText(name, ColorResources.blue1D3, 14),
              // SizedBox(height: 15),
              mediumText("BankName", ColorResources.grey6B7, 14),
              SizedBox(height: 5),
              mediumText(bankname, ColorResources.blue1D3, 14),
              SizedBox(height: 15),
              mediumText("Account Number", ColorResources.grey6B7, 14),
              SizedBox(height: 5),
              mediumText(accno, ColorResources.blue1D3, 14),
              SizedBox(height: 15),
              // mediumText("IFSC", ColorResources.grey6B7, 14),
              // SizedBox(height: 5),
              // mediumText(ifsc, ColorResources.blue1D3, 14),
              // SizedBox(height: 15),
              mediumText("Amount", ColorResources.grey6B7, 14),
              SizedBox(height: 5),
              SizedBox(
                child: textField2(
                    "Enter amount", amount, TextInputType.number, true),
              )
            ],
          ),
        ));
  }

  void sendBeneficiary(String? name, String? bankname, String? accno,
      String? ifsc, String? id, String? bId) {
    sendBenefeciaryRepo.send(
        mNo: widget.dmt.data?.mobile ?? '',
        beneid: id ?? '',
        amount: amount.text.toString(),
        benename: name ?? '',
        beneaccount: accno ?? '',
        beneifsc: ifsc ?? '',
        benebank: bId ?? '');
  }
}
