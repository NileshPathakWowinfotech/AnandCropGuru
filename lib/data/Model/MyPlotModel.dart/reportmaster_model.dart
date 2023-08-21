// To parse this JSON data, do
//
//     final testingReportListModel = testingReportListModelFromJson(jsonString);

import 'dart:convert';

TestingReportListModel testingReportListModelFromJson(String str) => TestingReportListModel.fromJson(json.decode(str));

String testingReportListModelToJson(TestingReportListModel data) => json.encode(data.toJson());

class TestingReportListModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<ReportMaster> data;
    dynamic data1;

    TestingReportListModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory TestingReportListModel.fromJson(Map<String, dynamic> json) => TestingReportListModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<ReportMaster>.from(json["DATA"].map((x) => ReportMaster.fromJson(x))),
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

class ReportMaster {
    int row;
    int reportId;
    String reportType;
    String reportImg;
    String reportDesc;
    int userId;
    int plotId;
    String latitude;
    String longitude;
    String location;
    String status;
    String regDate;
    String plotName;
    String fullName;
    String mobileNo;
    DateTime purningDate;
    dynamic remark;

    ReportMaster({
        required this.row,
        required this.reportId,
        required this.reportType,
        required this.reportImg,
        required this.reportDesc,
        required this.userId,
        required this.plotId,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.status,
        required this.regDate,
        required this.plotName,
        required this.fullName,
        required this.mobileNo,
        required this.purningDate,
        required this.remark,
    });

    factory ReportMaster.fromJson(Map<String, dynamic> json) => ReportMaster(
        row: json["Row"],
        reportId: json["REPORT_ID"],
        reportType: json["REPORT_TYPE"],
        reportImg: json["REPORT_IMG"],
        reportDesc: json["REPORT_DESC"],
        userId: json["USER_ID"],
        plotId: json["PLOT_ID"],
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        location: json["LOCATION"],
        status: json["STATUS"],
        regDate: json["REG_DATE"],
        plotName: json["PLOT_NAME"],
        fullName: json["FULL_NAME"],
        mobileNo: json["MOBILE_NO"],
        purningDate: DateTime.parse(json["PURNING_DATE"]),
        remark: json["REMARK"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "REPORT_ID": reportId,
        "REPORT_TYPE": reportType,
        "REPORT_IMG": reportImg,
        "REPORT_DESC": reportDesc,
        "USER_ID": userId,
        "PLOT_ID": plotId,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "LOCATION": location,
        "STATUS": status,
        "REG_DATE": regDate,
        "PLOT_NAME": plotName,
        "FULL_NAME": fullName,
        "MOBILE_NO": mobileNo,
        "PURNING_DATE": purningDate.toIso8601String(),
        "REMARK": remark,
    };
}
