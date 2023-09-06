// To parse this JSON data, do
//
//     final shopBySubCategoryModel = shopBySubCategoryModelFromJson(jsonString);

import 'dart:convert';

ShopBySubCategoryModel shopBySubCategoryModelFromJson(String str) => ShopBySubCategoryModel.fromJson(json.decode(str));

String shopBySubCategoryModelToJson(ShopBySubCategoryModel data) => json.encode(data.toJson());

class ShopBySubCategoryModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    List<dynamic> data1;
    List<Data2> data2;

    ShopBySubCategoryModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ShopBySubCategoryModel.fromJson(Map<String, dynamic> json) => ShopBySubCategoryModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
        data1: List<dynamic>.from(json["DATA1"].map((x) => x)),
        data2: List<Data2>.from(json["DATA2"].map((x) => Data2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": List<dynamic>.from(data1.map((x) => x)),
        "DATA2": List<dynamic>.from(data2.map((x) => x.toJson())),
    };
}

class Datum {
    int psubcatId;
    String psubcatName;
    String psubcatImage;

    Datum({
        required this.psubcatId,
        required this.psubcatName,
        required this.psubcatImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        psubcatId: json["PSUBCAT_ID"],
        psubcatName: json["PSUBCAT_NAME"],
        psubcatImage: json["PSUBCAT_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "PSUBCAT_ID": psubcatId,
        "PSUBCAT_NAME": psubcatName,
        "PSUBCAT_IMAGE": psubcatImage,
    };
}

class Data2 {
    int column1;

    Data2({
        required this.column1,
    });

    factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        column1: json["Column1"],
    );

    Map<String, dynamic> toJson() => {
        "Column1": column1,
    };
}
