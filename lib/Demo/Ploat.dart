import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Api/my_plot_api.dart';
import '../Componts/MyPloatPage/my_crop.dart';
import '../Componts/SelectCrop.dart';
import 'package:http/http.dart' as http;

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/home_view_model.dart';
import '../view_model/myplot_view_model.dart';
import 'dropdown.dart';

class Ploat extends StatefulWidget {
  Ploat({Key? key}) : super(key: key);

  @override
  State<Ploat> createState() => _PloatState();
}

class _PloatState extends State<Ploat> with TickerProviderStateMixin {
  MYPlotViewModel myploat = MYPlotViewModel();
  double size = 15;
  double height = 38;
  double width = 104;

  @override
  void initState() {
    myploat.myPloatApi();
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

 Get.to(
            SelecctCrop(),
              transition: Transition.cupertinoDialog,
              duration: Duration(seconds: 1)); 


          // Get.to(MyApiNestedList(),
          //     transition: Transition.cupertinoDialog,
          //     duration: Duration(seconds: 1));
        },
      ),
      body: ChangeNotifierProvider<MYPlotViewModel>(
        create: (BuildContext context) => myploat,
        child: Consumer<MYPlotViewModel>(builder: (context, value, _) {
          switch (value.lablist.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.lablist.message.toString()));
            case Status.COMPLETED:
              return Container(
                decoration: BoxDecoration( 
                   image: DecorationImage(
                    image: AssetImage(Util.backgroundImage)
                   )
                ),
                child: ListView.builder(
                  itemCount: value.lablist.data!.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var profit = value.lablist.data!.data[index].totalIncome - value.lablist.data!.data[index].totalExpences;
                    double expenes =value.lablist.data!.data[index].totalExpences; 
                      double pl = profit;
                      String profitloss = pl.toStringAsFixed(2); // 1.51
                    String number = expenes.toStringAsFixed(2); // 1.51
                    dynamic item = value.lablist.data!.data[index];
                    return InkWell(
                      onTap: () {
                        Get.to(MyCrop(item: item,));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 175,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 22,
                                        color: lgreen,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          margin: EdgeInsets.all(0.0),
                                          height: 22,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Util.newHomeColor,
                                                    Util.endColor
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                              )),
                                          child: Center(
                                              child: Text(
                                            value.lablist.data!.data[index].isPackageExpired                                           .toString(),
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Ploat Name : ",
                                      style: TextStyle(
                                          color: kblack, fontSize: size),
                                    ),
                                    Text(
                                      value.lablist.data!.data[index].plotName,
                                      style: TextStyle(
                                        color: kgreen,
                                        fontSize: size,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Crop name: ",
                                      style: TextStyle(
                                          color: kblack, fontSize: size),
                                    ),
                                    Text(
                                      "   ${value.lablist.data!.data[index].cropName}",
                                      style: TextStyle(
                                        color: kgreen,
                                        fontSize: size,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  children: [
                                    Text(
                                      " Crop Varietty: ",
                                      style: TextStyle(
                                          color: kblack, fontSize: size),
                                    ),
                                    Text(
                                      " ${value.lablist.data!.data[index].vName}",
                                      style: TextStyle(
                                        color: kgreen,
                                        fontSize: size,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          " Pruning date : ",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                          "${value.lablist.data!.data[index].purningDate}",
                                          style: TextStyle(
                                              color: kgreen,
                                              fontSize: size,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_sharp,
                                      size: 30,
                                      color: Colors.orange,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Expanded(
                                      child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                              color: kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 2, color: kgrey)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: height,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: kWhite,
                                                      border: Border(
                                                        right: BorderSide(
                                                          //                   <--- left side
                                                          color: kgrey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("Expenses"),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          number,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: height,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: kWhite,
                                                      border: Border(
                                                        right: BorderSide(
                                                          //                   <--- left side
                                                          color: kgrey,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text("Income"),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          value
                                                              .lablist
                                                              .data!
                                                              .data[index]
                                                              .totalIncome
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        height: height,
                                                        width: width,
                                                        color: kWhite,
                                                        child: Column(
                                                          children: [
                                                            Text("Proffit/Loss"),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              profit > 0
                                                                  ? "+${profitloss.toString()}"
                                                                  : profit
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: profitloss ==
                                                                          0.0
                                                                      ? Colors.red
                                                                      : kgreen),
                                                            ),
                                                          ],
                                                        )))
                                              ]))))
                            ])),
                      ),
                    );
                  },
                ),
              );
          }
          return Container();
        }),
      ),
    );
  }
}
