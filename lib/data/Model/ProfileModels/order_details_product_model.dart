///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
class OrderDetailsProductModelDATA2 {
/*
{
  "TABLE2": 1
} 
*/

  String? TABLE2;

  OrderDetailsProductModelDATA2({
    this.TABLE2,
  });
  OrderDetailsProductModelDATA2.fromJson(Map<String, dynamic> json) {
    TABLE2 = json['TABLE2']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TABLE2'] = TABLE2;
    return data;
  }
}

class OrderDetailsProductModelDATA1 {
/*
{
  "TABLE1": 1
} 
*/

  String? TABLE1;

  OrderDetailsProductModelDATA1({
    this.TABLE1,
  });
  OrderDetailsProductModelDATA1.fromJson(Map<String, dynamic> json) {
    TABLE1 = json['TABLE1']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TABLE1'] = TABLE1;
    return data;
  }
}

class OrderDetailsProductModelDATA {
/*
{
  "OD_ID": 20318,
  "ORDER_ID": 20297,
  "PRODUCT_ID": 16,
  "PRODUCT_NAME": "डॉ. बॅक्टोज व्ही.बी.एम. 5G",
  "PS_ID": 220,
  "UNIT": "piece",
  "PRICE": 1050,
  "DISCOUNT": 214,
  "QTY": 4,
  "STATUS": "Active",
  "REG_DATE": "25 Jul 2023"
} 
*/

  String? OD_ID;
  String? ORDER_ID;
  String? PRODUCT_ID;
  String? PRODUCT_NAME;
  String? PS_ID;
  String? UNIT;
  String? PRICE;
  String? DISCOUNT;
  String? QTY;
  String? STATUS;
  String? REG_DATE;

  OrderDetailsProductModelDATA({
    this.OD_ID,
    this.ORDER_ID,
    this.PRODUCT_ID,
    this.PRODUCT_NAME,
    this.PS_ID,
    this.UNIT,
    this.PRICE,
    this.DISCOUNT,
    this.QTY,
    this.STATUS,
    this.REG_DATE,
  });
  OrderDetailsProductModelDATA.fromJson(Map<String, dynamic> json) {
    OD_ID = json['OD_ID']?.toString();
    ORDER_ID = json['ORDER_ID']?.toString();
    PRODUCT_ID = json['PRODUCT_ID']?.toString();
    PRODUCT_NAME = json['PRODUCT_NAME']?.toString();
    PS_ID = json['PS_ID']?.toString();
    UNIT = json['UNIT']?.toString();
    PRICE = json['PRICE']?.toString();
    DISCOUNT = json['DISCOUNT']?.toString();
    QTY = json['QTY']?.toString();
    STATUS = json['STATUS']?.toString();
    REG_DATE = json['REG_DATE']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['OD_ID'] = OD_ID;
    data['ORDER_ID'] = ORDER_ID;
    data['PRODUCT_ID'] = PRODUCT_ID;
    data['PRODUCT_NAME'] = PRODUCT_NAME;
    data['PS_ID'] = PS_ID;
    data['UNIT'] = UNIT;
    data['PRICE'] = PRICE;
    data['DISCOUNT'] = DISCOUNT;
    data['QTY'] = QTY;
    data['STATUS'] = STATUS;
    data['REG_DATE'] = REG_DATE;
    return data;
  }
}

class OrderDetailsProductModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "Get_OrderDetails List",
  "ID": null,
  "DATA": [
    {
      "OD_ID": 20318,
      "ORDER_ID": 20297,
      "PRODUCT_ID": 16,
      "PRODUCT_NAME": "डॉ. बॅक्टोज व्ही.बी.एम. 5G",
      "PS_ID": 220,
      "UNIT": "piece",
      "PRICE": 1050,
      "DISCOUNT": 214,
      "QTY": 4,
      "STATUS": "Active",
      "REG_DATE": "25 Jul 2023"
    }
  ],
  "DATA1": [
    {
      "TABLE1": 1
    }
  ],
  "DATA2": [
    {
      "TABLE2": 1
    }
  ]
} 
*/

  String? ResponseCode;
  String? ResponseMessage;
  String? ID;
  List<OrderDetailsProductModelDATA?>? DATA;
  List<OrderDetailsProductModelDATA1?>? DATA1;
  List<OrderDetailsProductModelDATA2?>? DATA2;

  OrderDetailsProductModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.ID,
    this.DATA,
    this.DATA1,
    this.DATA2,
  });
  OrderDetailsProductModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json['ResponseCode']?.toString();
    ResponseMessage = json['ResponseMessage']?.toString();
    ID = json['ID']?.toString();
  if (json['DATA'] != null) {
  final v = json['DATA'];
  final arr0 = <OrderDetailsProductModelDATA>[];
  v.forEach((v) {
  arr0.add(OrderDetailsProductModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json['DATA1'] != null) {
  final v = json['DATA1'];
  final arr0 = <OrderDetailsProductModelDATA1>[];
  v.forEach((v) {
  arr0.add(OrderDetailsProductModelDATA1.fromJson(v));
  });
    DATA1 = arr0;
    }
  if (json['DATA2'] != null) {
  final v = json['DATA2'];
  final arr0 = <OrderDetailsProductModelDATA2>[];
  v.forEach((v) {
  arr0.add(OrderDetailsProductModelDATA2.fromJson(v));
  });
    DATA2 = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ResponseCode'] = ResponseCode;
    data['ResponseMessage'] = ResponseMessage;
    data['ID'] = ID;
    if (DATA != null) {
      final v = DATA;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['DATA'] = arr0;
    }
    if (DATA1 != null) {
      final v = DATA1;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['DATA1'] = arr0;
    }
    if (DATA2 != null) {
      final v = DATA2;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['DATA2'] = arr0;
    }
    return data;
  }
}