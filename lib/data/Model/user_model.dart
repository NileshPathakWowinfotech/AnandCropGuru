import 'dart:convert';

class UserModel {
  String? userId;
  String? fullName;
  String? mobileNumber;
  String? email;
  String? address;
  String? token;
  String? prference_no;
  String? profilePhoto;
  String? distructName;
  String? talukaName;
  String? agronomist_ID;
  String? stateName;
  String? stateId;
  String? districtId;
  String? talukaId;

  UserModel({
    required this.userId,
    required this.fullName,
    this.mobileNumber,
    this.address,
    this.email,
    required  this.distructName,
    required  taluke,
    required  stateId,
    required  stateName,
    required  districtId,
    required  talukaId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['USER_ID'];
    fullName = json['FULL_NAME'];
    mobileNumber = json['MOBILE_NO'];
    email = json['EMAIL'];
    address = json['ADDRESS'];
    token = json['TOKEN'];
    prference_no = json['REFERENCE_NO'];
    profilePhoto = json['PROFILE_PHOTO'];
    distructName = json['DISTRICT_NAME'];
    talukaName = json['TALUKA_NAME'];
    agronomist_ID = json['agronomist_ID'];
    stateId = json['STATE_ID'];
    stateName = json['STATE_NAME'];
    districtId = json['DISTRICT_ID'];
    talukaId = json['TALUKA_ID'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_ID'] = this.userId;
    data['FULL_NAME'] = this.fullName;
    data['MOBILE_NO'] = this.mobileNumber;
    data['EMAIL'] = this.email;
    data['ADDRESS'] = this.address;
    data['TOKEN'] = this.token;
    data['REFERENCE_NO'] = this.prference_no;
    data['PROFILE_PHOTO'] = this.profilePhoto;
    data['DISTRICT_NAME'] = this.distructName;
    data['TALUKA_NAME'] = this.talukaName;
    data['agronomist_ID'] = this.agronomist_ID;
    data['STATE_ID'] = this.stateId;
    data['STATE_NAME'] = this.stateName;
    data['DISTRICT_ID'] = this.districtId;
    data['TALUKA_ID'] = this.talukaId;

    return data;
  }
}
