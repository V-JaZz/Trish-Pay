// To parse this JSON data, do
//
//     final doBbpsResponseModel = doBbpsResponseModelFromJson(jsonString);

import 'dart:convert';

DoBbpsResponseModel doBbpsResponseModelFromJson(String str) => DoBbpsResponseModel.fromJson(json.decode(str));

String doBbpsResponseModelToJson(DoBbpsResponseModel data) => json.encode(data.toJson());

class DoBbpsResponseModel {
  String? statuscode;
  String? status;
  Data? data;
  String? description;

  DoBbpsResponseModel({
    this.statuscode,
    this.status,
    this.data,
    this.description,
  });

  factory DoBbpsResponseModel.fromJson(Map<String, dynamic> json) => DoBbpsResponseModel(
    statuscode: json["statuscode"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "data": data?.toJson(),
    "description": description,
  };
}

class Data {
  String? number;
  String? mobile;
  int? providerId;
  int? apiId;
  int? amount;
  double? profit;
  String? txnid;
  String? option1;
  String? option2;
  String? status;
  int? userId;
  int? creditBy;
  String? rtype;
  String? via;
  double? balance;
  String? transType;
  String? product;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? fundbank;
  int? apicode;
  int? apiname;
  String? username;
  String? sendername;
  String? providername;

  Data({
    this.number,
    this.mobile,
    this.providerId,
    this.apiId,
    this.amount,
    this.profit,
    this.txnid,
    this.option1,
    this.option2,
    this.status,
    this.userId,
    this.creditBy,
    this.rtype,
    this.via,
    this.balance,
    this.transType,
    this.product,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.fundbank,
    this.apicode,
    this.apiname,
    this.username,
    this.sendername,
    this.providername,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    number: json["number"],
    mobile: json["mobile"],
    providerId: json["provider_id"],
    apiId: json["api_id"],
    amount: json["amount"],
    profit: json["profit"]?.toDouble(),
    txnid: json["txnid"],
    option1: json["option1"],
    option2: json["option2"],
    status: json["status"],
    userId: json["user_id"],
    creditBy: json["credit_by"],
    rtype: json["rtype"],
    via: json["via"],
    balance: json["balance"]?.toDouble(),
    transType: json["trans_type"],
    product: json["product"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
    fundbank: json["fundbank"],
    apicode: json["apicode"],
    apiname: json["apiname"],
    username: json["username"],
    sendername: json["sendername"],
    providername: json["providername"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "mobile": mobile,
    "provider_id": providerId,
    "api_id": apiId,
    "amount": amount,
    "profit": profit,
    "txnid": txnid,
    "option1": option1,
    "option2": option2,
    "status": status,
    "user_id": userId,
    "credit_by": creditBy,
    "rtype": rtype,
    "via": via,
    "balance": balance,
    "trans_type": transType,
    "product": product,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
    "fundbank": fundbank,
    "apicode": apicode,
    "apiname": apiname,
    "username": username,
    "sendername": sendername,
    "providername": providername,
  };
}
