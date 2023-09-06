// To parse this JSON data, do
//
//     final relatedVideosModel = relatedVideosModelFromJson(jsonString);

import 'dart:convert';

RelatedVideosModel relatedVideosModelFromJson(String str) => RelatedVideosModel.fromJson(json.decode(str));

String relatedVideosModelToJson(RelatedVideosModel data) => json.encode(data.toJson());

class RelatedVideosModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<RelatedModel> data;
    List<Data1> data1;
    List<Data2> data2;

    RelatedVideosModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory RelatedVideosModel.fromJson(Map<String, dynamic> json) => RelatedVideosModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<RelatedModel>.from(json["DATA"].map((x) => RelatedModel.fromJson(x))),
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

class RelatedModel {
    int videoId;
    String videoTitle;
    String videoUrl;
    String videoImage;
    String videoDescription;
    int productId;
    int langId;
    String status;
    String regDate;

    RelatedModel({
        required this.videoId,
        required this.videoTitle,
        required this.videoUrl,
        required this.videoImage,
        required this.videoDescription,
        required this.productId,
        required this.langId,
        required this.status,
        required this.regDate,
    });

    factory RelatedModel.fromJson(Map<String, dynamic> json) => RelatedModel(
        videoId: json["VIDEO_ID"],
        videoTitle: json["VIDEO_TITLE"],
        videoUrl: json["VIDEO_URL"],
        videoImage: json["VIDEO_IMAGE"],
        videoDescription: json["VIDEO_DESCRIPTION"],
        productId: json["PRODUCT_ID"],
        langId: json["LANG_ID"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "VIDEO_ID": videoId,
        "VIDEO_TITLE": videoTitle,
        "VIDEO_URL": videoUrl,
        "VIDEO_IMAGE": videoImage,
        "VIDEO_DESCRIPTION": videoDescription,
        "PRODUCT_ID": productId,
        "LANG_ID": langId,
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
