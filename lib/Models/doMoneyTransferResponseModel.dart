// To parse this JSON data, do
//
//     final doMoneyTransferResponseModel = doMoneyTransferResponseModelFromJson(jsonString);

import 'dart:convert';

List<DoMoneyTransferResponseModel> doMoneyTransferResponseModelFromJson(String str) => List<DoMoneyTransferResponseModel>.from(json.decode(str).map((x) => DoMoneyTransferResponseModel.fromJson(x)));

String doMoneyTransferResponseModelToJson(List<DoMoneyTransferResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoMoneyTransferResponseModel {
  DoMoneyTransferResponseModel({
    this.statuscode,
    this.status,
    this.message,
    this.data,
  });

  String? statuscode;
  String? status;
  String? message;
  Data? data;

  factory DoMoneyTransferResponseModel.fromJson(Map<String, dynamic> json) => DoMoneyTransferResponseModel(
    statuscode: json["statuscode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.fname,
    this.lname,
    this.mobile,
    this.bank1Limit,
    this.bank2Limit,
    this.bank3Limit,
    this.benedata,
    this.stateresp,
  });

  String? fname;
  String? lname;
  String? mobile;
  int? bank1Limit;
  int? bank2Limit;
  int? bank3Limit;
  List<Benedatum>? benedata;
  String? stateresp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fname: json["fname"],
    lname: json["lname"],
    mobile: json["mobile"],
    bank1Limit: json["bank1_limit"],
    bank2Limit: json["bank2_limit"],
    bank3Limit: json["bank3_limit"],
    benedata: json["benedata"] == null ? [] : List<Benedatum>.from(json["benedata"]!.map((x) => Benedatum.fromJson(x))),
    stateresp: json["stateresp"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "mobile": mobile,
    "bank1_limit": bank1Limit,
    "bank2_limit": bank2Limit,
    "bank3_limit": bank3Limit,
    "benedata": benedata == null ? [] : List<dynamic>.from(benedata!.map((x) => x.toJson())),
    "stateresp": stateresp,
  };
}

class Benedatum {
  Benedatum({
    this.beneId,
    this.name,
    this.bankid,
    this.bankname,
    this.accno,
    this.ifsc,
    this.status,
  });

  int? beneId;
  String? name;
  String? bankid;
  String? bankname;
  String? accno;
  String? ifsc;
  int? status;

  factory Benedatum.fromJson(Map<String, dynamic> json) => Benedatum(
    beneId: json["bene_id"],
    name: json["name"],
    bankid: json["bankid"],
    bankname: json["bankname"],
    accno: json["accno"],
    ifsc: json["ifsc"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bene_id": beneId,
    "name": name,
    "bankid": bankid,
    "bankname": bankname,
    "accno": accno,
    "ifsc": ifsc,
    "status": status,
  };
}
