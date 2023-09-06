// To parse this JSON data, do
//
//     final productBlogModel = productBlogModelFromJson(jsonString);

import 'dart:convert';

ProductBlogModel productBlogModelFromJson(String str) => ProductBlogModel.fromJson(json.decode(str));

String productBlogModelToJson(ProductBlogModel data) => json.encode(data.toJson());

class ProductBlogModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ProductBlog> data;
    List<Data1> data1;
    List<Data2> data2;

    ProductBlogModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory ProductBlogModel.fromJson(Map<String, dynamic> json) => ProductBlogModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ProductBlog>.from(json["DATA"].map((x) => ProductBlog.fromJson(x))),
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

class ProductBlog {
    int blogId;
    String blogTitle;
    String blogDescription;
    String blogImage;
    int productId;
    String productName;
    int langId;
    String status;
    String regDate;

    ProductBlog({
        required this.blogId,
        required this.blogTitle,
        required this.blogDescription,
        required this.blogImage,
        required this.productId,
        required this.productName,
        required this.langId,
        required this.status,
        required this.regDate,
    });

    factory ProductBlog.fromJson(Map<String, dynamic> json) => ProductBlog(
        blogId: json["BLOG_ID"],
        blogTitle: json["BLOG_TITLE"],
        blogDescription: json["BLOG_DESCRIPTION"],
        blogImage: json["BLOG_IMAGE"],
        productId: json["PRODUCT_ID"],
        productName: json["PRODUCT_NAME"],
        langId: json["LANG_ID"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "BLOG_ID": blogId,
        "BLOG_TITLE": blogTitle,
        "BLOG_DESCRIPTION": blogDescription,
        "BLOG_IMAGE": blogImage,
        "PRODUCT_ID": productId,
        "PRODUCT_NAME": productName,
        "LANG_ID": langId,
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
