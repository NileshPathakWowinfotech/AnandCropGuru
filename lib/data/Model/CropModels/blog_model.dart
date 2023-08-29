// To parse this JSON data, do
//
//     final blogListModel = blogListModelFromJson(jsonString);

import 'dart:convert';

BlogListModel blogListModelFromJson(String str) => BlogListModel.fromJson(json.decode(str));

String blogListModelToJson(BlogListModel data) => json.encode(data.toJson());

class BlogListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<BlogsModels> data;
    dynamic data1;

    BlogListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<BlogsModels>.from(json["DATA"].map((x) => BlogsModels.fromJson(x))),
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

class BlogsModels {
    int row;
    int blogId;
    String blogTitle;
    String blog;
    String blogImage;
    dynamic blogDate;
    int blogLikeCount;
    int blogView;
    BlogLikeStatus blogLikeStatus;

    BlogsModels({
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

    factory BlogsModels.fromJson(Map<String, dynamic> json) => BlogsModels(
        row: json["Row"],
        blogId: json["BLOG_ID"],
        blogTitle: json["BLOG_TITLE"],
        blog: json["BLOG"],
        blogImage: json["BLOG_IMAGE"],
        blogDate: json["BLOG_DATE"],
        blogLikeCount: json["BLOG_LIKE_COUNT"],
        blogView: json["BLOG_VIEW"],
        blogLikeStatus: blogLikeStatusValues.map[json["BLOG_LIKE_STATUS"]]!,
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
        "BLOG_LIKE_STATUS": blogLikeStatusValues.reverse[blogLikeStatus],
    };
}

enum BlogLikeStatus {
    NO,
    YES
}

final blogLikeStatusValues = EnumValues({
    "No": BlogLikeStatus.NO,
    "Yes": BlogLikeStatus.YES
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
