// To parse this JSON data, do
//
//     final beneTransferResponseModel = beneTransferResponseModelFromJson(jsonString);

import 'dart:convert';

BeneTransferResponseModel beneTransferResponseModelFromJson(String str) => BeneTransferResponseModel.fromJson(json.decode(str));

String beneTransferResponseModelToJson(BeneTransferResponseModel data) => json.encode(data.toJson());

class BeneTransferResponseModel {
  BeneTransferResponseModel({
    this.statuscode,
    this.amount,
    this.status,
    this.message,
    this.refno,
    this.payid,
    this.txnid,
    this.ifsc,
    this.accno,
    this.name,
    this.bank,
    this.date,
  });

  String? statuscode;
  String? amount;
  String? status;
  String? message;
  String? refno;
  String? payid;
  String? txnid;
  String? ifsc;
  String? accno;
  String? name;
  String? bank;
  String? date;

  factory BeneTransferResponseModel.fromJson(Map<String, dynamic> json) => BeneTransferResponseModel(
    statuscode: json["statuscode"],
    amount: json["amount"],
    status: json["status"],
    message: json["message"],
    refno: json["refno"],
    payid: json["payid"],
    txnid: json["txnid"],
    ifsc: json["ifsc"],
    accno: json["accno"],
    name: json["name"],
    bank: json["bank"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "amount": amount,
    "status": status,
    "message": message,
    "refno": refno,
    "payid": payid,
    "txnid": txnid,
    "ifsc": ifsc,
    "accno": accno,
    "name": name,
    "bank": bank,
    "date": date,
  };
}
