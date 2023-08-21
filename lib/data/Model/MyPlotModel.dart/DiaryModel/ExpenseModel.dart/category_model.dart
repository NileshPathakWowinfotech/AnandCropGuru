// To parse this JSON data, do
//
//     final categoryNameModel = categoryNameModelFromJson(jsonString);

import 'dart:convert';

CategoryNameModel categoryNameModelFromJson(String str) => CategoryNameModel.fromJson(json.decode(str));

String categoryNameModelToJson(CategoryNameModel data) => json.encode(data.toJson());

class CategoryNameModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<CategoryModel> data;
    List<Data1> data1;
    dynamic data2;

    CategoryNameModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory CategoryNameModel.fromJson(Map<String, dynamic> json) => CategoryNameModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<CategoryModel>.from(json["DATA"].map((x) => CategoryModel.fromJson(x))),
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

class CategoryModel {
    int row;
    int catId;
    String catName;
    int? userId;

    CategoryModel({
        required this.row,
        required this.catId,
        required this.catName,
        required this.userId,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        row: json["Row"],
        catId: json["CAT_ID"],
        catName: json["CAT_NAME"],
        userId: json["USER_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "CAT_ID": catId,
        "CAT_NAME": catName,
        "USER_ID": userId,
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
