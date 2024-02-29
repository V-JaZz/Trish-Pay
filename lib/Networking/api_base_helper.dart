// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_adjacent_string_concatenation, unnecessary_string_interpolations, await_only_futures, unnecessary_brace_in_string_interps, prefer_const_constructors, dead_code

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'app_exception.dart';
import 'package:http_parser/http_parser.dart';

class ApiBaseHelper {
  static const String baseURL = "https://trishpay.com/";
  static const String login = "api/Android/doLogin";
  static const String otpValidate = "api/Android/doLoginValidate";
  static const String customerInfo = "api/Android/getCustomer";
  static const String customerInfoUpdate = "api/Android/doUpdateCustomer";
  static const String getProducts = "api/Android/getProducts";
  static const String doRecharge = "api/Android/doRecharge";
  static const String doAeps = "api/Android/Paysprint/doAeps";
  static const String doMoneyTransfer = "api/Android/ICICI/doMoneyTransfer";
  static const String getFund = "api/Android/getFund";

  Future<dynamic> get(String url, String token) async {
    print('Api Post, url $url');
    print('Api PUT, Token $token');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response = await http.get(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  Future<dynamic> getwith(String url, String token, String restaurantid) async {
    print('Api Post, url $url');
    print('Api PUT, Token $token');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer " + '$token',
          'restaurant': '$restaurantid'
        };
      }

      response = await http.get(Uri.parse(baseURL + url), headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return response;
  }

  Future<dynamic> post(String url, dynamic body, String token) async {
    print('Api Post, url $url');
    print('Api Post, body : $body');
    var response;
    try {
      Map<String, String> header;
      if (token.isEmpty) {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
      } else {
        header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
      }

      response = await http.post(Uri.parse(baseURL + url),
          body: body, headers: header);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return response;
  }

  dynamic returnResponse(BuildContext context, var response) {
    print(response.statusCode.toString());
    print(response.body.toString());
    var responseJson = json.decode(response.body.toString());
    switch (response.statusCode) {
      case 101:
      case 200:
      case 401:
      case 404:
      case 422:
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}'),
        ));
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
