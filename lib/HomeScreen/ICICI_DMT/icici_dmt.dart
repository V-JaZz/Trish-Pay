import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/HomeScreen/ICICI_DMT/do_money_transfer_repo.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';

class ICICIDMT extends StatefulWidget {
  ICICIDMT({Key? key}) : super(key: key);

  @override
  State<ICICIDMT> createState() => _ICICIDMTState();
}

class _ICICIDMTState extends State<ICICIDMT> {
  TextEditingController mobileNo = TextEditingController();
  late DoMoneyTransferRepo doMoneyTransferRepo;

  @override
  void initState() {
    doMoneyTransferRepo = DoMoneyTransferRepo(context);
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
        title: boldText("ICICI DMT", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // regularText(
            //     "Manage your money better by adding another account to make self transfers",
            //     ColorResources.grey6B7,
            //     15),
            SizedBox(height: 15),
            textField2("Mobile number", mobileNo, TextInputType.number, true,
                    (value) {
                  if (mobileNo.text.length == 10) {
                    FocusScope.of(context).unfocus();
                    callApi();
                  }
                }, 10),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: ColorResources.white,
            //     border: Border.all(color: ColorResources.greyE5E, width: 1),
            //   ),
            //   child: ListTile(
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            //     leading: Image.asset(Images.bobImage),
            //     title: boldText(
            //         "Bank of Baroda ****3137", ColorResources.blue1D3, 16),
            //     subtitle:
            //         mediumText("Saving Account", ColorResources.blue1D3, 16),
            //     trailing: SvgPicture.asset(
            //       Images.checkIcon,
            //       color: ColorResources.green1DA,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 25),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: ColorResources.greyF9F,
            //   ),
            //   child: ListTile(
            //     leading: SvgPicture.asset(Images.addNewBankImage),
            //     title: boldText("Add new bank", ColorResources.blue1D3, 16),
            //     trailing: Icon(Icons.arrow_forward_ios,
            //         size: 14, color: ColorResources.blue1D3),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void callApi() {
    doMoneyTransferRepo.validate(mNo: mobileNo.text);
  }
}
