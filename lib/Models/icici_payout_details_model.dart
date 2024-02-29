// To parse this JSON data, do
//
//     final iciciPayoutDetailModel = iciciPayoutDetailModelFromJson(jsonString);

import 'dart:convert';

IciciPayoutDetailModel iciciPayoutDetailModelFromJson(String str) => IciciPayoutDetailModel.fromJson(json.decode(str));

String iciciPayoutDetailModelToJson(IciciPayoutDetailModel data) => json.encode(data.toJson());

class IciciPayoutDetailModel {
  String? statuscode;
  String? status;
  List<Bank>? banks;
  List<BankList>? bankList;
  List<dynamic>? bankListOption;
  List<dynamic>? reports;

  IciciPayoutDetailModel({
    this.statuscode,
    this.status,
    this.banks,
    this.bankList,
    this.bankListOption,
    this.reports,
  });

  factory IciciPayoutDetailModel.fromJson(Map<String, dynamic> json) => IciciPayoutDetailModel(
    statuscode: json["statuscode"],
    status: json["status"],
    banks: json["banks"] == null ? [] : List<Bank>.from(json["banks"]!.map((x) => Bank.fromJson(x))),
    bankList: json["bank_list"] == null ? [] : List<BankList>.from(json["bank_list"]!.map((x) => BankList.fromJson(x))),
    bankListOption: json["bank_list_option"] == null ? [] : List<dynamic>.from(json["bank_list_option"]!.map((x) => x)),
    reports: json["reports"] == null ? [] : List<dynamic>.from(json["reports"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "banks": banks == null ? [] : List<dynamic>.from(banks!.map((x) => x.toJson())),
    "bank_list": bankList == null ? [] : List<dynamic>.from(bankList!.map((x) => x.toJson())),
    "bank_list_option": bankListOption == null ? [] : List<dynamic>.from(bankListOption!.map((x) => x)),
    "reports": reports == null ? [] : List<dynamic>.from(reports!.map((x) => x)),
  };
}

class BankList {
  int? id;
  int? userId;
  String? mobile;
  String? bankname;
  String? account;
  String? ifsc;
  String? name;
  String? accountType;
  int? verified;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BankList({
    this.id,
    this.userId,
    this.mobile,
    this.bankname,
    this.account,
    this.ifsc,
    this.name,
    this.accountType,
    this.verified,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
    id: json["id"],
    userId: json["user_id"],
    mobile: json["mobile"],
    bankname: json["bankname"],
    account: json["account"],
    ifsc: json["ifsc"],
    name: json["name"],
    accountType: json["account_type"],
    verified: json["verified"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "mobile": mobile,
    "bankname": bankname,
    "account": account,
    "ifsc": ifsc,
    "name": name,
    "account_type": accountType,
    "verified": verified,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Bank {
  int? id;
  int? bankId;
  String? bankName;
  DateTime? createdAt;

  Bank({
    this.id,
    this.bankId,
    this.bankName,
    this.createdAt,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    bankId: json["bank_id"],
    bankName: json["bank_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_id": bankId,
    "bank_name": bankName,
    "created_at": createdAt?.toIso8601String(),
  };
}
