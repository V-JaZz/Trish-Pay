// To parse this JSON data, do
//
//     final aepsResponseModel = aepsResponseModelFromJson(jsonString);

import 'dart:convert';

List<AepsResponseModel> aepsResponseModelFromJson(String str) =>
    List<AepsResponseModel>.from(
        json.decode(str).map((x) => AepsResponseModel.fromJson(x)));

String aepsResponseModelToJson(List<AepsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AepsResponseModel {
  AepsResponseModel({
    this.status,
    this.message,
    this.balance,
    this.rrn,
    this.transactionType,
    this.title,
    this.aadhar,
    this.id,
    this.amount,
    this.createdAt,
    this.bank,
    this.data,
  });

  String? status;
  String? message;
  String? balance;
  String? rrn;
  String? transactionType;
  String? title;
  String? aadhar;
  String? id;
  dynamic amount;
  String? createdAt;
  String? bank;
  List<MStatement>? data;

  factory AepsResponseModel.fromJson(Map<String, dynamic> json) =>
      AepsResponseModel(
        status: json["status"],
        message: json["message"],
        balance: json["balance"],
        rrn: json["rrn"],
        transactionType: json["transactionType"],
        title: json["title"],
        aadhar: json["aadhar"],
        id: json["id"],
        amount: json["amount"],
        createdAt: json["created_at"],
        bank: json["bank"],
        data: json["data"] == null
            ? []
            : List<MStatement>.from(
                json["data"]!.map((x) => MStatement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "balance": balance,
        "rrn": rrn,
        "transactionType": transactionType,
        "title": title,
        "aadhar": aadhar,
        "id": id,
        "amount": amount,
        "created_at": createdAt,
        "bank": bank,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MStatement {
  MStatement({
    this.date,
    this.txnType,
    this.amount,
    this.narration,
  });

  String? date;
  String? txnType;
  String? amount;
  String? narration;

  factory MStatement.fromJson(Map<String, dynamic> json) => MStatement(
        date: json["date"],
        txnType: json["txnType"],
        amount: json["amount"],
        narration: json["narration"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "txnType": txnType,
        "amount": amount,
        "narration": narration,
      };
}
