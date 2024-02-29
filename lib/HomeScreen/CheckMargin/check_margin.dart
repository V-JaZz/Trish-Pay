import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gpayapp/Utils/colors.dart';
import 'package:gpayapp/Utils/common_widget.dart';
import 'package:gpayapp/Utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../Models/get_margin_model.dart';
import '../../Utils/font_family.dart';
import '../../constants/constants.dart';

class CheckMargin extends StatefulWidget {
  @override
  State<CheckMargin> createState() => _CheckMargin();
}

class _CheckMargin extends State<CheckMargin> {
  TextEditingController amount = TextEditingController();
  GetMarginModel? model;
  List<Commission>? commissionList;
  Future<List<Commission>?>? fCommission;
  String _searchQuery = '';
  String _filterQuery = 'All';
  bool filter = false;

  @override
  void initState() {
    fCommission = loadCommissionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Commission> filteredCommissionList = _filterQuery == 'All'
        ? (commissionList ?? [])
        : _filterList(_filterQuery);
    List<Commission> filteredSearchCommissionList = _searchQuery.isEmpty
        ? filteredCommissionList
        : _searchList(_searchQuery, filteredCommissionList);
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
        title: boldText("Margin List", ColorResources.black, 20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                cursorColor: ColorResources.black,
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 16,
                  fontFamily: TextFontFamily.ROBOTO_REGULAR,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: SvgPicture.asset(Images.search),
                  ),
                  suffixIcon: Container(
                    width: 90,
                    alignment: Alignment.centerRight,
                    child: DropdownButton<String>(
                      items: <String>[
                        'All',
                        'Mobile',
                        'DTH',
                        'DMT',
                        'AEPS',
                        'AadharPay',
                        'PG',
                        'Electricity',
                        'Payout',
                        'Pancard',
                        'Loan',
                      ].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: mediumText(
                              value ?? '', ColorResources.blue1D3, 16),
                        );
                      }).toList(),
                      onChanged: (v) {
                        print(v);
                        setState(() {
                          _filterQuery = v.toString();
                          if (_filterQuery == 'All') {
                            filter = false;
                          } else {
                            filter = true;
                          }
                        });
                      },
                      underline: SizedBox.shrink(),
                      isExpanded: true,
                      icon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.filter_list_rounded,
                            color:
                                filter ? ColorResources.green00B : Colors.grey,
                          )),
                      iconSize: 30,
                      alignment: AlignmentDirectional.center,
                    ),
                  ),
                  hintText: 'Search',
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorResources.greyF9F, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorResources.greyF9F, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _updateQuery,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: FutureBuilder(
              future: fCommission,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.only(top: 15),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: List.generate(
                          filteredSearchCommissionList.length ?? 0, (i) {
                        return ListTile(
                            contentPadding:
                                EdgeInsets.only(bottom: 15, top: 15),
                            onTap: () {},
                            leading: Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: CircleAvatar(
                                backgroundColor: ColorResources.blue1D3,
                                child: Icon(
                                  Icons.business_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: boldText(
                                filteredSearchCommissionList[i].name,
                                ColorResources.blue1D3,
                                18),
                            subtitle: regularText(
                                filteredSearchCommissionList[i]
                                    .service
                                    ?.toUpperCase(),
                                ColorResources.grey6B7,
                                15),
                            trailing:
                                // index == 3 || index == 8 ?
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                boldText(
                                    '${filteredSearchCommissionList[i].retailer}${filteredSearchCommissionList[i].type == 'percent' ? '%' : ''}',
                                    ColorResources.green00B,
                                    21),
                              ],
                            )
                            // : boldText(
                            // historyList[index]["text3"],
                            // index == 0 || index == 5
                            //     ? ColorResources.green00B
                            //     : index == 3 || index == 8
                            //     ? ColorResources.black.withOpacity(0.35)
                            //     : ColorResources.redF53,
                            // 21),
                            );
                      }),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorResources.blue1D3,
                    ),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<List<Commission>?> loadCommissionList() async {
    // Future.delayed(Duration(microseconds: 500),() {
    //   Dialogs.showLoadingDialog(context, GlobalKey<State>());
    // });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tok = prefs.getString(tokenKey);
    String? dId = prefs.getString(deviceIdKey);
    int? uId = prefs.getInt(uIdKey);

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://trishpay.com/api/Android/getMargin'));
    request.bodyFields = {
      'Token': tok ?? '',
      'UserId': uId.toString(),
      'DeviceId': dId ?? '',
    };
    request.headers.addAll(headers);

    print(request.bodyFields.toString());

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    // Get.back();
    if (response.statusCode == 200) {
      print('success');
      var parsed = jsonDecode(response.body);
      print(parsed.toString());
      GetMarginModel userModel = GetMarginModel.fromJson(parsed);
      setState(() {
        model = userModel;
        commissionList = model?.commission;
      });
      return commissionList;
    } else {
      print(streamedResponse.reasonPhrase);
      return null;
    }
  }

  void _updateQuery(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();
    });
  }

  List<Commission> _searchList(String query, List<Commission> list) {
    List<Commission> filteredList =
        list.where((i) => i.name!.toLowerCase().contains(query)).toList();
    return filteredList;
  }

  List<Commission> _filterList(String query) {
    if (commissionList != null) {
      List<Commission> filteredList = commissionList!
          .where((i) => i.service!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return filteredList;
    } else {
      return [];
    }
  }
}
