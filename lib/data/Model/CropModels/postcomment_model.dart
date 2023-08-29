// To parse this JSON data, do
//
//     final postCommentModel = postCommentModelFromJson(jsonString);

import 'dart:convert';

PostCommentModel postCommentModelFromJson(String str) => PostCommentModel.fromJson(json.decode(str));

String postCommentModelToJson(PostCommentModel data) => json.encode(data.toJson());

class PostCommentModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<CommentModel> data;
    List<Data1> data1;
    List<Data2> data2;

    PostCommentModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory PostCommentModel.fromJson(Map<String, dynamic> json) => PostCommentModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<CommentModel>.from(json["DATA"].map((x) => CommentModel.fromJson(x))),
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

class CommentModel {
    int pcId;
    String comment;
    int postId;
    int userId;
    String fullName;
    String profilePhoto;
    String regDate;

    CommentModel({
        required this.pcId,
        required this.comment,
        required this.postId,
        required this.userId,
        required this.fullName,
        required this.profilePhoto,
        required this.regDate,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        pcId: json["PC_ID"],
        comment: json["COMMENT"],
        postId: json["POST_ID"],
        userId: json["USER_ID"],
        fullName: json["FULL_NAME"],
        profilePhoto: json["PROFILE_PHOTO"],
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "PC_ID": pcId,
        "COMMENT": comment,
        "POST_ID": postId,
        "USER_ID": userId,
        "FULL_NAME": fullName,
        "PROFILE_PHOTO": profilePhoto,
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
