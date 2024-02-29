// To parse this JSON data, do
//
//     final rechargeReportModel = rechargeReportModelFromJson(jsonString);

import 'dart:convert';

RechargeReportModel rechargeReportModelFromJson(String str) => RechargeReportModel.fromJson(json.decode(str));

String rechargeReportModelToJson(RechargeReportModel data) => json.encode(data.toJson());

class RechargeReportModel {
  String? status;
  int? pages;
  List<Datum>? data;

  RechargeReportModel({
    this.status,
    this.pages,
    this.data,
  });

  factory RechargeReportModel.fromJson(Map<String, dynamic> json) => RechargeReportModel(
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
  String? number;
  String? mobile;
  int? providerId;
  int? apiId;
  int? amount;
  int? charge;
  double? profit;
  int? gst;
  int? tds;
  String? apitxnid;
  String? txnid;
  String? payid;
  String? refno;
  String? description;
  String? remark;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? status;
  int? userId;
  int? creditBy;
  String? rtype;
  String? via;
  int? adminprofit;
  double? balance;
  String? transType;
  String? product;
  String? createdAt;
  String? updatedAt;
  int? wid;
  int? wprofit;
  int? mdid;
  int? mdprofit;
  int? disid;
  int? disprofit;
  String? fundbank;
  int? apicode;
  int? apiname;
  String? username;
  String? sendername;
  String? providername;

  Datum({
    this.id,
    this.number,
    this.mobile,
    this.providerId,
    this.apiId,
    this.amount,
    this.charge,
    this.profit,
    this.gst,
    this.tds,
    this.apitxnid,
    this.txnid,
    this.payid,
    this.refno,
    this.description,
    this.remark,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.status,
    this.userId,
    this.creditBy,
    this.rtype,
    this.via,
    this.adminprofit,
    this.balance,
    this.transType,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.wid,
    this.wprofit,
    this.mdid,
    this.mdprofit,
    this.disid,
    this.disprofit,
    this.fundbank,
    this.apicode,
    this.apiname,
    this.username,
    this.sendername,
    this.providername,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    number: json["number"],
    mobile: json["mobile"],
    providerId: json["provider_id"],
    apiId: json["api_id"],
    amount: json["amount"],
    charge: json["charge"],
    profit: json["profit"]?.toDouble(),
    gst: json["gst"],
    tds: json["tds"],
    apitxnid: json["apitxnid"],
    txnid: json["txnid"],
    payid: json["payid"],
    refno: json["refno"],
    description: json["description"],
    remark: json["remark"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    option4: json["option4"],
    status: json["status"],
    userId: json["user_id"],
    creditBy: json["credit_by"],
    rtype: json["rtype"],
    via: json["via"],
    adminprofit: json["adminprofit"],
    balance: json["balance"]?.toDouble(),
    transType: json["trans_type"],
    product: json["product"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    wid: json["wid"],
    wprofit: json["wprofit"],
    mdid: json["mdid"],
    mdprofit: json["mdprofit"],
    disid: json["disid"],
    disprofit: json["disprofit"],
    fundbank: json["fundbank"],
    apicode: json["apicode"],
    apiname: json["apiname"],
    username: json["username"],
    sendername: json["sendername"],
    providername: json["providername"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "mobile": mobile,
    "provider_id": providerId,
    "api_id": apiId,
    "amount": amount,
    "charge": charge,
    "profit": profit,
    "gst": gst,
    "tds": tds,
    "apitxnid": apitxnid,
    "txnid": txnid,
    "payid": payid,
    "refno": refno,
    "description": description,
    "remark": remark,
    "option1": option1,
    "option2": option2,
    "option3": option3,
    "option4": option4,
    "status": status,
    "user_id": userId,
    "credit_by": creditBy,
    "rtype": rtype,
    "via": via,
    "adminprofit": adminprofit,
    "balance": balance,
    "trans_type": transType,
    "product": product,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "wid": wid,
    "wprofit": wprofit,
    "mdid": mdid,
    "mdprofit": mdprofit,
    "disid": disid,
    "disprofit": disprofit,
    "fundbank": fundbank,
    "apicode": apicode,
    "apiname": apiname,
    "username": username,
    "sendername": sendername,
    "providername": providername,
  };
}
