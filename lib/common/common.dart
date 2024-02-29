


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';

showBannerMessage(String msg, BuildContext context,[Color? color]) {
  // ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
  //   content: Text(msg),
  //   margin: EdgeInsets.only(bottom: Get.height - 100),
  //   padding: EdgeInsets.all(30),
  //   behavior: SnackBarBehavior.floating,
  // ));
  ScaffoldMessenger.of(context)
      .removeCurrentMaterialBanner();

  ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
          content: Text(msg,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
        backgroundColor: color ?? ColorResources.blue1D3,
        actions: [
          // SizedBox.shrink(),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .removeCurrentMaterialBanner(reason: MaterialBannerClosedReason.swipe);},
            child: Text(
              'Okay',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
            ),
          )
        ],

      ));
      Future.delayed(Duration(seconds: 3),() {
        ScaffoldMessenger.of(context)
            .removeCurrentMaterialBanner();
      });
}

bool checkString(String? value) {
  return value == null || value.isEmpty || value == 'null';
}

String defaultValue(String? value, String def) {
  return value == null || value.isEmpty ? def : value;
}

bool checkEmailValid(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern.toString());
  return !regExp.hasMatch(value);
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  children: const <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5.0,
                        color: Color(0xFF0e2590),
                      ),
                    )
                  ]));
        });
  }
}