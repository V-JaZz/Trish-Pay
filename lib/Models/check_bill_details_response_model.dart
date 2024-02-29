// To parse this JSON data, do
//
//     final checkBillDetailsResponseModel = checkBillDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

CheckBillDetailsResponseModel checkBillDetailsResponseModelFromJson(String str) => CheckBillDetailsResponseModel.fromJson(json.decode(str));

String checkBillDetailsResponseModelToJson(CheckBillDetailsResponseModel data) => json.encode(data.toJson());

class CheckBillDetailsResponseModel {
  String? statuscode;
  dynamic actcode;
  String? status;
  BillData? data;
  DateTime? timestamp;
  String? ipayUuid;
  dynamic orderid;
  String? environment;
  dynamic internalCode;

  CheckBillDetailsResponseModel({
    this.statuscode,
    this.actcode,
    this.status,
    this.data,
    this.timestamp,
    this.ipayUuid,
    this.orderid,
    this.environment,
    this.internalCode,
  });

  factory CheckBillDetailsResponseModel.fromJson(Map<String, dynamic> json) => CheckBillDetailsResponseModel(
    statuscode: json["statuscode"],
    actcode: json["actcode"],
    status: json["status"],
    data: json["data"] == null ? null : BillData.fromJson(json["data"]),
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    ipayUuid: json["ipay_uuid"],
    orderid: json["orderid"],
    environment: json["environment"],
    internalCode: json["internalCode"],
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "actcode": actcode,
    "status": status,
    "data": data?.toJson(),
    "timestamp": timestamp?.toIso8601String(),
    "ipay_uuid": ipayUuid,
    "orderid": orderid,
    "environment": environment,
    "internalCode": internalCode,
  };
}

class BillData {
  String? enquiryReferenceId;
  dynamic customerName;
  dynamic billNumber;
  dynamic billPeriod;
  dynamic billDate;
  dynamic billDueDate;
  dynamic billAmount;
  dynamic customerParamsDetails;
  dynamic billDetails;
  dynamic additionalDetails;

  BillData({
    this.enquiryReferenceId,
    this.customerName,
    this.billNumber,
    this.billPeriod,
    this.billDate,
    this.billDueDate,
    this.billAmount,
    this.customerParamsDetails,
    this.billDetails,
    this.additionalDetails,
  });

  factory BillData.fromJson(Map<String, dynamic> json) => BillData(
    enquiryReferenceId: json["enquiryReferenceId"],
    customerName: json["CustomerName"],
    billNumber: json["BillNumber"],
    billPeriod: json["BillPeriod"],
    billDate: json["BillDate"],
    billDueDate: json["BillDueDate"],
    billAmount: json["BillAmount"],
    customerParamsDetails: json["CustomerParamsDetails"],
    billDetails: json["BillDetails"],
    additionalDetails: json["AdditionalDetails"],
  );

  Map<String, dynamic> toJson() => {
    "enquiryReferenceId": enquiryReferenceId,
    "CustomerName": customerName,
    "BillNumber": billNumber,
    "BillPeriod": billPeriod,
    "BillDate": billDate,
    "BillDueDate": billDueDate,
    "BillAmount": billAmount,
    "CustomerParamsDetails": customerParamsDetails,
    "BillDetails": billDetails,
    "AdditionalDetails": additionalDetails,
  };
}
