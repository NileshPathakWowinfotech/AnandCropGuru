// To parse this JSON data, do
//
//     final incomeUnitModel = incomeUnitModelFromJson(jsonString);

import 'dart:convert';

IncomeUnitModel incomeUnitModelFromJson(String str) => IncomeUnitModel.fromJson(json.decode(str));

String incomeUnitModelToJson(IncomeUnitModel data) => json.encode(data.toJson());

class IncomeUnitModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<IncomeModel> data;
    List<Data1> data1;
    dynamic data2;

    IncomeUnitModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory IncomeUnitModel.fromJson(Map<String, dynamic> json) => IncomeUnitModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<IncomeModel>.from(json["DATA"].map((x) => IncomeModel.fromJson(x))),
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

class IncomeModel {
    int ulId;
    int unitId;
    String ulName;
    int langId;
    String status;
    DateTime regDate;

    IncomeModel({
        required this.ulId,
        required this.unitId,
        required this.ulName,
        required this.langId,
        required this.status,
        required this.regDate,
    });

    factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        ulId: json["UL_ID"],
        unitId: json["UNIT_ID"],
        ulName: json["UL_NAME"],
        langId: json["LANG_ID"],
        status: json["STATUS"],
        regDate: DateTime.parse(json["REG_DATE"]),
    );

    Map<String, dynamic> toJson() => {
        "UL_ID": ulId,
        "UNIT_ID": unitId,
        "UL_NAME": ulName,
        "LANG_ID": langId,
        "STATUS": status,
        "REG_DATE": regDate.toIso8601String(),
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
