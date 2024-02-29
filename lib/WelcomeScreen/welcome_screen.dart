import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Networking/api_base_helper.dart';
import 'package:gpayapp/SelectLanguageScreen/select_language_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/font_family.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/VerificationScreen/verification_screen.dart';
import 'package:gpayapp/main.dart';
import 'package:device_info/device_info.dart';

import '../constants/constants.dart';
import 'login_repo.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? countryCode = '+91';
  String? phoneNo;
  String? password;
  String? deviceId;
  String? lat = '43.242142';
  String? long = '43.242140';
  late LoginRepository _loginRepository;

  @override
  void initState() {
    _loginRepository = LoginRepository(context);
    deviceInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 24, right: 24),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorResources.greyF9F,
                        border: Border.all(color: ColorResources.grey9CA),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.language,
                                size: 18, color: ColorResources.blue1D3),
                            regularText(
                                "English (US)", ColorResources.grey9CA, 14),
                            SvgPicture.asset(Images.arrowDownIcon),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(child: SvgPicture.asset(Images.welcomeImage)),
                SizedBox(height: 40),
                boldText("Welcome to $appName", ColorResources.blue1D3, 24),
                SizedBox(height: 7),
                lightText(
                    "Enter your phone number and password", ColorResources.grey6B7, 16),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorResources.greyF9F,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        // onTap: () {
                        //   showCountryPicker(
                        //     context: context,
                        //     //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                        //     exclude: <String>['KN', 'MF'],
                        //     favorite: <String>['SE'],
                        //     //Optional. Shows phone code before the country name.
                        //     showPhoneCode: true,
                        //     onSelect: (Country country) {
                        //       print('Select country: ${country.displayName}');
                        //       countryCode = country.countryCode;
                        //     },
                        //     // Optional. Sets the theme for the country list picker.
                        //     countryListTheme: CountryListThemeData(
                        //       // Optional. Sets the border radius for the bottomsheet.
                        //       borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(40.0),
                        //         topRight: Radius.circular(40.0),
                        //       ),
                        //       // Optional. Styles the search field.
                        //       inputDecoration: InputDecoration(
                        //         hintText: 'Search',
                        //         prefixIcon:  Padding(
                        //           padding:  EdgeInsets.all(15),
                        //           child: SvgPicture.asset(Images.search),
                        //         ),
                        //         border: OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //             color:  Color(0xFF8C98A8).withOpacity(0.2),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: ColorResources.greyF9F,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                mediumText("+91 ", ColorResources.blue1D3, 18),
                                SizedBox(width: 8),
                                SvgPicture.asset(
                                  Images.arrowDownIcon,
                                ),
                                SizedBox(width: 4),
                                SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: ColorResources.grey6B7,
                                    thickness: 1,
                                    indent: 5,
                                    endIndent: 2,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: ColorResources.blue1D3,
                          style: TextStyle(
                            color: ColorResources.black,
                            fontSize: 18,
                            fontFamily: TextFontFamily.ROBOTO_REGULAR,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(
                              color: ColorResources.grey9CA,
                              fontSize: 18,
                              fontFamily: TextFontFamily.ROBOTO_REGULAR,
                            ),
                            filled: true,
                            fillColor: ColorResources.greyF9F,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onChanged: (value) {
                            phoneNo = value.trim();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorResources.greyF9F,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 18),
                      Expanded(
                        child: TextFormField(
                          cursorColor: ColorResources.blue1D3,
                          obscureText: true,
                          style: TextStyle(
                            color: ColorResources.black,
                            fontSize: 18,
                            fontFamily: TextFontFamily.ROBOTO_REGULAR,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              color: ColorResources.grey9CA,
                              fontSize: 18,
                              fontFamily: TextFontFamily.ROBOTO_REGULAR,
                            ),
                            filled: true,
                            fillColor: ColorResources.greyF9F,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.greyF9F, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onChanged: (value) {
                            password = value.trim();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                containerButton(() {
                  validateCredentials();
                }, "Login"),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateCredentials(){
    print("countryCode : $countryCode");
    print("phoneNo : $phoneNo");
    print("password : $password");
    print("deviceId : $deviceId");
    print("latitude : $lat");
    print("longitude : $long");

    _loginRepository.login(cCode: countryCode, pNo: phoneNo, pass: password, deviceToken: deviceId, lat: lat, long: long);

  }

  deviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.androidId;
  }
}
