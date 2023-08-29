import 'dart:convert';
CommunityModel communityModelFromJson(String str) => CommunityModel.fromJson(json.decode(str));
String communityModelToJson(CommunityModel data) => json.encode(data.toJson());

class CommunityModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<CommunityListMOdel> data;
    List<Data1> data1;
    List<Data2> data2;

    CommunityModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<CommunityListMOdel>.from(json["DATA"].map((x) => CommunityListMOdel.fromJson(x))),
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

class CommunityListMOdel {
    int row;
    int postId;
    int userId;
    String fullName;
    String profilePhoto;
    int cropId;
    String cropName;
    String postName;
    String postDescription;
    String postPhoto;
    int myLikeCount;
    int totalLikeCount;
    int totalCommentCount;
    Status status;
    String regDate;

    CommunityListMOdel({
        required this.row,
        required this.postId,
        required this.userId,
        required this.fullName,
        required this.profilePhoto,
        required this.cropId,
        required this.cropName,
        required this.postName,
        required this.postDescription,
        required this.postPhoto,
        required this.myLikeCount,
        required this.totalLikeCount,
        required this.totalCommentCount,
        required this.status,
        required this.regDate,
    });

    factory CommunityListMOdel.fromJson(Map<String, dynamic> json) => CommunityListMOdel(
        row: json["Row"],
        postId: json["POST_ID"],
        userId: json["USER_ID"],
        fullName: json["FULL_NAME"],
        profilePhoto: json["PROFILE_PHOTO"],
        cropId: json["CROP_ID"],
        cropName: json["CROP_NAME"],
        postName: json["POST_NAME"],
        postDescription: json["POST_DESCRIPTION"],
        postPhoto: json["POST_PHOTO"],
        myLikeCount: json["MY_LIKE_COUNT"],
        totalLikeCount: json["TOTAL_LIKE_COUNT"],
        totalCommentCount: json["TOTAL_COMMENT_COUNT"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: json["REG_DATE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "POST_ID": postId,
        "USER_ID": userId,
        "FULL_NAME": fullName,
        "PROFILE_PHOTO": profilePhoto,
        "CROP_ID": cropId,
        "CROP_NAME": cropName,
        "POST_NAME": postName,
        "POST_DESCRIPTION": postDescription,
        "POST_PHOTO": postPhoto,
        "MY_LIKE_COUNT": myLikeCount,
        "TOTAL_LIKE_COUNT": totalLikeCount,
        "TOTAL_COMMENT_COUNT": totalCommentCount,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDate,
    };
}

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
