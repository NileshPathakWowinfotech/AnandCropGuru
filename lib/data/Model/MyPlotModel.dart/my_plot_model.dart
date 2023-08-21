// To parse this JSON data, do
//
//     final myPloatModel = myPloatModelFromJson(jsonString);

import 'dart:convert';

MyPloatModel myPloatModelFromJson(String str) => MyPloatModel.fromJson(json.decode(str));

String myPloatModelToJson(MyPloatModel data) => json.encode(data.toJson());

class MyPloatModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<PlotModel> data;
    dynamic data1;

    MyPloatModel({
        required this.responseCode,
        required this.responseMessage,
        this.id,
        required this.data,
        this.data1,
    });

    factory MyPloatModel.fromJson(Map<String, dynamic> json) => MyPloatModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<PlotModel>.from(json["DATA"].map((x) => PlotModel.fromJson(x))),
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

class PlotModel {
    int row;
    int plotId;
    int cropId;
    int vId;
    int userId;
    String cropName;
    String vName;
    String plotName;
    String purningDate;
    String area;
    Address address;
    String latitude;
    String longitude;
    IsPackageExpired status;
    String regDate;
    int plotChataniId;
    IrrigationSource irrigationSource;
    String cropDistance;
    String plotUdhesh;
    int packageId;
    PreviousYearproblem previousYearproblem;
    String structureType;
    IsPackageExpired isPackageExpired;
    int isDeleteRequest;
    String cropImageNew;
    double totalExpences;
    int totalIncome;

    PlotModel({
        required this.row,
        required this.plotId,
        required this.cropId,
        required this.vId,
        required this.userId,
        required this.cropName,
        required this.vName,
        required this.plotName,
        required this.purningDate,
        required this.area,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.status,
        required this.regDate,
        required this.plotChataniId,
        required this.irrigationSource,
        required this.cropDistance,
        required this.plotUdhesh,
        required this.packageId,
        required this.previousYearproblem,
        required this.structureType,
        required this.isPackageExpired,
        required this.isDeleteRequest,
        required this.cropImageNew,
        required this.totalExpences,
        required this.totalIncome,
    });

    factory PlotModel.fromJson(Map<String, dynamic> json) => PlotModel(
        row: json["Row"],
        plotId: json["PLOT_ID"],
        cropId: json["CROP_ID"],
        vId: json["V_ID"],
        userId: json["USER_ID"],
        cropName: json["CROP_NAME"],
        vName: json["V_NAME"],
        plotName: json["PLOT_NAME"],
        purningDate: json["PURNING_DATE"],
        area: json["AREA"],
        address: addressValues.map[json["ADDRESS"]]!,
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        status: isPackageExpiredValues.map[json["STATUS"]]!,
        regDate: json["REG_DATE"],
        plotChataniId: json["PLOT_CHATANI_ID"],
        irrigationSource: irrigationSourceValues.map[json["IRRIGATION_SOURCE"]]!,
        cropDistance: json["CROP_DISTANCE"],
        plotUdhesh: json["PLOT_UDHESH"],
        packageId: json["PACKAGE_ID"],
        previousYearproblem: previousYearproblemValues.map[json["PREVIOUS_YEARPROBLEM"]]!,
        structureType: json["STRUCTURE_TYPE"],
        isPackageExpired: isPackageExpiredValues.map[json["IS_PACKAGE_EXPIRED"]]!,
        isDeleteRequest: json["IS_DELETE_REQUEST"],
        cropImageNew: json["CROP_IMAGE_NEW"],
        totalExpences: (json["TOTAL_EXPENCES"]as num?)?.toDouble() ?? 0.0,
        totalIncome:( json["TOTAL_INCOME"] as num?)?.toInt() ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "PLOT_ID": plotId,
        "CROP_ID": cropId,
        "V_ID": vId,
        "USER_ID": userId,
        "CROP_NAME": cropName,
        "V_NAME": vName,
        "PLOT_NAME": plotName,
        "PURNING_DATE": purningDate,
        "AREA": area,
        "ADDRESS": addressValues.reverse[address],
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "STATUS": isPackageExpiredValues.reverse[status],
        "REG_DATE": regDate,
        "PLOT_CHATANI_ID": plotChataniId,
        "IRRIGATION_SOURCE": irrigationSourceValues.reverse[irrigationSource],
        "CROP_DISTANCE": cropDistance,
        "PLOT_UDHESH": plotUdhesh,
        "PACKAGE_ID": packageId,
        "PREVIOUS_YEARPROBLEM": previousYearproblemValues.reverse[previousYearproblem],
        "STRUCTURE_TYPE": structureType,
        "IS_PACKAGE_EXPIRED": isPackageExpiredValues.reverse[isPackageExpired],
        "IS_DELETE_REQUEST": isDeleteRequest,
        "CROP_IMAGE_NEW": cropImageNew,
        "TOTAL_EXPENCES": totalExpences,
        "TOTAL_INCOME": totalIncome,
    };
}

enum Address {
    EMPTY,
    TESTING
}

final addressValues = EnumValues({
    "": Address.EMPTY,
    "Testing": Address.TESTING
});

enum IrrigationSource {
    EMPTY,
    IRRIGATION_SOURCE
}

final irrigationSourceValues = EnumValues({
    "": IrrigationSource.EMPTY,
    "विहीर": IrrigationSource.IRRIGATION_SOURCE
});

enum IsPackageExpired {
    ACTIVE,
    EXPIRED
}

final isPackageExpiredValues = EnumValues({
    "Active": IsPackageExpired.ACTIVE,
    "Expired": IsPackageExpired.EXPIRED
});

enum PreviousYearproblem {
    EMPTY,
    THTH
}

final previousYearproblemValues = EnumValues({
    "": PreviousYearproblem.EMPTY,
    "thth": PreviousYearproblem.THTH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
