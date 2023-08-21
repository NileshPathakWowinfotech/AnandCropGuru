
import 'dart:convert';
LabListModel labListModelFromJson(String str) =>
    LabListModel.fromJson(json.decode(str));
String labListModelToJson(LabListModel data) => json.encode(data.toJson());
class LabListModel {
  String responseCode;
  String responseMessage;
  dynamic id;
  List<LabList> data;
  List<Data1> data1;
  List<Data2> data2;

  LabListModel({
    required this.responseCode,
    required this.responseMessage,
    this.id,
    required this.data,
    required this.data1,
    required this.data2,
  });

  factory LabListModel.fromJson(Map<String, dynamic> json) => LabListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<LabList>.from(json["DATA"].map((x) => LabList.fromJson(x))),
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

class LabList {
  int enquiryId;
  int userId;
  TestingCategory testingCategory;
  int amount;
  String latitude;
  String longitude;
  String address;
  int pincode;
  String? remark;
  String? adminPdf;
  String? adminRemark;
  Status status;
  String regDate;

  LabList({
    required this.enquiryId,
    required this.userId,
    required this.testingCategory,
    required this.amount,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.pincode,
    this.remark,
    this.adminPdf,
    this.adminRemark,
    required this.status,
    required this.regDate,
  });

  factory LabList.fromJson(Map<String, dynamic> json) => LabList(
        enquiryId: json["ENQUIRY_ID"],
        userId: json["USER_ID"],
        testingCategory: testingCategoryValues.map[json["TESTING_CATEGORY"]]!,
        amount: (json["AMOUNT"] as num?)?.toInt() ?? 0,
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        address: json["ADDRESS"],
        pincode: json["PINCODE"],
        remark: json["REMARK"],
        adminPdf: json["ADMIN_PDF"],
        adminRemark: json["ADMIN_REMARK"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: json["REG_DATE"],
      );

  Map<String, dynamic> toJson() => {
        "ENQUIRY_ID": enquiryId,
        "USER_ID": userId,
        "TESTING_CATEGORY": testingCategoryValues.reverse[testingCategory],
        "AMOUNT": amount,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "ADDRESS": address,
        "PINCODE": pincode,
        "REMARK": remark,
        "ADMIN_PDF": adminPdf,
        "ADMIN_REMARK": adminRemark,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDate,
      };
}

enum Status { ACTIVE, LOADING }

final statusValues = EnumValues({"Active": Status.ACTIVE});

enum TestingCategory { EMPTY }

final testingCategoryValues =
    EnumValues({"माती परीक्षण": TestingCategory.EMPTY});

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
