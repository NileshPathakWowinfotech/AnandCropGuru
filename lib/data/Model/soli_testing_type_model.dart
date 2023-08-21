import 'package:meta/meta.dart';
import 'dart:convert';

SoilTestingTypeListModel soilTestingTypeListModelFromJson(String str) =>
    SoilTestingTypeListModel.fromJson(json.decode(str));

String soilTestingTypeListModelToJson(SoilTestingTypeListModel data) =>
    json.encode(data.toJson());

class SoilTestingTypeListModel {
  String responseCode;
  String responseMessage;
  dynamic id;
  List<Datum> data;

  SoilTestingTypeListModel({
    required this.responseCode,
    required this.responseMessage,
    required this.id,
    required this.data,
  });

  factory SoilTestingTypeListModel.fromJson(Map<String, dynamic> json) =>
      SoilTestingTypeListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int testingTypeId;
  String testingTypeName;
  int amount;
  String videoUrl;
  String testingImg;
  String status;
  String regDate;

  Datum({
    required this.testingTypeId,
    required this.testingTypeName,
    required this.amount,
    required this.videoUrl,
    required this.testingImg,
    required this.status,
    required this.regDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        testingTypeId: json["TESTING_TYPE_ID"],
        testingTypeName: json["TESTING_TYPE_NAME"],
        amount: (json["AMOUNT"] as num?)?.toInt() ?? 0,
        videoUrl: json["VIDEO_URL"],
        testingImg: json["TESTING_IMG"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
      );

  Map<String, dynamic> toJson() => {
        "TESTING_TYPE_ID": testingTypeId,
        "TESTING_TYPE_NAME": testingTypeName,
        "AMOUNT": amount,
        "VIDEO_URL": videoUrl,
        "TESTING_IMG": testingImg,
        "STATUS": status,
        "REG_DATE": regDate,
      };
}
