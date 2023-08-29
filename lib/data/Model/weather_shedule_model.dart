// To parse this JSON data, do
//
//     final weatherScheduleModel = weatherScheduleModelFromJson(jsonString);

import 'dart:convert';

WeatherScheduleModel weatherScheduleModelFromJson(String str) => WeatherScheduleModel.fromJson(json.decode(str));

String weatherScheduleModelToJson(WeatherScheduleModel data) => json.encode(data.toJson());

class WeatherScheduleModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<SceduleWatherModel> data;
    List<Data1> data1;
    List<Data2> data2;

    WeatherScheduleModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory WeatherScheduleModel.fromJson(Map<String, dynamic> json) => WeatherScheduleModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<SceduleWatherModel>.from(json["DATA"].map((x) => SceduleWatherModel.fromJson(x))),
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

class SceduleWatherModel {
    int swId;
    int cropId;
    int vId;
    String title;
    String description;
    String spray;
    String fertilizer;
    String mashagaticheKame;
    String sImage;
    int fromDay;
    int toDay;
    String status;
    String regDate;

    SceduleWatherModel({
        required this.swId,
        required this.cropId,
        required this.vId,
        required this.title,
        required this.description,
        required this.spray,
        required this.fertilizer,
        required this.mashagaticheKame,
        required this.sImage,
        required this.fromDay,
        required this.toDay,
        required this.status,
        required this.regDate,
    });

    factory SceduleWatherModel.fromJson(Map<String, dynamic> json) => SceduleWatherModel(
        swId: json["SW_ID"],
        cropId: json["CROP_ID"],
        vId: json["V_ID"],
        title: json["TITLE"],
        description: json["DESCRIPTION"],
        spray: json["SPRAY"],
        fertilizer: json["FERTILIZER"],
        mashagaticheKame: json["MASHAGATICHE_KAME"],
        sImage: json["S_IMAGE"],
        fromDay: json["FROM_DAY"],
        toDay: json["TO_DAY"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "SW_ID": swId,
        "CROP_ID": cropId,
        "V_ID": vId,
        "TITLE": title,
        "DESCRIPTION": description,
        "SPRAY": spray,
        "FERTILIZER": fertilizer,
        "MASHAGATICHE_KAME": mashagaticheKame,
        "S_IMAGE": sImage,
        "FROM_DAY": fromDay,
        "TO_DAY": toDay,
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
