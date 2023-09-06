// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

MyOrderModel myOrderModelFromJson(String str) => MyOrderModel.fromJson(json.decode(str));

String myOrderModelToJson(MyOrderModel data) => json.encode(data.toJson());

class MyOrderModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<MyOrder> data;
    List<Data1> data1;
    List<Data2> data2;

    MyOrderModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<MyOrder>.from(json["DATA"].map((x) => MyOrder.fromJson(x))),
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

class MyOrder {
    int orderId;
    int userId;
    double? totalPrice;
    int? totalDisc;
    int? totalQty;
    dynamic gst;
    int shippingCharges;
    int? coupenAmount;
    int? coupenId;
    String? coupenCode;
    String? latitude;
    String longitude;
    dynamic timeSlot;
    String orderAddress;
    DateTime orderDate;
    dynamic orderInstruction;
    String paymentMethod;
    String? paymentType;
    dynamic transactionId;
    dynamic paymentStatus;
    double? walletAmount;
    String status;
    String regDate;
    String? trackLink;
    String? trackCode;

    MyOrder({
        required this.orderId,
        required this.userId,
        required this.totalPrice,
        required this.totalDisc,
        required this.totalQty,
        required this.gst,
        required this.shippingCharges,
        required this.coupenAmount,
        required this.coupenId,
        required this.coupenCode,
        required this.latitude,
        required this.longitude,
        required this.timeSlot,
        required this.orderAddress,
        required this.orderDate,
        required this.orderInstruction,
        required this.paymentMethod,
        required this.paymentType,
        required this.transactionId,
        required this.paymentStatus,
        required this.walletAmount,
        required this.status,
        required this.regDate,
        required this.trackLink,
        required this.trackCode,
    });

    factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        orderId: json["ORDER_ID"],
        userId: json["USER_ID"],
        totalPrice: json["TOTAL_PRICE"]?.toDouble(),
        totalDisc: (json["TOTAL_DISC"]as num?)?.toInt() ?? 0,
        totalQty:( json["TOTAL_QTY"]as num?)?.toInt() ?? 0,
        gst: (json["GST"]as num?)?.toInt() ?? 0,
        shippingCharges: (json["SHIPPING_CHARGES"]as num?)?.toInt() ?? 0,
        coupenAmount: (json["COUPEN_AMOUNT"]as num?)?.toInt() ?? 0,
        coupenId: json["COUPEN_ID"],
        coupenCode: json["COUPEN_CODE"],
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
        timeSlot: json["TIME_SLOT"],
        orderAddress: json["ORDER_ADDRESS"],
        orderDate: DateTime.parse(json["ORDER_DATE"]),
        orderInstruction: json["ORDER_INSTRUCTION"],
        paymentMethod: json["PAYMENT_METHOD"],
        paymentType: json["PAYMENT_TYPE"],
        transactionId: json["TRANSACTION_ID"],
        paymentStatus: json["PAYMENT_STATUS"],
        walletAmount: json["WALLET_AMOUNT"]?.toDouble(),
        status: json["STATUS"],
        regDate: json["REG_DATE"],
        trackLink: json["TRACK_LINK"],
        trackCode: json["TRACK_CODE"],
    );

    Map<String, dynamic> toJson() => {
        "ORDER_ID": orderId,
        "USER_ID": userId,
        "TOTAL_PRICE": totalPrice,
        "TOTAL_DISC": totalDisc,
        "TOTAL_QTY": totalQty,
        "GST": gst,
        "SHIPPING_CHARGES": shippingCharges,
        "COUPEN_AMOUNT": coupenAmount,
        "COUPEN_ID": coupenId,
        "COUPEN_CODE": coupenCode,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
        "TIME_SLOT": timeSlot,
        "ORDER_ADDRESS": orderAddress,
        "ORDER_DATE": orderDate.toIso8601String(),
        "ORDER_INSTRUCTION": orderInstruction,
        "PAYMENT_METHOD": paymentMethod,
        "PAYMENT_TYPE": paymentType,
        "TRANSACTION_ID": transactionId,
        "PAYMENT_STATUS": paymentStatus,
        "WALLET_AMOUNT": walletAmount,
        "STATUS": status,
        "REG_DATE": regDate,
        "TRACK_LINK": trackLink,
        "TRACK_CODE": trackCode,
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
