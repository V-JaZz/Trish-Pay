// To parse this JSON data, do
//
//     final getBbpsBillerInfoModel = getBbpsBillerInfoModelFromJson(jsonString);

import 'dart:convert';

GetBbpsBillerInfoModel getBbpsBillerInfoModelFromJson(String str) => GetBbpsBillerInfoModel.fromJson(json.decode(str));

String getBbpsBillerInfoModelToJson(GetBbpsBillerInfoModel data) => json.encode(data.toJson());

class GetBbpsBillerInfoModel {
  String? statuscode;
  dynamic actcode;
  String? status;
  BillersData? data;
  DateTime? timestamp;
  String? ipayUuid;
  dynamic orderid;
  String? environment;
  dynamic internalCode;

  GetBbpsBillerInfoModel({
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

  factory GetBbpsBillerInfoModel.fromJson(Map<String, dynamic> json) => GetBbpsBillerInfoModel(
    statuscode: json["statuscode"],
    actcode: json["actcode"],
    status: json["status"],
    data: json["data"] == null ? null : BillersData.fromJson(json["data"]),
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

class BillersData {
  String? billerId;
  String? mode;
  String? acceptsAdhoc;
  String? paymentAmountExactness;
  String? fetchRequirement;
  String? supportValidation;
  BillerInfo? billerInfo;
  Category? category;
  Address? registeredAddress;
  Address? communicationAddress;
  Coverage? coverage;
  List<InitChannel>? initChannels;
  List<PaymentMode>? paymentModes;
  List<Parameter>? parameters;
  int? timeout;

  BillersData({
    this.billerId,
    this.mode,
    this.acceptsAdhoc,
    this.paymentAmountExactness,
    this.fetchRequirement,
    this.supportValidation,
    this.billerInfo,
    this.category,
    this.registeredAddress,
    this.communicationAddress,
    this.coverage,
    this.initChannels,
    this.paymentModes,
    this.parameters,
    this.timeout,
  });

  factory BillersData.fromJson(Map<String, dynamic> json) => BillersData(
    billerId: json["billerId"],
    mode: json["mode"],
    acceptsAdhoc: json["acceptsAdhoc"],
    paymentAmountExactness: json["paymentAmountExactness"],
    fetchRequirement: json["fetchRequirement"],
    supportValidation: json["supportValidation"],
    billerInfo: json["billerInfo"] == null ? null : BillerInfo.fromJson(json["billerInfo"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    registeredAddress: json["registeredAddress"] == null ? null : Address.fromJson(json["registeredAddress"]),
    communicationAddress: json["communicationAddress"] == null ? null : Address.fromJson(json["communicationAddress"]),
    coverage: json["coverage"] == null ? null : Coverage.fromJson(json["coverage"]),
    initChannels: json["initChannels"] == null ? [] : List<InitChannel>.from(json["initChannels"]!.map((x) => InitChannel.fromJson(x))),
    paymentModes: json["paymentModes"] == null ? [] : List<PaymentMode>.from(json["paymentModes"]!.map((x) => PaymentMode.fromJson(x))),
    parameters: json["parameters"] == null ? [] : List<Parameter>.from(json["parameters"]!.map((x) => Parameter.fromJson(x))),
    timeout: json["timeout"],
  );

  Map<String, dynamic> toJson() => {
    "billerId": billerId,
    "mode": mode,
    "acceptsAdhoc": acceptsAdhoc,
    "paymentAmountExactness": paymentAmountExactness,
    "fetchRequirement": fetchRequirement,
    "supportValidation": supportValidation,
    "billerInfo": billerInfo?.toJson(),
    "category": category?.toJson(),
    "registeredAddress": registeredAddress?.toJson(),
    "communicationAddress": communicationAddress?.toJson(),
    "coverage": coverage?.toJson(),
    "initChannels": initChannels == null ? [] : List<dynamic>.from(initChannels!.map((x) => x.toJson())),
    "paymentModes": paymentModes == null ? [] : List<dynamic>.from(paymentModes!.map((x) => x.toJson())),
    "parameters": parameters == null ? [] : List<dynamic>.from(parameters!.map((x) => x.toJson())),
    "timeout": timeout,
  };
}

class BillerInfo {
  String? type;
  String? name;
  String? description;
  String? ownership;
  int? effectFrom;
  int? effectTo;

  BillerInfo({
    this.type,
    this.name,
    this.description,
    this.ownership,
    this.effectFrom,
    this.effectTo,
  });

  factory BillerInfo.fromJson(Map<String, dynamic> json) => BillerInfo(
    type: json["type"],
    name: json["name"],
    description: json["description"],
    ownership: json["ownership"],
    effectFrom: json["effectFrom"],
    effectTo: json["effectTo"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "description": description,
    "ownership": ownership,
    "effectFrom": effectFrom,
    "effectTo": effectTo,
  };
}

class Category {
  String? key;
  String? name;

  Category({
    this.key,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    key: json["key"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
  };
}

class Address {
  String? address;
  int? city;
  int? state;
  int? pincode;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "country": country,
  };
}

class Coverage {
  String? address;
  String? countryId;
  String? countryCode;
  String? country;
  int? stateId;
  String? stateCode;
  String? state;
  int? cityId;
  String? city;
  int? pincode;

  Coverage({
    this.address,
    this.countryId,
    this.countryCode,
    this.country,
    this.stateId,
    this.stateCode,
    this.state,
    this.cityId,
    this.city,
    this.pincode,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
    address: json["address"],
    countryId: json["countryId"],
    countryCode: json["countryCode"],
    country: json["country"],
    stateId: json["stateId"],
    stateCode: json["stateCode"],
    state: json["state"],
    cityId: json["cityId"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "countryId": countryId,
    "countryCode": countryCode,
    "country": country,
    "stateId": stateId,
    "stateCode": stateCode,
    "state": state,
    "cityId": cityId,
    "city": city,
    "pincode": pincode,
  };
}

class InitChannel {
  String? name;
  String? desc;
  String? commercialType;
  List<Info>? deviceInfo;

  InitChannel({
    this.name,
    this.desc,
    this.commercialType,
    this.deviceInfo,
  });

  factory InitChannel.fromJson(Map<String, dynamic> json) => InitChannel(
    name: json["name"],
    desc: json["desc"],
    commercialType: json["commercialType"],
    deviceInfo: json["deviceInfo"] == null ? [] : List<Info>.from(json["deviceInfo"]!.map((x) => Info.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "commercialType": commercialType,
    "deviceInfo": deviceInfo == null ? [] : List<dynamic>.from(deviceInfo!.map((x) => x.toJson())),
  };
}

class Info {
  String? name;
  String? desc;
  int? minLength;
  int? maxLength;
  String? inputType;
  String? regex;

  Info({
    this.name,
    this.desc,
    this.minLength,
    this.maxLength,
    this.inputType,
    this.regex,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    name: json["name"],
    desc: json["desc"],
    minLength: json["minLength"],
    maxLength: json["maxLength"],
    inputType: json["inputType"],
    regex: json["regex"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "minLength": minLength,
    "maxLength": maxLength,
    "inputType": inputType,
    "regex": regex,
  };
}

class Parameter {
  String? name;
  String? desc;
  int? minLength;
  int? maxLength;
  String? inputType;
  int? mandatory;
  String? regex;

  Parameter({
    this.name,
    this.desc,
    this.minLength,
    this.maxLength,
    this.inputType,
    this.mandatory,
    this.regex,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
    name: json["name"],
    desc: json["desc"],
    minLength: json["minLength"],
    maxLength: json["maxLength"],
    inputType: json["inputType"],
    mandatory: json["mandatory"],
    regex: json["regex"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "minLength": minLength,
    "maxLength": maxLength,
    "inputType": inputType,
    "mandatory": mandatory,
    "regex": regex,
  };
}

class PaymentMode {
  String? name;
  String? desc;
  List<Info>? paymentInfo;

  PaymentMode({
    this.name,
    this.desc,
    this.paymentInfo,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
    name: json["name"],
    desc: json["desc"],
    paymentInfo: json["paymentInfo"] == null ? [] : List<Info>.from(json["paymentInfo"]!.map((x) => Info.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
    "paymentInfo": paymentInfo == null ? [] : List<dynamic>.from(paymentInfo!.map((x) => x.toJson())),
  };
}
