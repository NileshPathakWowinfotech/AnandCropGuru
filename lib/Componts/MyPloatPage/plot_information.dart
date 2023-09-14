import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;

import '../../view_model/myplot_view_model/plotinformation_vie_model.dart';

class PlotInformation extends StatefulWidget {
  PlotInformation({super.key, required this.item});
   final PlotModel item;
  @override
  State<PlotInformation> createState() => _PlotInformationState();
}

class _PlotInformationState extends State<PlotInformation> {
  PlotInformationViewModel plotInformationviewmodel =
      PlotInformationViewModel();
 

  @override
  void initState() {
    plotInformationviewmodel.plotInformationApi(widget.item.userId,widget.item.plotId,'1');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Container(
              child: AppBar(
            flexibleSpace: Image(
                image: AssetImage(Util.backgroundImage), fit: BoxFit.cover),
            elevation: 0,
            backgroundColor: Colors.green,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: kgrey,
              ),
            ),
            title: Text(
              'Question details',
              style: TextStyle(
                  color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                      height: 40,
                      width: 35,
                      child: Image.asset(
                        "assets/images/edit.png",
                        color: kWhite,
                      )),
                ),
              )
            ],
          )),
        ),
        body: ChangeNotifierProvider<PlotInformationViewModel>(
            create: (BuildContext context) => plotInformationviewmodel,
            child: Consumer<PlotInformationViewModel>(
                builder: (context, value, _) {
              switch (value.plotinromeationList.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child:
                          Text(value.plotinromeationList.message.toString()));
                case Status.COMPLETED:
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: kgrey)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Parameter",
                                      style: TextStyle(
                                          color: kgreen,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(height: 45, width: 1, color: kblack),
                                Expanded(
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Values",
                                      style: TextStyle(
                                          color: kgreen,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                value.plotinromeationList.data!.data.length,
                            itemBuilder: (context, index) {
                              dynamic item =
                                  value.plotinromeationList.data!.data[index];
                              return Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: kblack)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            value.plotinromeationList.data!
                                                .data[index].parameter,
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                              ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                       
                                          width: 1,
                                          color: kblack),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            maxLines:2,
                                            value.plotinromeationList.data!
                                                .data[index].value,
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                               ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
              }
            }
            )
            )
            );
  }
}

