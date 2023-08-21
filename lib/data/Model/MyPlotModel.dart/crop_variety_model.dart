// To parse this JSON data, do
//
//     final cropVarietyListModel = cropVarietyListModelFromJson(jsonString);

import 'dart:convert';

CropVarietyListModel cropVarietyListModelFromJson(String str) => CropVarietyListModel.fromJson(json.decode(str));

String cropVarietyListModelToJson(CropVarietyListModel data) => json.encode(data.toJson());

class CropVarietyListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<CropVarietyModel> data;
    dynamic data1;

    CropVarietyListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory CropVarietyListModel.fromJson(Map<String, dynamic> json) => CropVarietyListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<CropVarietyModel>.from(json["DATA"].map((x) => CropVarietyModel.fromJson(x))),
        data1: json["DATA1"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": data1,
    };
}

class CropVarietyModel {
    int chataniId;
    String? chataniName;

    CropVarietyModel({
        required this.chataniId,
        required this.chataniName,
    });

    factory CropVarietyModel.fromJson(Map<String, dynamic> json) => CropVarietyModel(
        chataniId: json["CHATANI_ID"],
        chataniName: json["CHATANI_NAME"],
    );

    Map<String, dynamic> toJson() => {
        "CHATANI_ID": chataniId,
        "CHATANI_NAME": chataniName,
    };
}
