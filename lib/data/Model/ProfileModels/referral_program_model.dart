// To parse this JSON data, do
//
//     final referralProgramModel = referralProgramModelFromJson(jsonString);

import 'dart:convert';

ReferralProgramModel referralProgramModelFromJson(String str) => ReferralProgramModel.fromJson(json.decode(str));

String referralProgramModelToJson(ReferralProgramModel data) => json.encode(data.toJson());

class ReferralProgramModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ReferralProgram> data;
    List<Data1> data1;
    List<Data2> data2;

    ReferralProgramModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ReferralProgramModel.fromJson(Map<String, dynamic> json) => ReferralProgramModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ReferralProgram>.from(json["DATA"].map((x) => ReferralProgram.fromJson(x))),
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

class ReferralProgram {
    int userId;
    String fullName;
    int plotCount;
    int labCount;
    int orderCount;

    ReferralProgram({
        required this.userId,
        required this.fullName,
        required this.plotCount,
        required this.labCount,
        required this.orderCount,
    });

    factory ReferralProgram.fromJson(Map<String, dynamic> json) => ReferralProgram(
        userId: json["USER_ID"],
        fullName: json["FULL_NAME"],
        plotCount: json["PLOT_COUNT"],
        labCount: json["LAB_COUNT"],
        orderCount: json["ORDER_COUNT"],
    );

    Map<String, dynamic> toJson() => {
        "USER_ID": userId,
        "FULL_NAME": fullName,
        "PLOT_COUNT": plotCount,
        "LAB_COUNT": labCount,
        "ORDER_COUNT": orderCount,
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
