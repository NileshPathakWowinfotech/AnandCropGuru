// To parse this JSON data, do
//
//     final unitCountModel = unitCountModelFromJson(jsonString);

import 'dart:convert';

UnitCountModel unitCountModelFromJson(String str) => UnitCountModel.fromJson(json.decode(str));

String unitCountModelToJson(UnitCountModel data) => json.encode(data.toJson());

class UnitCountModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<UnitCount> data;
    List<Data1> data1;
    dynamic data2;

    UnitCountModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory UnitCountModel.fromJson(Map<String, dynamic> json) => UnitCountModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<UnitCount>.from(json["DATA"].map((x) => UnitCount.fromJson(x))),
        data1: List<Data1>.from(json["DATA1"].map((x) => Data1.fromJson(x))),
        data2: json["DATA2"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": List<dynamic>.from(data1.map((x) => x.toJson())),
        "DATA2": data2,
    };
}

class UnitCount {
    double quantity;

    UnitCount({
        required this.quantity,
    });

    factory UnitCount.fromJson(Map<String, dynamic> json) => UnitCount(
        quantity: json["QUANTITY"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "QUANTITY": quantity,
    };
}

class Data1 {
    int column1;

    Data1({
        required this.column1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        column1: json["Column1"],
    );

    Map<String, dynamic> toJson() => {
        "Column1": column1,
    };
}
