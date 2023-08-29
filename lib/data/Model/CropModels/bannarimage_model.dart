// To parse this JSON data, do
//
//     final bannarImageModel = bannarImageModelFromJson(jsonString);

import 'dart:convert';

BannarImageModel bannarImageModelFromJson(String str) => BannarImageModel.fromJson(json.decode(str));

String bannarImageModelToJson(BannarImageModel data) => json.encode(data.toJson());

class BannarImageModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<BannarListModel> data;
    dynamic data1;

    BannarImageModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory BannarImageModel.fromJson(Map<String, dynamic> json) => BannarImageModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<BannarListModel>.from(json["DATA"].map((x) => BannarListModel.fromJson(x))),
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

class BannarListModel {
    String bannerName;
    String bannerImage;
    int bannerId;
    dynamic bannerLink;
    int productId;
    int pcatId;
    int psubcatId;

    BannarListModel({
        required this.bannerName,
        required this.bannerImage,
        required this.bannerId,
        required this.bannerLink,
        required this.productId,
        required this.pcatId,
        required this.psubcatId,
    });

    factory BannarListModel.fromJson(Map<String, dynamic> json) => BannarListModel(
        bannerName: json["BANNER_NAME"],
        bannerImage: json["BANNER_IMAGE"],
        bannerId: json["BANNER_ID"],
        bannerLink: json["BANNER_LINK"],
        productId: json["PRODUCT_ID"],
        pcatId: json["PCAT_ID"],
        psubcatId: json["PSUBCAT_ID"],
    );

    Map<String, dynamic> toJson() => {
        "BANNER_NAME": bannerName,
        "BANNER_IMAGE": bannerImage,
        "BANNER_ID": bannerId,
        "BANNER_LINK": bannerLink,
        "PRODUCT_ID": productId,
        "PCAT_ID": pcatId,
        "PSUBCAT_ID": psubcatId,
    };
}
