// To parse this JSON data, do
//
//     final krushiLIstModel = krushiLIstModelFromJson(jsonString);

import 'dart:convert';

KrushiLIstModel krushiLIstModelFromJson(String str) => KrushiLIstModel.fromJson(json.decode(str));

String krushiLIstModelToJson(KrushiLIstModel data) => json.encode(data.toJson());

class KrushiLIstModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    List<Data1> data1;
    List<Data2> data2;

    KrushiLIstModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory KrushiLIstModel.fromJson(Map<String, dynamic> json) => KrushiLIstModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
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

class Datum {
    int productId;
    String productName;
    int? price;
    int? discount;
    double? discountInPercentage;
    String description;
    int pcatId;
    int psubcatId;
    int langId;
    dynamic adminId;
    String status;
    String regDate;
    String productImage;
    dynamic productFilterType;
    dynamic shortDescription;
    int starProduct;

    Datum({
        required this.productId,
        required this.productName,
        required this.price,
        required this.discount,
        required this.discountInPercentage,
        required this.description,
        required this.pcatId,
        required this.psubcatId,
        required this.langId,
        required this.adminId,
        required this.status,
        required this.regDate,
        required this.productImage,
        required this.productFilterType,
        required this.shortDescription,
        required this.starProduct,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["PRODUCT_ID"],
        productName: json["PRODUCT_NAME"],
        price:( json["PRICE"] as num?)?.toInt() ?? 0,
        discount: (json["DISCOUNT"] as num?)?.toInt() ?? 0,
        discountInPercentage: json["DISCOUNT_IN_PERCENTAGE"]?.toDouble(),
        description: json["DESCRIPTION"],
        pcatId: json["PCAT_ID"],
        psubcatId: json["PSUBCAT_ID"],
        langId: json["LANG_ID"],
        adminId: json["ADMIN_ID"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
        productImage: json["PRODUCT_IMAGE"],
        productFilterType: json["PRODUCT_FILTER_TYPE"],
        shortDescription: json["SHORT_DESCRIPTION"],
        starProduct: json["STAR_PRODUCT"],
    );

    Map<String, dynamic> toJson() => {
        "PRODUCT_ID": productId,
        "PRODUCT_NAME": productName,
        "PRICE": price,
        "DISCOUNT": discount,
        "DISCOUNT_IN_PERCENTAGE": discountInPercentage,
        "DESCRIPTION": description,
        "PCAT_ID": pcatId,
        "PSUBCAT_ID": psubcatId,
        "LANG_ID": langId,
        "ADMIN_ID": adminId,
        "STATUS": status,
        "REG_DATE": regDate,
        "PRODUCT_IMAGE": productImage,
        "PRODUCT_FILTER_TYPE": productFilterType,
        "SHORT_DESCRIPTION": shortDescription,
        "STAR_PRODUCT": starProduct,
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
