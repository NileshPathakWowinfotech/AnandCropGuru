// To parse this JSON data, do
//
//     final recmmendedProductModel = recmmendedProductModelFromJson(jsonString);

import 'dart:convert';

RecmmendedProductModel recmmendedProductModelFromJson(String str) => RecmmendedProductModel.fromJson(json.decode(str));

String recmmendedProductModelToJson(RecmmendedProductModel data) => json.encode(data.toJson());

class RecmmendedProductModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<Datum> data;
    List<Data1> data1;
    List<Data2> data2;

    RecmmendedProductModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory RecmmendedProductModel.fromJson(Map<String, dynamic> json) => RecmmendedProductModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<Datum>.from(json["DATA"].map((x) => Datum.fromJson(x))),
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

class Datum {
    int productId;
    String pcatName;
    String psubcatName;
    String productName;
    String chemicalName;
    String description;
    int price;
    int discount;
    double discountInPercentage;
    int pcatId;
    int psubcatId;
    int langId;
    String productImage;
    dynamic adminId;
    Status status;
    DateTime regDate;
    int productView;
    int totalProductReview;
    dynamic size;
    dynamic unit;

    Datum({
        required this.productId,
        required this.pcatName,
        required this.psubcatName,
        required this.productName,
        required this.chemicalName,
        required this.description,
        required this.price,
        required this.discount,
        required this.discountInPercentage,
        required this.pcatId,
        required this.psubcatId,
        required this.langId,
        required this.productImage,
        required this.adminId,
        required this.status,
        required this.regDate,
        required this.productView,
        required this.totalProductReview,
        required this.size,
        required this.unit,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["PRODUCT_ID"],
        pcatName: json["PCAT_NAME"],
        psubcatName: json["PSUBCAT_NAME"],
        productName: json["PRODUCT_NAME"],
        chemicalName: json["CHEMICAL_NAME"],
        description: json["DESCRIPTION"],
        price: (json["PRICE"]as num?)?.toInt() ?? 0,
        discount:  (json["DISCOUNT"] as num?)?.toInt() ?? 0,
        discountInPercentage: json["DISCOUNT_IN_PERCENTAGE"]?.toDouble(),
        pcatId: json["PCAT_ID"],
        psubcatId: json["PSUBCAT_ID"],
        langId: json["LANG_ID"],
        productImage: json["PRODUCT_IMAGE"],
        adminId: json["ADMIN_ID"],
        status: statusValues.map[json["STATUS"]]!,
        regDate: DateTime.parse(json["REG_DATE"]),
        productView: json["PRODUCT_VIEW"],
        totalProductReview: json["TOTAL_PRODUCT_REVIEW"],
        size: json["SIZE"],
        unit: json["UNIT"],
    );

    Map<String, dynamic> toJson() => {
        "PRODUCT_ID": productId,
        "PCAT_NAME": pcatName,
        "PSUBCAT_NAME": psubcatName,
        "PRODUCT_NAME": productName,
        "CHEMICAL_NAME": chemicalName,
        "DESCRIPTION": description,
        "PRICE": price,
        "DISCOUNT": discount,
        "DISCOUNT_IN_PERCENTAGE": discountInPercentage,
        "PCAT_ID": pcatId,
        "PSUBCAT_ID": psubcatId,
        "LANG_ID": langId,
        "PRODUCT_IMAGE": productImage,
        "ADMIN_ID": adminId,
        "STATUS": statusValues.reverse[status],
        "REG_DATE": regDate.toIso8601String(),
        "PRODUCT_VIEW": productView,
        "TOTAL_PRODUCT_REVIEW": totalProductReview,
        "SIZE": size,
        "UNIT": unit,
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
