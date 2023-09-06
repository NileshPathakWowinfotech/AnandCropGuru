// To parse this JSON data, do
//
//     final productCommentModel = productCommentModelFromJson(jsonString);

import 'dart:convert';

ProductCommentModel productCommentModelFromJson(String str) => ProductCommentModel.fromJson(json.decode(str));

String productCommentModelToJson(ProductCommentModel data) => json.encode(data.toJson());

class ProductCommentModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ProductModel> data;
    List<Data1> data1;
    List<Data2> data2;

    ProductCommentModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ProductCommentModel.fromJson(Map<String, dynamic> json) => ProductCommentModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ProductModel>.from(json["DATA"].map((x) => ProductModel.fromJson(x))),
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

class ProductModel {
    int ufId;
    int userId;
    String fullName;
    String profilePhoto;
    int productId;
    double rating;
    String ratingMessage;
    dynamic ratingEmail;
    String status;
    String regDate;

    ProductModel({
        required this.ufId,
        required this.userId,
        required this.fullName,
        required this.profilePhoto,
        required this.productId,
        required this.rating,
        required this.ratingMessage,
        required this.ratingEmail,
        required this.status,
        required this.regDate,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        ufId: json["UF_ID"],
        userId: json["USER_ID"],
        fullName: json["FULL_NAME"],
        profilePhoto: json["PROFILE_PHOTO"],
        productId: json["PRODUCT_ID"],
        rating: (json["RATING"] as num?)?.toDouble() ?? 0.0,
        ratingMessage: json["RATING_MESSAGE"],
        ratingEmail: json["RATING_EMAIL"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "UF_ID": ufId,
        "USER_ID": userId,
        "FULL_NAME": fullName,
        "PROFILE_PHOTO": profilePhoto,
        "PRODUCT_ID": productId,
        "RATING": rating,
        "RATING_MESSAGE": ratingMessage,
        "RATING_EMAIL": ratingEmail,
        "STATUS": status,
        "REG_DATE": regDate,
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
