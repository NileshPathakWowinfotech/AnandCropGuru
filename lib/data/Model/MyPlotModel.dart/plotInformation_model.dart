// To parse this JSON data, do
//
//     final plotInformationModel = plotInformationModelFromJson(jsonString);

import 'dart:convert';

PlotInformationModel plotInformationModelFromJson(String str) => PlotInformationModel.fromJson(json.decode(str));

String plotInformationModelToJson(PlotInformationModel data) => json.encode(data.toJson());

class PlotInformationModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<InformationModel> data;
    dynamic data1;

    PlotInformationModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory PlotInformationModel.fromJson(Map<String, dynamic> json) => PlotInformationModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<InformationModel>.from(json["DATA"].map((x) => InformationModel.fromJson(x))),
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

class InformationModel {
    String parameter;
    String value;

    InformationModel({
        required this.parameter,
        required this.value,
    });

    factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
        parameter: json["Parameter"],
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "Parameter": parameter,
        "Value": value,
    };
}
