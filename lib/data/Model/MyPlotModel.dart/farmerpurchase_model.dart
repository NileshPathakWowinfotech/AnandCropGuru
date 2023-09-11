///
/// Code generated by Sita Web Tool https://sita.app/json-to-dart/
///
class FarmerPurchaseModelDATA1 {
/*
{
  "Column1": 1
} 
*/

  String? Column1;

  FarmerPurchaseModelDATA1({
    this.Column1,
  });
  FarmerPurchaseModelDATA1.fromJson(Map<String, dynamic> json) {
    Column1 = json['Column1']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Column1'] = Column1;
    return data;
  }
}

class FarmerPurchaseModelDATA {
/*
{
  "Row": 1,
  "CAT_ID": 33,
  "CAT_NAME": "Fertilizer",
  "PRODUCT_ID": 250,
  "PRODUCT_NAME": "Fert",
  "UNIT_NAME": "gram",
  "SIZE": "500",
  "PRICE": 885,
  "QUANTITY": 5,
  "PURCHASE_DATE": "09/09/2023",
  "PURCHASE_DATE_EDIT": "2023-09-09T00:00:00",
  "BILL_PHORO": "http://mycropguruapiwow.cropguru.in/Images/BILL_PHOTO7590828575.jpg",
  "STATUS": "Active",
  "FP_ID": 269,
  "UNIT_ID": 4,
  "REG_DATE": "09/09/2023",
  "REMARK": "ghh",
  "UNIT_GROUP_NAME": "KG",
  "AVL_STOCK": 7.975
} 
*/

  String? Row;
  String? CAT_ID;
  String? CAT_NAME;
  String? PRODUCT_ID;
  String? PRODUCT_NAME;
  String? UNIT_NAME;
  String? SIZE;
  String? PRICE;
  String? QUANTITY;
  String? PURCHASE_DATE;
  String? PURCHASE_DATE_EDIT;
  String? BILL_PHORO;
  String? STATUS;
  String? FP_ID;
  String? UNIT_ID;
  String? REG_DATE;
  String? REMARK;
  String? UNIT_GROUP_NAME;
  String? AVL_STOCK;

  FarmerPurchaseModelDATA({
    this.Row,
    this.CAT_ID,
    this.CAT_NAME,
    this.PRODUCT_ID,
    this.PRODUCT_NAME,
    this.UNIT_NAME,
    this.SIZE,
    this.PRICE,
    this.QUANTITY,
    this.PURCHASE_DATE,
    this.PURCHASE_DATE_EDIT,
    this.BILL_PHORO,
    this.STATUS,
    this.FP_ID,
    this.UNIT_ID,
    this.REG_DATE,
    this.REMARK,
    this.UNIT_GROUP_NAME,
    this.AVL_STOCK,
  });
  FarmerPurchaseModelDATA.fromJson(Map<String, dynamic> json) {
    Row = json['Row']?.toString();
    CAT_ID = json['CAT_ID']?.toString();
    CAT_NAME = json['CAT_NAME']?.toString();
    PRODUCT_ID = json['PRODUCT_ID']?.toString();
    PRODUCT_NAME = json['PRODUCT_NAME']?.toString();
    UNIT_NAME = json['UNIT_NAME']?.toString();
    SIZE = json['SIZE']?.toString();
    PRICE = json['PRICE']?.toString();
    QUANTITY = json['QUANTITY']?.toString();
    PURCHASE_DATE = json['PURCHASE_DATE']?.toString();
    PURCHASE_DATE_EDIT = json['PURCHASE_DATE_EDIT']?.toString();
    BILL_PHORO = json['BILL_PHORO']?.toString();
    STATUS = json['STATUS']?.toString();
    FP_ID = json['FP_ID']?.toString();
    UNIT_ID = json['UNIT_ID']?.toString();
    REG_DATE = json['REG_DATE']?.toString();
    REMARK = json['REMARK']?.toString();
    UNIT_GROUP_NAME = json['UNIT_GROUP_NAME']?.toString();
    AVL_STOCK = json['AVL_STOCK']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Row'] = Row;
    data['CAT_ID'] = CAT_ID;
    data['CAT_NAME'] = CAT_NAME;
    data['PRODUCT_ID'] = PRODUCT_ID;
    data['PRODUCT_NAME'] = PRODUCT_NAME;
    data['UNIT_NAME'] = UNIT_NAME;
    data['SIZE'] = SIZE;
    data['PRICE'] = PRICE;
    data['QUANTITY'] = QUANTITY;
    data['PURCHASE_DATE'] = PURCHASE_DATE;
    data['PURCHASE_DATE_EDIT'] = PURCHASE_DATE_EDIT;
    data['BILL_PHORO'] = BILL_PHORO;
    data['STATUS'] = STATUS;
    data['FP_ID'] = FP_ID;
    data['UNIT_ID'] = UNIT_ID;
    data['REG_DATE'] = REG_DATE;
    data['REMARK'] = REMARK;
    data['UNIT_GROUP_NAME'] = UNIT_GROUP_NAME;
    data['AVL_STOCK'] = AVL_STOCK;
    return data;
  }
}

class FarmerPurchaseModel {
/*
{
  "ResponseCode": "0",
  "ResponseMessage": "Product Purchase List",
  "ID": null,
  "DATA": [
    {
      "Row": 1,
      "CAT_ID": 33,
      "CAT_NAME": "Fertilizer",
      "PRODUCT_ID": 250,
      "PRODUCT_NAME": "Fert",
      "UNIT_NAME": "gram",
      "SIZE": "500",
      "PRICE": 885,
      "QUANTITY": 5,
      "PURCHASE_DATE": "09/09/2023",
      "PURCHASE_DATE_EDIT": "2023-09-09T00:00:00",
      "BILL_PHORO": "http://mycropguruapiwow.cropguru.in/Images/BILL_PHOTO7590828575.jpg",
      "STATUS": "Active",
      "FP_ID": 269,
      "UNIT_ID": 4,
      "REG_DATE": "09/09/2023",
      "REMARK": "ghh",
      "UNIT_GROUP_NAME": "KG",
      "AVL_STOCK": 7.975
    }
  ],
  "DATA1": [
    {
      "Column1": 1
    }
  ],
  "DATA2": null
} 
*/

  String? ResponseCode;
  String? ResponseMessage;
  String? ID;
  List<FarmerPurchaseModelDATA?>? DATA;
  List<FarmerPurchaseModelDATA1?>? DATA1;
  String? DATA2;

  FarmerPurchaseModel({
    this.ResponseCode,
    this.ResponseMessage,
    this.ID,
    this.DATA,
    this.DATA1,
    this.DATA2,
  });
  FarmerPurchaseModel.fromJson(Map<String, dynamic> json) {
    ResponseCode = json['ResponseCode']?.toString();
    ResponseMessage = json['ResponseMessage']?.toString();
    ID = json['ID']?.toString();
  if (json['DATA'] != null) {
  final v = json['DATA'];
  final arr0 = <FarmerPurchaseModelDATA>[];
  v.forEach((v) {
  arr0.add(FarmerPurchaseModelDATA.fromJson(v));
  });
    DATA = arr0;
    }
  if (json['DATA1'] != null) {
  final v = json['DATA1'];
  final arr0 = <FarmerPurchaseModelDATA1>[];
  v.forEach((v) {
  arr0.add(FarmerPurchaseModelDATA1.fromJson(v));
  });
    DATA1 = arr0;
    }
    DATA2 = json['DATA2']?.toString();
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
    data['DATA2'] = DATA2;
    return data;
  }
}
