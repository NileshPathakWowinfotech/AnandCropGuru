
import 'dart:convert';

class RegisterSherPreffranceModel {
  String? responseCode;
  String? responseMessage;
  dynamic id;
  List<Data>? data;
  dynamic data1;

  RegisterSherPreffranceModel({this.responseCode, this.responseMessage, this.id, this.data, this.data1});

  RegisterSherPreffranceModel.fromJson(Map<String, dynamic> json) {
    responseCode = json["ResponseCode"];
    responseMessage = json["ResponseMessage"];
    id = json["ID"];
    data = json["DATA"] == null ? null : (json["DATA"] as List).map((e) => Data.fromJson(e)).toList();
    data1 = json["DATA1"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ResponseCode"] = responseCode;
    _data["ResponseMessage"] = responseMessage;
    _data["ID"] = id;
    if(data != null) {
      _data["DATA"] = data?.map((e) => e.toJson()).toList();
    }
    _data["DATA1"] = data1;
    return _data;
  }
}

class Data {
  int? userId;
  String? fullName;
  String? mobileNo;
  String? email;
  String? password;
  String? address;
  dynamic token;
  String? referenceNo;
  dynamic profilePhoto;
  dynamic districtName;
  dynamic talukaName;
  dynamic cPin;
  dynamic macAddress;
  dynamic fromDate;
  dynamic toDate;
  dynamic dob;
  String? status;
  String? regDate;
  dynamic huaId;
  dynamic stateId;
  dynamic villageId;
  dynamic bankName;
  dynamic accHolderName;
  dynamic accNo;
  dynamic ifscCode;
  dynamic branchName;
  dynamic districtId;
  dynamic talukaId;
  dynamic paymetamt;
  dynamic paymetdate;
  dynamic paymetstatus;
  dynamic transactionId;
  dynamic bpclTransactionId;
  dynamic altMobNo;
  dynamic detailsAddress;
  dynamic aboutInfo;
  dynamic cityName;
  dynamic stateName;
  int? agronomistId;
  String? userPaymentstatus;
  String? vendorPaymentstatus;
  String? isVendor;
  int? referenceNofinal;
  String? avlBal;
  String? refrenceNo;
  String? isvalid;
  dynamic villageName;

  Data({this.userId, this.fullName, this.mobileNo, this.email, this.password, this.address, this.token, this.referenceNo, this.profilePhoto, this.districtName, this.talukaName, this.cPin, this.macAddress, this.fromDate, this.toDate, this.dob, this.status, this.regDate, this.huaId, this.stateId, this.villageId, this.bankName, this.accHolderName, this.accNo, this.ifscCode, this.branchName, this.districtId, this.talukaId, this.paymetamt, this.paymetdate, this.paymetstatus, this.transactionId, this.bpclTransactionId, this.altMobNo, this.detailsAddress, this.aboutInfo, this.cityName, this.stateName, this.agronomistId, this.userPaymentstatus, this.vendorPaymentstatus, this.isVendor, this.referenceNofinal, this.avlBal, this.refrenceNo, this.isvalid, this.villageName});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json["USER_ID"];
    fullName = json["FULL_NAME"];
    mobileNo = json["MOBILE_NO"];
    email = json["EMAIL"];
    password = json["PASSWORD"];
    address = json["ADDRESS"];
    token = json["TOKEN"];
    referenceNo = json["REFERENCE_NO"];
    profilePhoto = json["PROFILE_PHOTO"];
    districtName = json["DISTRICT_NAME"];
    talukaName = json["TALUKA_NAME"];
    cPin = json["C_PIN"];
    macAddress = json["MAC_ADDRESS"];
    fromDate = json["FROM_DATE"];
    toDate = json["TO_DATE"];
    dob = json["DOB"];
    status = json["STATUS"];
    regDate = json["REG_DATE"];
    huaId = json["HUA_ID"];
    stateId = json["STATE_ID"];
    villageId = json["VILLAGE_ID"];
    bankName = json["BANK_NAME"];
    accHolderName = json["ACC_HOLDER_NAME"];
    accNo = json["ACC_NO"];
    ifscCode = json["IFSC_CODE"];
    branchName = json["BRANCH_NAME"];
    districtId = json["DISTRICT_ID"];
    talukaId = json["TALUKA_ID"];
    paymetamt = json["PAYMETAMT"];
    paymetdate = json["PAYMETDATE"];
    paymetstatus = json["PAYMETSTATUS"];
    transactionId = json["TRANSACTION_ID"];
    bpclTransactionId = json["BPCL_TRANSACTION_ID"];
    altMobNo = json["ALT_MOB_NO"];
    detailsAddress = json["DETAILS_ADDRESS"];
    aboutInfo = json["ABOUT_INFO"];
    cityName = json["CITY_NAME"];
    stateName = json["STATE_NAME"];
    agronomistId = json["AGRONOMIST_ID"];
    userPaymentstatus = json["USER_PAYMENTSTATUS"];
    vendorPaymentstatus = json["VENDOR_PAYMENTSTATUS"];
    isVendor = json["IS_VENDOR"];
    referenceNofinal = json["REFERENCE_NOFINAL"];
    avlBal = json["AVL_BAL"];
    refrenceNo = json["REFRENCE_NO"];
    isvalid = json["ISVALID"];
    villageName = json["VILLAGE_NAME"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["USER_ID"] = userId;
    _data["FULL_NAME"] = fullName;
    _data["MOBILE_NO"] = mobileNo;
    _data["EMAIL"] = email;
    _data["PASSWORD"] = password;
    _data["ADDRESS"] = address;
    _data["TOKEN"] = token;
    _data["REFERENCE_NO"] = referenceNo;
    _data["PROFILE_PHOTO"] = profilePhoto;
    _data["DISTRICT_NAME"] = districtName;
    _data["TALUKA_NAME"] = talukaName;
    _data["C_PIN"] = cPin;
    _data["MAC_ADDRESS"] = macAddress;
    _data["FROM_DATE"] = fromDate;
    _data["TO_DATE"] = toDate;
    _data["DOB"] = dob;
    _data["STATUS"] = status;
    _data["REG_DATE"] = regDate;
    _data["HUA_ID"] = huaId;
    _data["STATE_ID"] = stateId;
    _data["VILLAGE_ID"] = villageId;
    _data["BANK_NAME"] = bankName;
    _data["ACC_HOLDER_NAME"] = accHolderName;
    _data["ACC_NO"] = accNo;
    _data["IFSC_CODE"] = ifscCode;
    _data["BRANCH_NAME"] = branchName;
    _data["DISTRICT_ID"] = districtId;
    _data["TALUKA_ID"] = talukaId;
    _data["PAYMETAMT"] = paymetamt;
    _data["PAYMETDATE"] = paymetdate;
    _data["PAYMETSTATUS"] = paymetstatus;
    _data["TRANSACTION_ID"] = transactionId;
    _data["BPCL_TRANSACTION_ID"] = bpclTransactionId;
    _data["ALT_MOB_NO"] = altMobNo;
    _data["DETAILS_ADDRESS"] = detailsAddress;
    _data["ABOUT_INFO"] = aboutInfo;
    _data["CITY_NAME"] = cityName;
    _data["STATE_NAME"] = stateName;
    _data["AGRONOMIST_ID"] = agronomistId;
    _data["USER_PAYMENTSTATUS"] = userPaymentstatus;
    _data["VENDOR_PAYMENTSTATUS"] = vendorPaymentstatus;
    _data["IS_VENDOR"] = isVendor;
    _data["REFERENCE_NOFINAL"] = referenceNofinal;
    _data["AVL_BAL"] = avlBal;
    _data["REFRENCE_NO"] = refrenceNo;
    _data["ISVALID"] = isvalid;
    _data["VILLAGE_NAME"] = villageName;
    return _data;
  }
} 


// // Convert JSON data to a model instance
// String jsonData = '{"ResponseCode": "200", "ResponseMessage": "Success", "ID": 123, "DATA": [{"USER_ID": 1, "FULL_NAME": "John Doe", "EMAIL": "john@example.com"}], "DATA1": "Additional data"}';
// Map<String, dynamic> jsonMap = json.decode(jsonData);
// var model = RegisterSherPreffranceModel.fromJson(jsonMap);

// // Access the properties
// print(model.responseCode); // Output: 200
// print(model.data?.first?.fullName); // Output: John Doe

// // Convert the model instance to JSON
// var jsonResult = model.toJson();
// String jsonString = json.encode(jsonResult);
// print(jsonString.); // Output: {"ResponseCode":"200","ResponseMessage":"Success","ID":123,"DATA":[{"USER_ID":1,"FULL_NAME":"John Doe","EMAIL":"john@example.com"}],"DATA1":"Additional data"}
