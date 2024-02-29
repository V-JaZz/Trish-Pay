import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/common/common.dart';
import '../../Models/get_customers_product_response_model.dart';
import '../../Utils/font_family.dart';
import '../../main.dart';
import '../MobileRechargeScreen/do_recharge_response_repo.dart';

class SelectProviderBillScreen extends StatefulWidget {
  final Datum provider;

  SelectProviderBillScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  State<SelectProviderBillScreen> createState() =>
      _SelectProviderBillScreenState();
}

class _SelectProviderBillScreenState extends State<SelectProviderBillScreen> {
  String customerID = '';
  String amount = '';
  late DoRechargeRepo _doRechargeRepo;

  @override
  void initState() {
    _doRechargeRepo = DoRechargeRepo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: true,
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
        title: boldText(widget.provider.name, ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  cursorColor: ColorResources.black,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.ROBOTO_REGULAR,
                  ),
                  onChanged: (v) {
                    customerID = v;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Customer ID",
                    hintStyle: TextStyle(
                      color: ColorResources.grey9CA,
                      fontSize: 16,
                      fontFamily: TextFontFamily.ROBOTO_REGULAR,
                    ),
                    filled: true,
                    fillColor: ColorResources.greyF9F,
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  cursorColor: ColorResources.black,
                  style: TextStyle(
                    color: ColorResources.black,
                    fontSize: 16,
                    fontFamily: TextFontFamily.ROBOTO_REGULAR,
                  ),
                  onChanged: (v) {
                    amount = v;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: mediumText("₹", ColorResources.blue1D3, 18),
                    ),
                    hintText: "Enter Recharge Amount",
                    hintStyle: TextStyle(
                      color: ColorResources.grey9CA,
                      fontSize: 16,
                      fontFamily: TextFontFamily.ROBOTO_REGULAR,
                    ),
                    filled: true,
                    fillColor: ColorResources.greyF9F,
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorResources.greyF9F, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 45),
                containerButton(() {
                  if (customerID.isEmpty) {
                    showBannerMessage('Enter Mobile Number', context);
                    return;
                  } else if (amount.isEmpty) {
                    showBannerMessage('Enter Recharge Amount', context);
                    return;
                  } else {
                    doRecharge();
                  }
                }, "CONTINUE")
              ],
            ),
          ),
        ),
      ),
    );
  }


  void doRecharge() {
    _doRechargeRepo.doRecharge(providerId: widget.provider.id.toString(),
        number: customerID,
        amount: amount);
  }
}
