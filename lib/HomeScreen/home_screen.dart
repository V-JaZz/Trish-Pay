import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gpayapp/HomeScreen/ElectricityBillScreens/all_electrycity_billers_screen.dart';
import 'package:gpayapp/HomeScreen/ICICI_Payout/icici_payout.dart';
import 'package:gpayapp/HomeScreen/Reports/aeps_reports.dart';
import 'package:gpayapp/HomeScreen/Reports/bill_pay_reports.dart';
import 'package:gpayapp/HomeScreen/ViewMoreScreens/business_bills_screen.dart';
import 'package:gpayapp/HomeScreen/MobileRechargeScreen/mobile_recharge_screen.dart';
import 'package:gpayapp/HomeScreen/ChatScreens/chat_screen2.dart';
import 'package:gpayapp/HomeScreen/ViewMoreScreens/payment_categories_screen.dart';
import 'package:gpayapp/HomeScreen/ViewMoreScreens/people_screen.dart';
import 'package:gpayapp/HomeScreen/SelectProviderBillScreens/select_provider_screen.dart';
import 'package:gpayapp/NotificationsScreen/notification_screen.dart';
import 'package:gpayapp/Search_Screen/search_screen.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:gpayapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/customer_info_response_model.dart';
import '../RoutScreen/customer_info_repo.dart';
import '../common/common.dart';
import '../constants/constants.dart';
import 'CheckMargin/check_margin.dart';
import 'ICICI_AEPS/icici_aeps.dart';
import 'ICICI_DMT/icici_dmt.dart';
import 'LoadWallet/load_wallet.dart';
import 'Reports/dmt_reports.dart';
import 'Reports/payout_reports.dart';
import 'Reports/recharge_reports.dart';

String s1 = '0';
String s2 = '0';
String? name;
String? email;
String? mobile;
String? account;
String? bank;
String? ifsc;
CustomerInfoResponseModel? cirm;
List<Sliders> sliderList = [];
int initLoad = 0;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map> paymentCategoryList = [
    {
      "image": Images.mobileRechargeImage,
      "text": "Mobile\nrecharge",
      "onTap": () {
        Get.to(MobileRechargeScreen());
      },
    },
    {
      "image": Images.electricityImage,
      "text": "Electricity",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Electricity'));
      },
    },
    {
      "image": Images.monitorImage,
      "text": "DTH",
      "onTap": () {
        Get.to(RechargeDishTv());
      },
    },
    {
      "image": Images.insuranceImage,
      "text": "Insurance",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Insurance'));
      },
    },
    {
      "image": Images.landLineImage,
      "text": "Broadband",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Broadband'));
      },
    },
    {
      "image": Images.cylinderImage,
      "text": "Gas \nCylinder",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Gas Cylinder'));
      },
    },
    {
      "image": Images.emiImage,
      "text": "Loan \nPayment",
      "onTap": () {
        Get.to(AllElectriCityBillersScreen(providerType: 'Loan'));
      },
    },
    {
      "image": Images.addImage,
      "text": "+ More",
      "onTap": () {
        Get.to(PaymentCategoriesScreen());
      },
    },
  ];
  final List<Map> peopleList = [
    {
      "image": Images.jenny,
      "text": "Jenny",
      "onTap": () {
        Get.to(ChatScreen2());
      },
    },
    {
      "image": Images.bessie,
      "text": "Bessie",
      "onTap": () {
        Get.to(ChatScreen2());
      },
    },
    {
      "image": Images.jacob,
      "text": "Jacob",
      "onTap": () {
        Get.to(ChatScreen2());
      },
    },
    {
      "image": Images.darlene,
      "text": "Darlene",
      "onTap": () {
        Get.to(ChatScreen2());
      },
    },
    {
      "image": Images.addPng,
      "text": "+ More",
      "onTap": () {
        Get.to(PeopleScreen());
      },
    },
  ];
  final List<Map> businessAndBillsList = [
    {
      "image": Images.redBus,
      "text": "redBus",
      "onTap": () {},
    },
    {
      "image": Images.makeMyTrip,
      "text": "MakeMyTrip",
      "onTap": () {},
    },
    {
      "image": Images.tataSky,
      "text": "Tata Sky",
      "onTap": () {},
    },
    {
      "image": Images.yatra,
      "text": "Yatra",
      "onTap": () {},
    },
    {
      "image": Images.barista,
      "text": "Barista",
      "onTap": () {},
    },
    {
      "image": Images.macDonalds,
      "text": "Mcdonald’S",
      "onTap": () {},
    },
    {
      "image": Images.zomato,
      "text": "Zomato",
      "onTap": () {},
    },
    {
      "image": Images.addPng,
      "text": "+ More",
      "onTap": () {
        Get.to(BusinessAndBillsScreen());
      },
    },
  ];
  final List<Map> promotionList = [
    {
      "image": Images.rewardImage,
      "text": "Recharge",
      "onTap": () {
        Get.to(RechargeReport());
      },
    },
    {
      "image": Images.offersImage,
      "text": "Bill Pay",
      "onTap": () {
        Get.to(BillPayReport());
      },
    },
    {
      "image": Images.referralsImage,
      "text": "DMT",
      "onTap": () {
        Get.to(DMTReport());
      },
    },
    {
      "image": Images.voucherImage,
      "text": "AEPS",
      "onTap": () {
        Get.to(AEPSReport());
      },
    },
    {
      "image": Images.voucherImage,
      "text": "Payout",
      "onTap": () {
        Get.to(PayoutReport());
      },
    },
  ];
  bool refreshed = true;
  Timer? _timer;

  late CustomerInfoRepo _customerInfoRepo;

  @override
  void initState() {
    _customerInfoRepo = CustomerInfoRepo(context);
    callApiPeriodically();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(27),
                bottomLeft: Radius.circular(27),
              ),
              color: ColorResources.blue1D3,
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 54, bottom: 20, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(SearchScreen());
                      },
                      child: SvgPicture.asset(Images.search,
                          color: ColorResources.white)),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(ScanQrCodeScreen());
                  //   },
                  //   child: SvgPicture.asset(Images.scanIcon),
                  // ),
                  SizedBox(
                    height: 32,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MAIN : ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              'AEPS : ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹ $s1',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              '₹ $s2',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: refreshed,
                    replacement: Container(
                      padding: EdgeInsets.all(6),
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          refreshed = false;
                        });
                        checkCustomerDetails();
                      },
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 114, left: 20, right: 20),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sliderList.isEmpty
                        ? SizedBox(height: 180, width: Get.width)
                        : Container(
                            height: 180,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: ImageSlideshow(
                              /// Width of the [ImageSlideshow].
                              width: Get.width,

                              /// Height of the [ImageSlideshow].
                              height: 180,

                              /// The page to show when first creating the [ImageSlideshow].
                              initialPage: 0,

                              /// The color to paint the indicator.
                              indicatorColor: ColorResources.blue1D3,

                              /// The color to paint behind th indicator.
                              indicatorBackgroundColor: Colors.grey,

                              /// Auto scroll interval.
                              /// Do not auto scroll with null or 0.
                              autoPlayInterval: 3000,

                              /// Loops back to first slide.
                              isLoop: true,

                              /// The widgets to display in the [ImageSlideshow].
                              /// Add the sample image file into the images folder
                              children: sliderList.isNotEmpty
                                  ? List.generate(sliderList.length, (index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          'https://trishpay.com/public/slider/${sliderList[index].image}',
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    })
                                  : [],
                            ),
                          ),
                    SizedBox(height: 20),
                    boldText("Quick Links", ColorResources.blue1D3, 20),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonColumn(
                          Images.bankTransfer,
                          "Fund \nRequest",
                          () {
                            Get.to(LoadWallet());
                          },
                        ),
                        commonColumn(
                          Images.aeps,
                          "Aeps\n",
                          () {
                            Get.to(ICICIAEPS());
                          },
                        ),
                        commonColumn(
                          Images.selfTransfer,
                          "DMT\n",
                          () {
                            Get.to(ICICIDMT());
                          },
                        ),
                        commonColumn(
                          Images.bankTransfer,
                          "Payout\n",
                          () {
                            Get.to(ICICIPayout());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    boldText("Payment Categories", ColorResources.blue1D3, 20),
                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) => GridView.count(
                        padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 3 / 2.6,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          paymentCategoryList.length,
                          (index) => Column(
                            children: [
                              InkWell(
                                onTap: paymentCategoryList[index]["onTap"],
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.greyF1F,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                        color: ColorResources.black
                                            .withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                        paymentCategoryList[index]["image"]),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              regularText(paymentCategoryList[index]["text"],
                                  ColorResources.grey6B7, 14, TextAlign.center),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    boldText(
                        "Businesses and Bills", ColorResources.blue1D3, 20),
                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) => GridView.count(
                        padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 3 / 2.6,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          businessAndBillsList.length,
                          (index) => Column(
                            children: [
                              InkWell(
                                onTap: businessAndBillsList[index]["onTap"],
                                child: Image.asset(
                                  businessAndBillsList[index]["image"],
                                ),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                  child: regularText(
                                      businessAndBillsList[index]["text"],
                                      ColorResources.grey6B7,
                                      14,
                                      TextAlign.center)),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    boldText("Reports", ColorResources.blue1D3, 20),
                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) => GridView.count(
                        padding: EdgeInsets.only(
                            top: 5, left: 2, right: 2, bottom: 2),
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 3 / 0.6,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          promotionList.length,
                          (index) => InkWell(
                            onTap: promotionList[index]["onTap"],
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorResources.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                    color:
                                        ColorResources.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                        promotionList[index]["image"]),
                                    mediumText(promotionList[index]["text"],
                                        ColorResources.blue1D3, 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    boldText("Retailer", ColorResources.blue1D3, 20),
                    SizedBox(height: 20),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Get.to(CheckMargin());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorResources.white,
                            border: Border.all(
                                color: ColorResources.greyE5E, width: 1),
                          ),
                          child: ListTile(
                            leading: Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: CircleAvatar(
                                backgroundColor: ColorResources.blue1D3,
                                child: Icon(
                                  Icons.insights_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: boldText(
                                'Check Margin', ColorResources.blue1D3, 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 110),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkCustomerDetails() {
    Future.delayed(
      Duration(seconds: 1),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? tok = prefs.getString(tokenKey);
        String? dId = prefs.getString(deviceIdKey);
        int? uId = prefs.getInt(uIdKey);
        cirm = await _customerInfoRepo.getUserInfo(
            androidId: dId, token: tok, userId: uId.toString());
        if (cirm != null) {
          if (!refreshed) {
            setState(() {
              s1 = cirm?.data?.mainwallet.toString() ?? '';
              s2 = cirm?.data?.aepsbalance.toString() ?? '';
              refreshed = true;
            });
          } else {
            if (s1 != cirm?.data?.mainwallet.toString() ||
                s2 != cirm?.data?.aepsbalance.toString()) {
              setState(() {
                s1 = cirm?.data?.mainwallet.toString() ?? '';
                s2 = cirm?.data?.aepsbalance.toString() ?? '';
                name = cirm?.data?.name ?? '';
                email = cirm?.data?.email ?? '';
                sliderList = cirm?.slider ?? [];
                mobile = cirm?.data?.mobile ?? '';
                account = cirm?.data?.account ?? '';
                bank = cirm?.data?.bank ?? '';
                ifsc = cirm?.data?.ifsc ?? '';
              });
            }
          }
        }
      },
    );
  }

  void callApiPeriodically() {
    if (initLoad == 0) {
      ++initLoad;
      Dialogs.showLoadingDialog(context, GlobalKey<State>());
      checkCustomerDetails();
    }
    _timer = Timer.periodic(Duration(seconds: initLoad != 0 ? 5 : 15), (timer) {
      if (mounted) checkCustomerDetails(); // Make the API call here
      if (initLoad == 1) {
        setState(() {
          ++initLoad;
        });
        Get.back();
      }
    });
  }

// Future<void> getLocationPermission() async {
//   if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//     print('location services enabled');
//
//     var status = await Permission.location.status;
//     if (status.isGranted) {
//       print('location permission granted');
//     } else if (status.isDenied) {
//       print('location permission denied');
//       await [ Permission.location].request();
//
//       var status = await Permission.location.status;
//       if (status.isGranted) {
//         print('location permission granted');
//       }
//     } else if (status.isPermanentlyDenied || status.isRestricted) {
//       print('location permission permanently denied');
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text("Location denied :("),
//               titleTextStyle:
//               const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black, fontSize: 20),
//               content: const Text(
//                   "Enable location permission from system app settings."),
//               actionsOverflowButtonSpacing: 20,
//               actions: [
//                 ElevatedButton(onPressed: () {
//                   Navigator.pop(context);
//                 },
//                     style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(Colors.white),
//                     ),
//                     child: const Text("Cancel",
//                       style: TextStyle(color: ColorResources.grey9CA),)),
//                 ElevatedButton(onPressed: () {
//                   openAppSettings();
//                 },
//                     style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                           ColorResources.blue1D3),
//                     ), child: const Text("Open Settings")),
//               ],
//             );
//           });
//     }
//   }
//   else {
//     print('location services disabled');
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Enable location"),
//             titleTextStyle:
//             const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black, fontSize: 20),
//             content: const Text("Please enable location services!"),
//             actionsOverflowButtonSpacing: 20,
//             actions: [
//               ElevatedButton(onPressed: () {
//                 Navigator.pop(context);
//               },
//                   style: const ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(Colors.white),
//                   ),
//                   child: const Text(
//                     "Close", style: TextStyle(color: Colors.grey),)),
//               ElevatedButton(onPressed: () {
//                 Navigator.pop(context);
//                 getLocationPermission();
//               },
//                   style: const ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                         ColorResources.blue1D3),
//                   ), child: const Text("Retry")),
//             ],
//           );
//         });
//   }
// }

// Future<Position?>? getLocation() async {
//
//
//   final geoLocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
//   late Position currentPosition;
//
//   if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//     print('location services enabled');
//
//     var status = await Permission.location.status;
//     if (status.isGranted) {
//       print('location permission granted');
//
//
//       await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//           .then((Position position) async {
//
//         currentPosition = position;
//         currentPosition.latitude;
//         currentPosition.longitude;
//         return currentPosition;
//       }).catchError((e) {
//         print(e);
//       });
//     } else if (status.isDenied) {
//       print('location permission denied');
//
//     } else if (status.isPermanentlyDenied || status.isRestricted) {
//       print('location permission permanently denied');
//     }
//   }
//   else{
//     print('location services disabled');
//   }
//   return null;
// }
}
