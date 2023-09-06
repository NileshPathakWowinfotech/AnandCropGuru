import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Demo/cutomDropDown.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;
import '../../view_model/myplot_view_model/reportmaster_view_model.dart';
import 'add_Report.dart';
import 'master_details.dart';

class ReportMaster extends StatefulWidget {
  ReportMaster({Key? key, required this.item}) : super(key: key);

  final PlotModel item;

  @override
  State<ReportMaster> createState() => _ReportMasterState();
}

class _ReportMasterState extends State<ReportMaster>
    with TickerProviderStateMixin {
  ReportMasterViewModel reportMasterView = ReportMasterViewModel();
  @override
  void initState() {
    reportMasterView.reportMasterListView(
        widget.item.userId, widget.item.plotId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kgrey,
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Text(
            'Report Master',
            style: TextStyle(
                color: kgrey, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ChangeNotifierProvider<ReportMasterViewModel>(
          create: (BuildContext context) => reportMasterView,
          child: Consumer<ReportMasterViewModel>(builder: (context, value, _) {
            switch (value.reportMasterList.status!) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.reportMasterList.message.toString()));
              case Status.COMPLETED:
                return Container(
                  width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Util.backgroundImage))),
                    child:value.reportMasterList.data!.data.isEmpty?Center(
                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(width: 1, color: kgreen),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: value.reportMasterList.data!
                                                    .responseMessage ==
                                                null
                                            ? Text("")
                                            : Html(
                                                data: value.reportMasterList.data!
                                                    .responseMessage)),
                                    InkWell(
                                      onTap: () {
                                        // Get.to(ViewOldShedue(
                                        //   item: widget.item,
                                        // ));
                                      },
                                      child: Container(
                                        height: 40,
                                        color: kgreen,
                                        child: Center(
                                          child: Text("Ok",
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                ): ListView.builder(
                      itemCount: value.reportMasterList.data!.data.length,
                      itemBuilder: (context, index) {
                        dynamic item =value.reportMasterList.data!.data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: InkWell(
                            onTap: () {
                                Get.to(MyHomePage());
                           //   
                            //  Get.to(MasterDetails(item: item,));
                            },
                            child: Material(
                              elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                              child: Container(
                                
                                decoration: BoxDecoration(  
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          value.reportMasterList.data!.data[index].reportType,
                                          style: TextStyle(
                                              color: kblack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          maxLines: 2,
                                          value.reportMasterList.data!.data[index].reportDesc,
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 14,
                                          )),
                                      Center(
                                          child: Image.network(
                                         value.reportMasterList.data!.data[index].reportImg,
                                        height: 250,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container();
                                        },
                                      )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                               value.reportMasterList.data!.data[index].regDate,
                                              style: TextStyle(
                                                color: kgrey,
                                                fontSize: 16,
                                              )),
                                          Icon(
                                            Icons.arrow_right_alt_sharp,
                                            size: 30,
                                            color: kdarkred,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ));
            }
          })),
      floatingActionButton:  Container(
              height: 70.0,
              width: 90.0,
              child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Text("AddReport",
                        style: TextStyle(
                            fontSize: 9, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Get.to(Add_Report(item: widget.item));
                      //Get.to(AddYourQuestion());
                    }),
              ),
            ),
    );
  }
}




//  Column(
//               children: [
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 25,
//                   ),
//                   child: Material(
//                     elevation: 1.0,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height - 230,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(5.0),
//                           topRight: Radius.circular(5),
//                           bottomLeft: Radius.zero,
//                           bottomRight: Radius.zero,
//                         ),
//                       ),
//                       child: Html(data: Firstpage),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 25,
//                   ),
//                   child: Material(
//                     elevation: 1.0,
//                     child: InkWell(
//                       onTap: () {
//                         Get.to(Add_Report());
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: kgreen,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.zero,
//                               topRight: Radius.zero,
//                               bottomLeft: Radius.circular(5),
//                               bottomRight: Radius.circular(5),
//                             )),
//                         child: Text(
//                           'Ok',
//                           style: TextStyle(
//                               color: kWhite,
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )