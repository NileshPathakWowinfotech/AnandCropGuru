

import 'dart:convert';

OneOfferModel oneOfferModelFromJson(String str) => OneOfferModel.fromJson(json.decode(str));

String oneOfferModelToJson(OneOfferModel data) => json.encode(data.toJson());

class OneOfferModel{
    String responseCode;
    String responseMessage;
    dynamic id;
    List<OfferModel> data;
    List<Data1> data1;
    List<Data2> data2;

    OneOfferModel({
        required this.responseCode,
        required this.responseMessage,
        required this.id,
        required this.data,
        required this.data1,
        required this.data2,
    });

    factory OneOfferModel.fromJson(Map<String, dynamic> json) => OneOfferModel(
        responseCode: json["ResponseCode"],
        responseMessage: json["ResponseMessage"],
        id: json["ID"],
        data: List<OfferModel>.from(json["DATA"].map((x) => OfferModel.fromJson(x))),
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

class OfferModel {
    int offerId;
    String offerImage;
    int productId;
    int pCatId;
    int psubcatId;
    String offerTitle;

    OfferModel({
        required this.offerId,
        required this.offerImage,
        required this.productId,
        required this.pCatId,
        required this.psubcatId,
        required this.offerTitle,
    });

    factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offerId: json["OFFER_ID"],
        offerImage: json["OFFER_IMAGE"],
        productId: json["PRODUCT_ID"],
        pCatId: json["P_CAT_ID"],
        psubcatId: json["PSUBCAT_ID"],
        offerTitle: json["OFFER_TITLE"],
    );

    Map<String, dynamic> toJson() => {
        "OFFER_ID": offerId,
        "OFFER_IMAGE": offerImage,
        "PRODUCT_ID": productId,
        "P_CAT_ID": pCatId,
        "PSUBCAT_ID": psubcatId,
        "OFFER_TITLE": offerTitle,
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
