// To parse this JSON data, do
//
//     final totalExpensesModel = totalExpensesModelFromJson(jsonString);

import 'dart:convert';

TotalExpensesModel totalExpensesModelFromJson(String str) => TotalExpensesModel.fromJson(json.decode(str));

String totalExpensesModelToJson(TotalExpensesModel data) => json.encode(data.toJson());

class TotalExpensesModel {
    String responseCode;
    String responseMessage;
    dynamic id;
    List<TotalExpanse> data;
    List<Data1> data1;
    dynamic data2;

    TotalExpensesModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory TotalExpensesModel.fromJson(Map<String, dynamic> json) => TotalExpensesModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<TotalExpanse>.from(json["DATA"].map((x) => TotalExpanse.fromJson(x))),
        data1: List<Data1>.from(json["DATA1"].map((x) => Data1.fromJson(x))),
        data2: json["DATA2"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseMessage": responseMessage,
        "ID": id,
        "DATA": List<dynamic>.from(data.map((x) => x.toJson())),
        "DATA1": List<dynamic>.from(data1.map((x) => x.toJson())),
        "DATA2": data2,
    };
}

class TotalExpanse {
    int row;
    int catId;
    CatName catName;
    int productId;
    ProductName productName;
    UnitName unitName;
    dynamic size;
    double price;
    int quantity;
    ExpenceDate expenceDate;
    DateTime expenceDateEdit;
    Status status;
    int expId;
    dynamic expenceTime;
    String regDate;
    Remark remark;
    dynamic water;
    dynamic noOfDays;
    double totalExpence;

    TotalExpanse({
        required this.row,
        required this.catId,
        required this.catName,
        required this.productId,
        required this.productName,
        required this.unitName,
        required this.size,
        required this.price,
        required this.quantity,
        required this.expenceDate,
        required this.expenceDateEdit,
        required this.status,
        required this.expId,
        required this.expenceTime,
        required this.regDate,
        required this.remark,
        required this.water,
        required this.noOfDays,
        required this.totalExpence,
    });

    factory TotalExpanse.fromJson(Map<String, dynamic> json) => TotalExpanse(
        row: json["Row"],
        catId: json["CAT_ID"],
        catName: catNameValues.map[json["CAT_NAME"]]!,
        productId: json["PRODUCT_ID"],
        productName: productNameValues.map[json["PRODUCT_NAME"]]!,
        unitName: unitNameValues.map[json["UNIT_NAME"]]!,
        size: json["SIZE"],
        price:( json["PRICE"]as num?)?.toDouble() ?? 0,
        quantity:( json["QUANTITY"]as num?)?.toInt() ?? 0,
        expenceDate: expenceDateValues.map[json["EXPENCE_DATE"]]!,
        expenceDateEdit: DateTime.parse(json["EXPENCE_DATE_EDIT"]),
        status: statusValues.map[json["STATUS"]]!,
        expId: json["EXP_ID"],
        expenceTime: json["EXPENCE_TIME"],
        regDate: json["REG_DATE"],
        remark: remarkValues.map[json["REMARK"]]!,
        water: json["WATER"],
        noOfDays: json["NO_OF_DAYS"],
        totalExpence:( json["TOTAL_EXPENCE"]as num?)?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "Row": row,
        "CAT_ID": catId,
        "CAT_NAME": catNameValues.reverse[catName],
        "PRODUCT_ID": productId,
        "PRODUCT_NAME": productNameValues.reverse[productName],
        "UNIT_NAME": unitNameValues.reverse[unitName],
        "SIZE": size,
        "PRICE": price,
        "QUANTITY": quantity,
        "EXPENCE_DATE": expenceDateValues.reverse[expenceDate],
        "EXPENCE_DATE_EDIT": expenceDateEdit.toIso8601String(),
        "STATUS": statusValues.reverse[status],
        "EXP_ID": expId,
        "EXPENCE_TIME": expenceTime,
        "REG_DATE": regDate,
        "REMARK": remarkValues.reverse[remark],
        "WATER": water,
        "NO_OF_DAYS": noOfDays,
        "TOTAL_EXPENCE": totalExpence,
    };
}

enum CatName {
    FERTILIZER
}

final catNameValues = EnumValues({
    "Fertilizer": CatName.FERTILIZER
});

enum ExpenceDate {
    THE_23022023
}

final expenceDateValues = EnumValues({
    "23/02/2023": ExpenceDate.THE_23022023
});

enum ProductName {
    M45
}

final productNameValues = EnumValues({
    "M45": ProductName.M45
});

enum Remark {
    TESYJVJVJV_EXPERIENCE
}

final remarkValues = EnumValues({
    "tesyjvjvjv experience": Remark.TESYJVJVJV_EXPERIENCE
});

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE
});

enum UnitName {
    ML
}

final unitNameValues = EnumValues({
    "ml": UnitName.ML
});

class Data1 {
    int column1;

    Data1({
        required this.column1,
    });

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        column1: json["Column1"],
    );

    Map<String, dynamic> toJson() => {
        "Column1": column1,
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
