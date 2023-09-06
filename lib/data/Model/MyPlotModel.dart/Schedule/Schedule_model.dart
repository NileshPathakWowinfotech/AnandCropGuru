// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Schedule> data;
    dynamic data1;

    ScheduleModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
    });

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Schedule>.from(json["DATA"].map((x) => Schedule.fromJson(x))),
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

class Schedule {
    int row;
    int scheduelId;
    String title;
    String schedule;
    String scheduleDay;
    int scheduleDays;
    String scheduleType;
    String scheduleImage;

    Schedule({
        required this.row,
        required this.scheduelId,
        required this.title,
        required this.schedule,
        required this.scheduleDay,
        required this.scheduleDays,
        required this.scheduleType,
        required this.scheduleImage,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        row: json["Row"],
        scheduelId: json["SCHEDUEL_ID"],
        title: json["TITLE"],
        schedule: json["SCHEDULE"],
        scheduleDay: json["SCHEDULE_DAY"],
        scheduleDays: json["SCHEDULE_DAYS"],
        scheduleType: json["SCHEDULE_TYPE"],
        scheduleImage: json["SCHEDULE_IMAGE"],
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "SCHEDUEL_ID": scheduelId,
        "TITLE": title,
        "SCHEDULE": schedule,
        "SCHEDULE_DAY": scheduleDay,
        "SCHEDULE_DAYS": scheduleDays,
        "SCHEDULE_TYPE": scheduleType,
        "SCHEDULE_IMAGE": scheduleImage,
    };
}
