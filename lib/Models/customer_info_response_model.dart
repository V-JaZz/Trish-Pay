// To parse this JSON data, do
//
//     final customerInfoResponseModel = customerInfoResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerInfoResponseModel customerInfoResponseModelFromJson(String str) => CustomerInfoResponseModel.fromJson(json.decode(str));

String customerInfoResponseModelToJson(CustomerInfoResponseModel data) => json.encode(data.toJson());

class CustomerInfoResponseModel {
  CustomerInfoResponseModel({
    this.status,
    this.message,
    this.data,
    this.slider,
  });

  String? status;
  String? message;
  Data? data;
  List<Sliders>? slider;

  factory CustomerInfoResponseModel.fromJson(Map<String, dynamic> json) => CustomerInfoResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    slider: json["slider"] == null ? [] : List<Sliders>.from(json["slider"]!.map((x) => Sliders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "slider": slider == null ? [] : List<dynamic>.from(slider!.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.otpverify,
    this.otpresend,
    this.mainwallet,
    this.nsdlwallet,
    this.aepsbalance,
    this.lockedamount,
    this.roleId,
    this.parentId,
    this.companyId,
    this.schemeId,
    this.status,
    this.address,
    this.shopname,
    this.gstin,
    this.city,
    this.state,
    this.pincode,
    this.pancard,
    this.aadharcard,
    this.pancardpic,
    this.aadharcardpic,
    this.aadharcardbackpic,
    this.chequepic,
    this.gstpic,
    this.profile,
    this.kyc,
    this.callbackurl,
    this.remark,
    this.resetpwd,
    this.account,
    this.bank,
    this.ifsc,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.mstock,
    this.dstock,
    this.rstock,
    this.apptoken,
    this.passwordold,
    this.tsm,
    this.asm,
    this.deviceId,
    this.parents,
    this.role,
    this.company,
  });

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? otpverify;
  int? otpresend;
  double? mainwallet;
  int? nsdlwallet;
  double? aepsbalance;
  int? lockedamount;
  int? roleId;
  int? parentId;
  int? companyId;
  int? schemeId;
  String? status;
  String? address;
  String? shopname;
  dynamic gstin;
  String? city;
  String? state;
  String? pincode;
  String? pancard;
  String? aadharcard;
  String? pancardpic;
  String? aadharcardpic;
  String? aadharcardbackpic;
  String? chequepic;
  dynamic gstpic;
  dynamic profile;
  String? kyc;
  dynamic callbackurl;
  String? remark;
  String? resetpwd;
  String? account;
  String? bank;
  String? ifsc;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? mstock;
  int? dstock;
  int? rstock;
  String? apptoken;
  String? passwordold;
  String? tsm;
  String? asm;
  String? deviceId;
  String? parents;
  Role? role;
  Company? company;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    otpverify: json["otpverify"],
    otpresend: json["otpresend"],
    mainwallet: json["mainwallet"]?.toDouble(),
    nsdlwallet: json["nsdlwallet"],
    aepsbalance: json["aepsbalance"]?.toDouble(),
    lockedamount: json["lockedamount"],
    roleId: json["role_id"],
    parentId: json["parent_id"],
    companyId: json["company_id"],
    schemeId: json["scheme_id"],
    status: json["status"],
    address: json["address"],
    shopname: json["shopname"],
    gstin: json["gstin"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    pancard: json["pancard"],
    aadharcard: json["aadharcard"],
    pancardpic: json["pancardpic"],
    aadharcardpic: json["aadharcardpic"],
    aadharcardbackpic: json["aadharcardbackpic"],
    chequepic: json["chequepic"],
    gstpic: json["gstpic"],
    profile: json["profile"],
    kyc: json["kyc"],
    callbackurl: json["callbackurl"],
    remark: json["remark"],
    resetpwd: json["resetpwd"],
    account: json["account"],
    bank: json["bank"],
    ifsc: json["ifsc"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    mstock: json["mstock"],
    dstock: json["dstock"],
    rstock: json["rstock"],
    apptoken: json["apptoken"],
    passwordold: json["passwordold"],
    tsm: json["tsm"],
    asm: json["asm"],
    deviceId: json["device_id"],
    parents: json["parents"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "otpverify": otpverify,
    "otpresend": otpresend,
    "mainwallet": mainwallet,
    "nsdlwallet": nsdlwallet,
    "aepsbalance": aepsbalance,
    "lockedamount": lockedamount,
    "role_id": roleId,
    "parent_id": parentId,
    "company_id": companyId,
    "scheme_id": schemeId,
    "status": status,
    "address": address,
    "shopname": shopname,
    "gstin": gstin,
    "city": city,
    "state": state,
    "pincode": pincode,
    "pancard": pancard,
    "aadharcard": aadharcard,
    "pancardpic": pancardpic,
    "aadharcardpic": aadharcardpic,
    "aadharcardbackpic": aadharcardbackpic,
    "chequepic": chequepic,
    "gstpic": gstpic,
    "profile": profile,
    "kyc": kyc,
    "callbackurl": callbackurl,
    "remark": remark,
    "resetpwd": resetpwd,
    "account": account,
    "bank": bank,
    "ifsc": ifsc,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "mstock": mstock,
    "dstock": dstock,
    "rstock": rstock,
    "apptoken": apptoken,
    "passwordold": passwordold,
    "tsm": tsm,
    "asm": asm,
    "device_id": deviceId,
    "parents": parents,
    "role": role?.toJson(),
    "company": company?.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.companyname,
    this.shortname,
    this.website,
    this.logo,
    this.address,
    this.phone,
    this.phone1,
    this.email,
    this.webAuthor,
    this.webKeywords,
    this.webDescription,
    this.copyrightText,
    this.googleMapLink,
    this.iosAppLink,
    this.androidAppLink,
    this.msgUrl,
    this.status,
    this.senderid,
    this.smsuser,
    this.smspwd,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? companyname;
  String? shortname;
  String? website;
  String? logo;
  String? address;
  String? phone;
  String? phone1;
  String? email;
  String? webAuthor;
  String? webKeywords;
  String? webDescription;
  String? copyrightText;
  String? googleMapLink;
  String? iosAppLink;
  String? androidAppLink;
  String? msgUrl;
  String? status;
  String? senderid;
  String? smsuser;
  String? smspwd;
  String? createdAt;
  String? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyname: json["companyname"],
    shortname: json["shortname"],
    website: json["website"],
    logo: json["logo"],
    address: json["address"],
    phone: json["phone"],
    phone1: json["phone1"],
    email: json["email"],
    webAuthor: json["web_author"],
    webKeywords: json["web_keywords"],
    webDescription: json["web_description"],
    copyrightText: json["copyright_text"],
    googleMapLink: json["google_map_link"],
    iosAppLink: json["ios_app_link"],
    androidAppLink: json["android_app_link"],
    msgUrl: json["msg_url"],
    status: json["status"],
    senderid: json["senderid"],
    smsuser: json["smsuser"],
    smspwd: json["smspwd"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyname": companyname,
    "shortname": shortname,
    "website": website,
    "logo": logo,
    "address": address,
    "phone": phone,
    "phone1": phone1,
    "email": email,
    "web_author": webAuthor,
    "web_keywords": webKeywords,
    "web_description": webDescription,
    "copyright_text": copyrightText,
    "google_map_link": googleMapLink,
    "ios_app_link": iosAppLink,
    "android_app_link": androidAppLink,
    "msg_url": msgUrl,
    "status": status,
    "senderid": senderid,
    "smsuser": smsuser,
    "smspwd": smspwd,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Role {
  Role({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.scheme,
  });

  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  int? scheme;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    scheme: json["scheme"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "scheme": scheme,
  };
}

class Sliders {
  Sliders({
    this.id,
    this.image,
    this.text,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? image;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    id: json["id"],
    image: json["image"],
    text: json["text"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "text": text,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
