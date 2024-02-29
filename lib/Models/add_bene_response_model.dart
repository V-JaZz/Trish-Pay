// To parse this JSON data, do
//
//     final addBeneResponseModel = addBeneResponseModelFromJson(jsonString);

import 'dart:convert';

AddBeneResponseModel addBeneResponseModelFromJson(String str) => AddBeneResponseModel.fromJson(json.decode(str));

String addBeneResponseModelToJson(AddBeneResponseModel data) => json.encode(data.toJson());

class AddBeneResponseModel {
  AddBeneResponseModel({
    this.statuscode,
    this.status,
    this.message,
    this.data,
  });

  String? statuscode;
  String? status;
  String? message;
  Data? data;

  factory AddBeneResponseModel.fromJson(Map<String, dynamic> json) => AddBeneResponseModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
