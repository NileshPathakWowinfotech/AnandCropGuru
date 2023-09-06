// To parse this JSON data, do
//
//     final shopForYourCropModel = shopForYourCropModelFromJson(jsonString);

import 'dart:convert';

ShopForYourCropModel shopForYourCropModelFromJson(String str) => ShopForYourCropModel.fromJson(json.decode(str));

String shopForYourCropModelToJson(ShopForYourCropModel data) => json.encode(data.toJson());

class ShopForYourCropModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ShopYourCrop> data;
    dynamic data1;

    ShopForYourCropModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory ShopForYourCropModel.fromJson(Map<String, dynamic> json) => ShopForYourCropModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ShopYourCrop>.from(json["DATA"].map((x) => ShopYourCrop.fromJson(x))),
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

class ShopYourCrop {
    int row;
    int cropId;
    String cropName;
    String cropImage;
    CropAppStatus cropAppStatus;
    int cropPlotCount;
    AddUserPlotStatus addUserPlotStatus;

    ShopYourCrop({
        required this.row,
        required this.cropId,
        required this.cropName,
        required this.cropImage,
        required this.cropAppStatus,
        required this.cropPlotCount,
        required this.addUserPlotStatus,
    });

    factory ShopYourCrop.fromJson(Map<String, dynamic> json) => ShopYourCrop(
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
