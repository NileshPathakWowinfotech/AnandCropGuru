// To parse this JSON data, do
//
//     final labListModel = labListModelFromJson(jsonString);

import 'dart:convert';

LabListModel labListModelFromJson(String str) => LabListModel.fromJson(json.decode(str));

String labListModelToJson(LabListModel data) => json.encode(data.toJson());

class LabListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    List<Data1> data1;
    List<Data2> data2;

    LabListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory LabListModel.fromJson(Map<String, dynamic> json) => LabListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
        data1: List<Data1>.from(json["DATA1"].map((x) => Data1.fromJson(x))),
        data2: List<Data2>.from(json["DATA2"].map((x) => Data2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": List<dynamic>.from(data1.map((x) => x.toJson())),
        "DATA2": List<dynamic>.from(data2.map((x) => x.toJson())),
    };
}

class Datum {
    int enquiryId;
    int userId;
    String testingCategory;
    double amount;
    String latitude;
    String longitude;
    String address;
    int pincode;
    String remark;
    dynamic adminPdf;
    dynamic adminRemark;
    String status;
    String regDate;

    Datum({
        required this.enquiryId,
        required this.userId,
        required this.testingCategory,
        required this.amount,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.pincode,
        required this.remark,
        required this.adminPdf,
        required this.adminRemark,
        required this.status,
        required this.regDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        enquiryId: json["ENQUIRY_ID"],
        userId: json["USER_ID"],
        testingCategory: json["TESTING_CATEGORY"],
        amount:( json["AMOUNT"]as num?)?.toDouble() ?? 0.0,
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        address: json["ADDRESS"],
        pincode: json["PINCODE"],
        remark: json["REMARK"],
        adminPdf: json["ADMIN_PDF"],
        adminRemark: json["ADMIN_REMARK"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "ENQUIRY_ID": enquiryId,
        "USER_ID": userId,
        "TESTING_CATEGORY": testingCategory,
        "AMOUNT": amount,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "ADDRESS": address,
        "PINCODE": pincode,
        "REMARK": remark,
        "ADMIN_PDF": adminPdf,
        "ADMIN_REMARK": adminRemark,
        "STATUS": status,
        "REG_DATE": regDate,
    };
}

class Data1 {
    int table1;

    Data1({
        required this.table1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        table1: json["TABLE1"],
    );

    Map<String, dynamic> toJson() => {
        "TABLE1": table1,
    };
}

class Data2 {
    int table2;

    Data2({
        required this.table2,
    });

    factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        table2: json["TABLE2"],
    );

    Map<String, dynamic> toJson() => {
        "TABLE2": table2,
    };
}
