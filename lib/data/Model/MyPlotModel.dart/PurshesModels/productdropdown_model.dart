// To parse this JSON data, do
//
//     final productDropDownModel = productDropDownModelFromJson(jsonString);

import 'dart:convert';

ProductDropDownModel productDropDownModelFromJson(String str) => ProductDropDownModel.fromJson(json.decode(str));

String productDropDownModelToJson(ProductDropDownModel data) => json.encode(data.toJson());

class ProductDropDownModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ProductDropDown> data;
    List<Data1> data1;
    dynamic data2;

    ProductDropDownModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ProductDropDownModel.fromJson(Map<String, dynamic> json) => ProductDropDownModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ProductDropDown>.from(json["DATA"].map((x) => ProductDropDown.fromJson(x))),
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

class ProductDropDown {
    int row;
    int catId;
    String? productName;
    int userId;
    int productId;

    ProductDropDown({
        required this.row,
        required this.catId,
        required this.productName,
        required this.userId,
        required this.productId,
    });

    factory ProductDropDown.fromJson(Map<String, dynamic> json) => ProductDropDown(
        row: json["Row"],
        catId:( json["CAT_ID"]as num?)?.toInt() ?? 0,
        productName: json["PRODUCT_NAME"],
        userId:( json["USER_ID"]as num?)?.toInt() ?? 0,
        productId: (json["PRODUCT_ID"]as num?)?.toInt() ?? 0,
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
