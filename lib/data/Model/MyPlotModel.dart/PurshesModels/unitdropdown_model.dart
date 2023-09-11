

import 'dart:convert';

UnitDropDownModel unitDropDownModelFromJson(String str) => UnitDropDownModel.fromJson(json.decode(str));

String unitDropDownModelToJson(UnitDropDownModel data) => json.encode(data.toJson());

class UnitDropDownModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Unit> data;
    List<Data1> data1;
    dynamic data2;

    UnitDropDownModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory UnitDropDownModel.fromJson(Map<String, dynamic> json) => UnitDropDownModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Unit>.from(json["DATA"].map((x) => Unit.fromJson(x))),
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

class Unit {
    int ulId;
    String ulName;
    int unitId;
    int langId;
    String status;
    DateTime regDate;

    Unit({
        required this.ulId,
        required this.ulName,
        required this.unitId,
        required this.langId,
        required this.status,
        required this.regDate,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        ulId: json["UL_ID"],
        ulName: json["UL_NAME"],
        unitId: json["UNIT_ID"],
        langId: json["LANG_ID"],
        status: json["STATUS"],
        regDate: DateTime.parse(json["REG_DATE"]),
    );

    Map<String, dynamic> toJson() => {
        "UL_ID": ulId,
        "UL_NAME": ulName,
        "UNIT_ID": unitId,
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
