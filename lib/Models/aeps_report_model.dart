// To parse this JSON data, do
//
//     final aepsReportModel = aepsReportModelFromJson(jsonString);

import 'dart:convert';

AepsReportModel aepsReportModelFromJson(String str) => AepsReportModel.fromJson(json.decode(str));

String aepsReportModelToJson(AepsReportModel data) => json.encode(data.toJson());

class AepsReportModel {
  String? status;
  int? pages;
  List<Datum>? data;

  AepsReportModel({
    this.status,
    this.pages,
    this.data,
  });

  factory AepsReportModel.fromJson(Map<String, dynamic> json) => AepsReportModel(
    status: json["status"],
    pages: json["pages"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pages": pages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? mobile;
  String? aadhar;
  String? txnid;
  int? apiId;
  double? amount;
  double? charge;
  String? bank;
  String? payid;
  String? tds;
  String? refno;
  dynamic mytxnid;
  dynamic terminalid;
  dynamic authcode;
  double? balance;
  String? status;
  String? type;
  String? remark;
  String? rtype;
  String? transtype;
  String? aepstype;
  dynamic txnMedium;
  int? userId;
  int? creditedBy;
  int? providerId;
  dynamic wid;
  int? wprofit;
  dynamic mdid;
  int? mdprofit;
  dynamic disid;
  int? disprofit;
  String? product;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? apicode;
  String? username;

  Datum({
    this.id,
    this.mobile,
    this.aadhar,
    this.txnid,
    this.apiId,
    this.amount,
    this.charge,
    this.bank,
    this.payid,
    this.tds,
    this.refno,
    this.mytxnid,
    this.terminalid,
    this.authcode,
    this.balance,
    this.status,
    this.type,
    this.remark,
    this.rtype,
    this.transtype,
    this.aepstype,
    this.txnMedium,
    this.userId,
    this.creditedBy,
    this.providerId,
    this.wid,
    this.wprofit,
    this.mdid,
    this.mdprofit,
    this.disid,
    this.disprofit,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.apicode,
    this.username,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    mobile: json["mobile"],
    aadhar: json["aadhar"],
    txnid: json["txnid"],
    apiId: json["api_id"],
    amount: json["amount"]?.toDouble(),
    charge: json["charge"]?.toDouble(),
    bank: json["bank"],
    payid: json["payid"],
    tds: json["tds"],
    refno: json["refno"],
    mytxnid: json["mytxnid"],
    terminalid: json["terminalid"],
    authcode: json["authcode"],
    balance: json["balance"]?.toDouble(),
    status: json["status"],
    type: json["type"],
    remark: json["remark"],
    rtype: json["rtype"],
    transtype: json["transtype"],
    aepstype: json["aepstype"],
    txnMedium: json["TxnMedium"],
    userId: json["user_id"],
    creditedBy: json["credited_by"],
    providerId: json["provider_id"],
    wid: json["wid"],
    wprofit: json["wprofit"],
    mdid: json["mdid"],
    mdprofit: json["mdprofit"],
    disid: json["disid"],
    disprofit: json["disprofit"],
    product: json["product"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    apicode: json["apicode"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "aadhar": aadhar,
    "txnid": txnid,
    "api_id": apiId,
    "amount": amount,
    "charge": charge,
    "bank": bank,
    "payid": payid,
    "tds": tds,
    "refno": refno,
    "mytxnid": mytxnid,
    "terminalid": terminalid,
    "authcode": authcode,
    "balance": balance,
    "status": status,
    "type": type,
    "remark": remark,
    "rtype": rtype,
    "transtype": transtype,
    "aepstype": aepstype,
    "TxnMedium": txnMedium,
    "user_id": userId,
    "credited_by": creditedBy,
    "provider_id": providerId,
    "wid": wid,
    "wprofit": wprofit,
    "mdid": mdid,
    "mdprofit": mdprofit,
    "disid": disid,
    "disprofit": disprofit,
    "product": product,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "apicode": apicode,
    "username": username,
  };
}
