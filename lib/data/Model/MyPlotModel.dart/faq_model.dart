// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<FaqModelLIst> data;
    dynamic data1;

    FaqModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<FaqModelLIst>.from(json["DATA"].map((x) => FaqModelLIst.fromJson(x))),
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

class FaqModelLIst {
    int row;
    int qcId;
    String qcName;
    String qcImg;

    FaqModelLIst({
        required this.row,
        required this.qcId,
        required this.qcName,
        required this.qcImg,
    });

    factory FaqModelLIst.fromJson(Map<String, dynamic> json) => FaqModelLIst(
        row: json["Row"],
        qcId: json["QC_ID"],
        qcName: json["QC_NAME"],
        qcImg: json["QC_IMG"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "QC_ID": qcId,
        "QC_NAME": qcName,
        "QC_IMG": qcImg,
    };
}
