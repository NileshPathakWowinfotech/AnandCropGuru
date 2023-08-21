// To parse this JSON data, do
//
//     final questionAnswerModel = questionAnswerModelFromJson(jsonString);

import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) => QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) => json.encode(data.toJson());

class QuestionAnswerModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    dynamic data1;

    QuestionAnswerModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) => QuestionAnswerModel(
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
    int questionId;
    String fdDescription;
    String fdImage;
    String fdAnswer;
    int userId;
    String status;
    String regDate;
    String plotName;
    String fullName;
    String mobileNo;
    DateTime purningDate;

    Datum({
        required this.row,
        required this.questionId,
        required this.fdDescription,
        required this.fdImage,
        required this.fdAnswer,
        required this.userId,
        required this.status,
        required this.regDate,
        required this.plotName,
        required this.fullName,
        required this.mobileNo,
        required this.purningDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        row: json["Row"],
        questionId: json["QUESTION_ID"],
        fdDescription: json["FD_DESCRIPTION"],
        fdImage: json["FD_IMAGE"],
        fdAnswer: json["FD_ANSWER"],
        userId: json["USER_ID"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
        plotName: json["PLOT_NAME"],
        fullName: json["FULL_NAME"],
        mobileNo: json["MOBILE_NO"],
        purningDate: DateTime.parse(json["PURNING_DATE"]),
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "QUESTION_ID": questionId,
        "FD_DESCRIPTION": fdDescription,
        "FD_IMAGE": fdImage,
        "FD_ANSWER": fdAnswer,
        "USER_ID": userId,
        "STATUS": status,
        "REG_DATE": regDate,
        "PLOT_NAME": plotName,
        "FULL_NAME": fullName,
        "MOBILE_NO": mobileNo,
        "PURNING_DATE": purningDate.toIso8601String(),
    };
}
