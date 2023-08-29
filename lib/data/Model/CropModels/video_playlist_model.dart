// To parse this JSON data, do
//
//     final videoPlayListModel = videoPlayListModelFromJson(jsonString);

import 'dart:convert';

VideoPlayListModel videoPlayListModelFromJson(String str) => VideoPlayListModel.fromJson(json.decode(str));

String videoPlayListModelToJson(VideoPlayListModel data) => json.encode(data.toJson());

class VideoPlayListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    dynamic data1;

    VideoPlayListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory VideoPlayListModel.fromJson(Map<String, dynamic> json) => VideoPlayListModel(
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
    int row;
    int videoId;
    String videoTitle;
    String videoUrl;

    Datum({
        required this.row,
        required this.videoId,
        required this.videoTitle,
        required this.videoUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        row: json["Row"],
        videoId: json["VIDEO_ID"],
        videoTitle: json["VIDEO_TITLE"],
        videoUrl: json["VIDEO_URL"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "VIDEO_ID": videoId,
        "VIDEO_TITLE": videoTitle,
        "VIDEO_URL": videoUrl,
    };
}
