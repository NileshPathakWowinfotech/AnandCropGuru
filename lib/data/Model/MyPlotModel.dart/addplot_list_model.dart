// To parse this JSON data, do
//
//     final cropAddListModel = cropAddListModelFromJson(jsonString);

import 'dart:convert';

CropAddListModel cropAddListModelFromJson(String str) => CropAddListModel.fromJson(json.decode(str));

String cropAddListModelToJson(CropAddListModel data) => json.encode(data.toJson());

class CropAddListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<CropAddList> data;
    dynamic data1;
    dynamic data2;

    CropAddListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory CropAddListModel.fromJson(Map<String, dynamic> json) => CropAddListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<CropAddList>.from(json["DATA"].map((x) => CropAddList.fromJson(x))),
        data1: json["DATA1"],
        data2: json["DATA2"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": data1,
        "DATA2": data2,
    };
}

class CropAddList {
    String cropcatId;
    String cropcatName;
    String cropcatImage;
    List<CropList> cropList;

    CropAddList({
        required this.cropcatId,
        required this.cropcatName,
        required this.cropcatImage,
        required this.cropList,
    });

    factory CropAddList.fromJson(Map<String, dynamic> json) => CropAddList(
        cropcatId: json["CROPCAT_ID"],
        cropcatName: json["CROPCAT_NAME"],
        cropcatImage: json["CROPCAT_IMAGE"],
        cropList: List<CropList>.from(json["CROP_LIST"].map((x) => CropList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CROPCAT_ID": cropcatId,
        "CROPCAT_NAME": cropcatName,
        "CROPCAT_IMAGE": cropcatImage,
        "CROP_LIST": List<dynamic>.from(cropList.map((x) => x.toJson())),
    };
}

class CropList {
    String row;
    String cropId;
    String cropName;
    String cropImage;
    CropAppStatus cropAppStatus;
    String cropPlotCount;
    AddUserPlotStatus addUserPlotStatus;

    CropList({
        required this.row,
        required this.cropId,
        required this.cropName,
        required this.cropImage,
        required this.cropAppStatus,
        required this.cropPlotCount,
        required this.addUserPlotStatus,
    });

    factory CropList.fromJson(Map<String, dynamic> json) => CropList(
        row: json["Row"],
        cropId: json["CROP_ID"],
        cropName: json["CROP_NAME"],
        cropImage: json["CROP_IMAGE"],
        cropAppStatus: cropAppStatusValues.map[json["CROP_APP_STATUS"]]!,
        cropPlotCount: json["CROP_PLOT_COUNT"],
        addUserPlotStatus: addUserPlotStatusValues.map[json["ADD_USER_PLOT_STATUS"]]!,
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "CROP_ID": cropId,
        "CROP_NAME": cropName,
        "CROP_IMAGE": cropImage,
        "CROP_APP_STATUS": cropAppStatusValues.reverse[cropAppStatus],
        "CROP_PLOT_COUNT": cropPlotCount,
        "ADD_USER_PLOT_STATUS": addUserPlotStatusValues.reverse[addUserPlotStatus],
    };
}

enum AddUserPlotStatus {
    CONFIRM_USER_PLOT
}

final addUserPlotStatusValues = EnumValues({
    "ConfirmUserPlot": AddUserPlotStatus.CONFIRM_USER_PLOT
});

enum CropAppStatus {
    YES
}

final cropAppStatusValues = EnumValues({
    "Yes": CropAppStatus.YES
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
