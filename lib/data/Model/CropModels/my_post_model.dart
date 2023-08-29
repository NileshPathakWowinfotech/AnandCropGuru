// To parse this JSON data, do
//
//     final myPostModel = myPostModelFromJson(jsonString);

import 'dart:convert';

MyPostModel myPostModelFromJson(String str) => MyPostModel.fromJson(json.decode(str));

String myPostModelToJson(MyPostModel data) => json.encode(data.toJson());

class MyPostModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<MyPostModelList> data;
    dynamic data1;

    MyPostModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<MyPostModelList>.from(json["DATA"].map((x) => MyPostModelList.fromJson(x))),
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

class MyPostModelList {
    int row;
    int blogId;
    String blogTitle;
    String blog;
    String blogImage;
    dynamic blogDate;
    int blogLikeCount;
    int blogView;
    String blogLikeStatus;

    MyPostModelList({
        required this.row,
        required this.blogId,
        required this.blogTitle,
        required this.blog,
        required this.blogImage,
        required this.blogDate,
        required this.blogLikeCount,
        required this.blogView,
        required this.blogLikeStatus,
    });

    factory MyPostModelList.fromJson(Map<String, dynamic> json) => MyPostModelList(
        row: json["Row"],
        blogId: json["BLOG_ID"],
        blogTitle: json["BLOG_TITLE"],
        blog: json["BLOG"],
        blogImage: json["BLOG_IMAGE"],
        blogDate: json["BLOG_DATE"],
        blogLikeCount: json["BLOG_LIKE_COUNT"],
        blogView: json["BLOG_VIEW"],
        blogLikeStatus: json["BLOG_LIKE_STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "BLOG_ID": blogId,
        "BLOG_TITLE": blogTitle,
        "BLOG": blog,
        "BLOG_IMAGE": blogImage,
        "BLOG_DATE": blogDate,
        "BLOG_LIKE_COUNT": blogLikeCount,
        "BLOG_VIEW": blogView,
        "BLOG_LIKE_STATUS": blogLikeStatus,
    };
}
