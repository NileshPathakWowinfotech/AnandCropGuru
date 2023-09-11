import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/myplot_view_model/purchase_view_model.dart';
import 'MyPloatPage/add_purchase.dart';
import 'MyPloatPage/full_size_image.dart';

class Purchase extends StatefulWidget {
  Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> with TickerProviderStateMixin {
  double size = 14;
  double Fromsize = 15;
  late Map mapresponse;
  List? listresponse;
  var jsonResponse;
  String? msg;
  String? data;
  PurchaseViewModel purchaseViewModel = PurchaseViewModel();

  late AnimationController _controller;


  @override
  void initState() {
  purchaseViewModel.questionAnswerListView(); 
   // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
           Get.to(AddPurchases(),transition: Transition.cupertinoDialog ,duration: Duration(seconds: 1));
        },
      ),
      body: ChangeNotifierProvider<PurchaseViewModel>(
        create: (BuildContext context) => purchaseViewModel,
        child: Consumer<PurchaseViewModel>(builder: (context, value, _) {
          switch (value.purchaseList.status!) {
            case Status.LOADING:
              return Center(child:CircularProgressIndicator());
            case Status.ERROR:
              return Center(child:Text(value.purchaseList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: ListView.builder(
                      itemCount: value.purchaseList.data!.DATA!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final imagelist =
                            value.purchaseList.data!.DATA![index]!.BILL_PHORO;
                        final purchasedate =
                            value.purchaseList.data!.DATA![index]!.PURCHASE_DATE;
                        final remark =
                            value.purchaseList.data!.DATA![index]!.REMARK; 
                            dynamic  total =  double.parse(value.purchaseList.data!.DATA![index]!.PRICE.toString()) * double.parse(value.purchaseList.data!.DATA![index]!.QUANTITY.toString());

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: InkWell(
                            onTap: () {
                              showDialog<void>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 15
                                                  : 100,
                                              vertical: 15),
                                          child: new Container(
                                            decoration: BoxDecoration(
                                                color: kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: double.infinity,
                                                    color: pgreen,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            "",
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          Center(
                                                              child: Text(
                                                            "Product Details",
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                  Icons.cancel,
                                                                  size: 25,
                                                                  color: kWhite,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Product Name",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextfildForms(
                                                  name: value.purchaseList.data!
                                                      .DATA![index]!.PRODUCT_NAME,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Category Name",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextfildForms(
                                                  name: value.purchaseList.data!
                                                      .DATA![index]!.CAT_NAME,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Paking",
                                                        style: TextStyle(
                                                            color: kblack,
                                                            fontSize: Fromsize),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 120),
                                                        child: Text(
                                                          "Unit",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .SIZE.toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .UNIT_NAME.toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Price(Rs)",
                                                        style: TextStyle(
                                                            color: kblue,
                                                            fontSize: Fromsize),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 100),
                                                        child: Text(
                                                          "Quantity",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!.PRICE
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .QUANTITY.toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Purchase Date",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: pgrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Text(
                                                              purchasedate.toString(),
                                                              style: TextStyle(
                                                                  color: kblack,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: Util
                                                                .newHomeColor,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: imagelist == ""
                                                      ? Text("")
                                                      : Text(
                                                          "Bill photo",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: imagelist == ""
                                                        ? Text("")
                                                        : Material(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.to(FullSizeImage(
                                                                    image:
                                                                        imagelist));
                                                              },
                                                              child: Material(
                                                                child: Container(
                                                                    alignment: Alignment.center,
                                                                    height: 150,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          kWhite,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child: value.purchaseList.data!.DATA![index]!.BILL_PHORO.toString() == " "
                                                                        ? Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt_sharp,
                                                                              color: lgreen,
                                                                              size: 30,
                                                                            ),
                                                                          )
                                                                        : Stack(
                                                                            children: [
                                                                              Image.network(
                                                                                fit: BoxFit.fill,
                                                                                height: 200,
                                                                                width: MediaQuery.of(context).size.width,
                                                                                value.purchaseList.data!.DATA![index]!.BILL_PHORO.toString(),
                                                                                errorBuilder: (context, error, stackTrace) {
                                                                                  return Center(
                                                                                      child: Image.asset(
                                                                                    "assets/images/noimage.png",
                                                                                    height: 200,
                                                                                  ));
                                                                                },
                                                                              ),
                                                                              Center(
                                                                                child: Icon(Icons.camera_alt, size: 28, color: kgreen),
                                                                              )
                                                                            ],
                                                                          )),
                                                              ),
                                                            ),
                                                          )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Remark",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: pgrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            value
                                                                        .purchaseList
                                                                        .data!
                                                                        .DATA![
                                                                            index]!
                                                                        .REMARK ==
                                                                    null
                                                                ? ""
                                                                : remark.toString(),
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      // offset: const Offset(3.0, 3.0),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      color: kgrey),
                                ],
                                color: kWhite,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Product Name -",
                                              style: TextStyle(
                                                  color: kgrey, fontSize: size),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              value.purchaseList.data!
                                                  .DATA![index]!.PRODUCT_NAME.toString(),
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: size),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt_rounded,
                                          size: 30,
                                          color: kgreen,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Packing -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.SIZE.toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Unit -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.UNIT_NAME.toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Quantity -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.QUANTITY
                                                    .toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Price(Rs) -",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                          "${value.purchaseList.data!
                                                    .DATA![index]!.PRICE
                                                    .toString()} x ${value.purchaseList.data!
                                                    .DATA![index]!.QUANTITY
                                                    .toString()} ",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                          "Total ₹",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                           total.toString(),
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Available Stock - ",
                                          style: TextStyle(
                                              color: kgreen, fontSize: size),
                                        ),
                                        Text(
                                          value.purchaseList.data!.DATA![index]!
                                              .AVL_STOCK.toString()
                                              .toString(),
                                          style: TextStyle(
                                              color: kgreen, fontSize: size),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Remark - ",
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: size),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  value.purchaseList.data!
                                                              .DATA![index]!.REMARK ==
                                                          null
                                                      ? ""
                                                      : value.purchaseList.data!
                                                          .DATA![index]!.REMARK
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: kgrey, fontSize: size),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor:kgreen,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: kWhite,
                                              size: 17,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      )
                      );
          }
          return Container();
        }),
      ),
    );
  }
}

class TextfildForms extends StatelessWidget {
  TextfildForms({Key? key, this.name}) : super(key: key);
  final name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: pgrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                name,
                style: TextStyle(color: kblack, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
