// To parse this JSON data, do
//
//     final mainAepsReportModel = mainAepsReportModelFromJson(jsonString);

import 'dart:convert';

List<MainAepsReportModel> mainAepsReportModelFromJson(String str) =>
    List<MainAepsReportModel>.from(
        json.decode(str).map((x) => MainAepsReportModel.fromJson(x)));

String mainAepsReportModelToJson(List<MainAepsReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainAepsReportModel {
  String? status;
  int? pages;
  List<Report>? data;

  MainAepsReportModel({
    this.status,
    this.pages,
    this.data,
  });

  factory MainAepsReportModel.fromJson(Map<String, dynamic> json) =>
      MainAepsReportModel(
        status: json["status"],
        pages: json["pages"],
        data: json["data"] == null
            ? []
            : List<Report>.from(json["data"]!.map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pages": pages,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Report {
  dynamic id;
  dynamic number;
  dynamic mobile;
  dynamic providerId;
  dynamic apiId;
  dynamic amount;
  dynamic charge;
  dynamic profit;
  dynamic gst;
  dynamic tds;
  dynamic apitxnid;
  dynamic txnid;
  dynamic payid;
  dynamic refno;
  dynamic description;
  dynamic remark;
  dynamic option1;
  dynamic option2;
  dynamic option3;
  dynamic option4;
  dynamic status;
  dynamic userId;
  dynamic creditBy;
  dynamic rtype;
  dynamic via;
  dynamic adminprofit;
  dynamic balance;
  dynamic transType;
  dynamic product;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic wid;
  dynamic wprofit;
  dynamic mdid;
  dynamic mdprofit;
  dynamic disid;
  dynamic disprofit;
  dynamic fundbank;
  dynamic apicode;
  dynamic apiname;
  dynamic username;
  dynamic sendername;
  dynamic providername;
  dynamic aadhar;
  dynamic bank;
  dynamic mytxnid;
  dynamic terminalid;
  dynamic authcode;
  dynamic type;
  dynamic transtype;
  dynamic aepstype;
  dynamic txnMedium;
  dynamic creditedBy;

  Report({
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
    this.aadhar,
    this.bank,
    this.mytxnid,
    this.terminalid,
    this.authcode,
    this.type,
    this.transtype,
    this.aepstype,
    this.txnMedium,
    this.creditedBy,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        number: json["number"],
        mobile: json["mobile"],
        providerId: json["provider_id"],
        apiId: json["api_id"],
        amount: json["amount"]?.toDouble(),
        charge: json["charge"]?.toDouble(),
        profit: json["profit"],
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
        aadhar: json["aadhar"],
        bank: json["bank"],
        mytxnid: json["mytxnid"],
        terminalid: json["terminalid"],
        authcode: json["authcode"],
        type: json["type"],
        transtype: json["transtype"],
        aepstype: json["aepstype"],
        txnMedium: json["TxnMedium"],
        creditedBy: json["credited_by"],
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
        "aadhar": aadhar,
        "bank": bank,
        "mytxnid": mytxnid,
        "terminalid": terminalid,
        "authcode": authcode,
        "type": type,
        "transtype": transtype,
        "aepstype": aepstype,
        "TxnMedium": txnMedium,
        "credited_by": creditedBy,
      };
}
