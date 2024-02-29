// To parse this JSON data, do
//
//     final walletTransReportModel = walletTransReportModelFromJson(jsonString);

import 'dart:convert';

WalletTransReportModel walletTransReportModelFromJson(String str) => WalletTransReportModel.fromJson(json.decode(str));

String walletTransReportModelToJson(WalletTransReportModel data) => json.encode(data.toJson());

class WalletTransReportModel {
  WalletTransReportModel({
    this.status,
    this.pages,
    this.data,
  });

  String? status;
  int? pages;
  List<TInfo>? data;

  factory WalletTransReportModel.fromJson(Map<String, dynamic> json) => WalletTransReportModel(
    status: json["status"],
    pages: json["pages"],
    data: json["data"] == null ? [] : List<TInfo>.from(json["data"]!.map((x) => TInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pages": pages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TInfo {
  TInfo({
    this.id,
    this.type,
    this.fundbankId,
    this.paymode,
    this.amount,
    this.refNo,
    this.paydate,
    this.payslip,
    this.remark,
    this.status,
    this.userId,
    this.creditedBy,
    this.createdAt,
    this.updatedAt,
    this.fundbank,
    this.user,
    this.sender,
  });

  int? id;
  String? type;
  int? fundbankId;
  String? paymode;
  int? amount;
  String? refNo;
  String? paydate;
  String? payslip;
  String? remark;
  String? status;
  int? userId;
  int? creditedBy;
  String? createdAt;
  String? updatedAt;
  Fundbank? fundbank;
  User? user;
  Sender? sender;

  factory TInfo.fromJson(Map<String, dynamic> json) => TInfo(
    id: json["id"],
    type: json["type"],
    fundbankId: json["fundbank_id"],
    paymode: json["paymode"],
    amount: json["amount"],
    refNo: json["ref_no"],
    paydate: json["paydate"],
    payslip: json["payslip"],
    remark: json["remark"],
    status: json["status"],
    userId: json["user_id"],
    creditedBy: json["credited_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    fundbank: json["fundbank"] == null ? null : Fundbank.fromJson(json["fundbank"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "fundbank_id": fundbankId,
    "paymode": paymode,
    "amount": amount,
    "ref_no": refNo,
    "paydate": paydate,
    "payslip": payslip,
    "remark": remark,
    "status": status,
    "user_id": userId,
    "credited_by": creditedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "fundbank": fundbank?.toJson(),
    "user": user?.toJson(),
    "sender": sender?.toJson(),
  };
}

class Fundbank {
  Fundbank({
    this.id,
    this.name,
    this.account,
    this.ifsc,
    this.branch,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? name;
  String? account;
  String? ifsc;
  String? branch;
  int? userId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Sender? user;

  factory Fundbank.fromJson(Map<String, dynamic> json) => Fundbank(
    id: json["id"],
    name: json["name"],
    account: json["account"],
    ifsc: json["ifsc"],
    branch: json["branch"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: json["user"] == null ? null : Sender.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "account": account,
    "ifsc": ifsc,
    "branch": branch,
    "user_id": userId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
  };
}

class Sender {
  Sender({
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
  int? mainwallet;
  int? nsdlwallet;
  int? aepsbalance;
  int? lockedamount;
  int? roleId;
  int? parentId;
  int? companyId;
  int? schemeId;
  String? status;
  String? address;
  String? shopname;
  String? gstin;
  String? city;
  String? state;
  String? pincode;
  String? pancard;
  String? aadharcard;
  dynamic pancardpic;
  dynamic aadharcardpic;
  dynamic aadharcardbackpic;
  dynamic chequepic;
  dynamic gstpic;
  dynamic profile;
  String? kyc;
  dynamic callbackurl;
  dynamic remark;
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
  dynamic deviceId;
  String? parents;
  SenderRole? role;
  Company? company;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    otpverify: json["otpverify"],
    otpresend: json["otpresend"],
    mainwallet: json["mainwallet"],
    nsdlwallet: json["nsdlwallet"],
    aepsbalance: json["aepsbalance"],
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
    role: json["role"] == null ? null : SenderRole.fromJson(json["role"]),
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

class SenderRole {
  SenderRole({
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
  String? scheme;

  factory SenderRole.fromJson(Map<String, dynamic> json) => SenderRole(
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

class User {
  User({
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
  PurpleRole? role;
  Company? company;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    role: json["role"] == null ? null : PurpleRole.fromJson(json["role"]),
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

class PurpleRole {
  PurpleRole({
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

  factory PurpleRole.fromJson(Map<String, dynamic> json) => PurpleRole(
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
