// To parse this JSON data, do
//
//     final videoListModel = videoListModelFromJson(jsonString);

import 'dart:convert';

VideoListModel videoListModelFromJson(String str) => VideoListModel.fromJson(json.decode(str));

String videoListModelToJson(VideoListModel data) => json.encode(data.toJson());

class VideoListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    dynamic data1;

    VideoListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory VideoListModel.fromJson(Map<String, dynamic> json) => VideoListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
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

class Datum {
    int qcId;
    String qcName;
    String qcImg;

    Datum({
        required this.qcId,
        required this.qcName,
        required this.qcImg,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        qcId: json["QC_ID"],
        qcName: json["QC_NAME"],
        qcImg: json["QC_IMG"],
    );

    Map<String, dynamic> toJson() => {
        "QC_ID": qcId,
        "QC_NAME": qcName,
        "QC_IMG": qcImg,
    };
}
