// To parse this JSON data, do
//
//     final diaryDetailsListModel = diaryDetailsListModelFromJson(jsonString);

import 'dart:convert';

DiaryDetailsListModel diaryDetailsListModelFromJson(String str) => DiaryDetailsListModel.fromJson(json.decode(str));

String diaryDetailsListModelToJson(DiaryDetailsListModel data) => json.encode(data.toJson());

class DiaryDetailsListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<DiaryModel> data;
    dynamic data1;

    DiaryDetailsListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory DiaryDetailsListModel.fromJson(Map<String, dynamic> json) => DiaryDetailsListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<DiaryModel>.from(json["DATA"].map((x) => DiaryModel.fromJson(x))),
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

class DiaryModel {
    int row;
    int udId;
    String udTitle;
    String udDesc;
    int userId;
    int plotId;
    String udImg;
    String latitude;
    String longitude;
    String location;
    int scheduleId;
    String status;
    String regDate;

    DiaryModel({
        required this.row,
        required this.udId,
        required this.udTitle,
        required this.udDesc,
        required this.userId,
        required this.plotId,
        required this.udImg,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.scheduleId,
        required this.status,
        required this.regDate,
    });

    factory DiaryModel.fromJson(Map<String, dynamic> json) => DiaryModel(
        row: json["Row"],
        udId: json["UD_ID"],
        udTitle: json["UD_TITLE"],
        udDesc: json["UD_DESC"],
        userId: json["USER_ID"],
        plotId: json["PLOT_ID"],
        udImg: json["UD_IMG"],
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        location: json["LOCATION"],
        scheduleId: json["SCHEDULE_ID"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "UD_ID": udId,
        "UD_TITLE": udTitle,
        "UD_DESC": udDesc,
        "USER_ID": userId,
        "PLOT_ID": plotId,
        "UD_IMG": udImg,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "LOCATION": location,
        "SCHEDULE_ID": scheduleId,
        "STATUS": status,
        "REG_DATE": regDate,
    };
}
