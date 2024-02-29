import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/DesignController/variable_controller.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/common/common.dart';
import 'package:gpayapp/main.dart';
import '../../Models/get_customers_product_response_model.dart';
import 'do_recharge_response_repo.dart';
import 'get_customer_product_response_repo.dart';

class MobileRechargeScreen extends StatefulWidget {
  MobileRechargeScreen({Key? key}) : super(key: key);

  @override
  State<MobileRechargeScreen> createState() => _MobileRechargeScreenState();
}

class _MobileRechargeScreenState extends State<MobileRechargeScreen> {
  final VariableController variableController = Get.put(VariableController());
  late GetCustomerProductRepo _getCustomerProductRepo;
  GetCustomerProductsResponseModel? gcprm;
  late DoRechargeRepo _doRechargeRepo;
  List<Datum> operators = [];

  String operatorName = 'Select Operator';
  String mobileNo = '';
  String amount = '';

  @override
  void initState() {
    _getCustomerProductRepo = GetCustomerProductRepo(context);
    _doRechargeRepo = DoRechargeRepo(context);
    getCProduct();
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
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 18),
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
        title: boldText("Mobile Recharge", ColorResources.black, 20),
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
                    mobileNo = v;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: mediumText("+91", ColorResources.blue1D3, 18),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(Images.noteIcon),
                      ),
                    ),
                    hintText: "Enter Mobile Number",
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
                Container(
                  height: 55,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: variableController.arrowClick2.value == true
                        ? ColorResources.blue1D3
                        : ColorResources.greyF9F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton<String>(
                      items: operators.map((Datum value) {
                        return DropdownMenuItem(
                          value: value.name,
                          child: mediumText(
                              value.name ?? '', ColorResources.blue1D3, 16),
                        );
                      }).toList(),
                      onChanged: (v) {
                        print(v);
                        setState(() {
                          operatorName = v.toString();
                        });
                      },
                      underline: SizedBox.shrink(),
                      hint:
                          mediumText(operatorName, ColorResources.blue1D3, 16),
                      isExpanded: true,
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
                    hintText: "Enter Amount",
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
                  FocusScope.of(context).unfocus();
                  _showDialog();
                }, "CONTINUE"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() async {
    if (mobileNo.isEmpty) {
      showBannerMessage('Enter mobile number', context);
    } else if (operatorName == 'Select Operator') {
      showBannerMessage('Select operator', context);
    } else if (amount == '0' || amount.isEmpty) {
      showBannerMessage('Enter Amount', context);
    } else {
      await Get.dialog(AlertDialog(
        title: Text(mobileNo ?? ''),
        content: Text('₹ $amount ( $operatorName )' ?? ''),
        actions: [
          TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.grey),
              )),
          TextButton(
              onPressed: () {
                Get.back();
                doRecharge();
              }, // Close the dialog
              child: const Text('Confirm',
                  style: TextStyle(color: ColorResources.blue1D3)))
        ],
      ));
    }

    // Code that runs after the dialog disappears
    debugPrint('Dialog closed!');
  }

  void getCProduct() async {
    gcprm = await _getCustomerProductRepo.getProduct();
    if (gcprm != null) {
      setState(() {
        operators = gcprm!.data ?? [];
      });
    }
  }

  void doRecharge() {
    _doRechargeRepo.doRecharge(
        providerId:
            operators[operators.indexWhere((e) => e.name == operatorName)]
                .id
                .toString(),
        number: mobileNo,
        amount: amount);
  }
}
