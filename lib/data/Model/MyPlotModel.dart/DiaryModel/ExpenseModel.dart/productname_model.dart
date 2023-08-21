// To parse this JSON data, do
//
//     final productNameModel = productNameModelFromJson(jsonString);

import 'dart:convert';

ProductNameModel productNameModelFromJson(String str) => ProductNameModel.fromJson(json.decode(str));

String productNameModelToJson(ProductNameModel data) => json.encode(data.toJson());

class ProductNameModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ProductModel> data;
    List<Data1> data1;
    dynamic data2;

    ProductNameModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ProductNameModel.fromJson(Map<String, dynamic> json) => ProductNameModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ProductModel>.from(json["DATA"].map((x) => ProductModel.fromJson(x))),
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

class ProductModel {
    int row;
    int catId;
    String productName;
    int userId;
    int productId;

    ProductModel({
        required this.row,
        required this.catId,
        required this.productName,
        required this.userId,
        required this.productId,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        row: json["Row"],
        catId: json["CAT_ID"],
        productName: json["PRODUCT_NAME"],
        userId: json["USER_ID"],
        productId: json["PRODUCT_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "CAT_ID": catId,
        "PRODUCT_NAME": productName,
        "USER_ID": userId,
        "PRODUCT_ID": productId,
    };
}

class Data1 {
    int column1;

    Data1({
        required this.column1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        column1: json["Column1"],
    );

    Map<String, dynamic> toJson() => {
        "Column1": column1,
    };
}
