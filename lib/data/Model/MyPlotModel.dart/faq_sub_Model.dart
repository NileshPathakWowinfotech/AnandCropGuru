// To parse this JSON data, do
//
//     final faqSubListModel = faqSubListModelFromJson(jsonString);

import 'dart:convert';

FaqSubListModel faqSubListModelFromJson(String str) => FaqSubListModel.fromJson(json.decode(str));

String faqSubListModelToJson(FaqSubListModel data) => json.encode(data.toJson());

class FaqSubListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<FaqSubModel> data;
    dynamic data1;

    FaqSubListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory FaqSubListModel.fromJson(Map<String, dynamic> json) => FaqSubListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<FaqSubModel>.from(json["DATA"].map((x) => FaqSubModel.fromJson(x))),
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

class FaqSubModel {
    int row;
    int qId;
    String qName;
    String qAnswer;
    String qImg;

    FaqSubModel({
        required this.row,
        required this.qId,
        required this.qName,
        required this.qAnswer,
        required this.qImg,
    });

    factory FaqSubModel.fromJson(Map<String, dynamic> json) => FaqSubModel(
        row: json["Row"],
        qId: json["Q_ID"],
        qName: json["Q_NAME"],
        qAnswer: json["Q_ANSWER"],
        qImg: json["Q_IMG"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "Q_ID": qId,
        "Q_NAME": qName,
        "Q_ANSWER": qAnswer,
        "Q_IMG": qImg,
    };
}
