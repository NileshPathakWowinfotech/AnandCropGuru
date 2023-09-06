import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../view_model/myplot_view_model/diary_view_model.dart';
import '../../view_model/myplot_view_model/faq_view_model.dart';
import 'add_diary_from.dart';
import 'diarysubdetils.dart';

class DiaryDetails extends StatefulWidget {
  const DiaryDetails({super.key, required this.item});
  final PlotModel item;

  @override
  State<DiaryDetails> createState() => _DiaryDetailsState();
}

class _DiaryDetailsState extends State<DiaryDetails> {
 DiaryDetailsViewModel detailsViewModel = DiaryDetailsViewModel();

  @override
  void initState() {
    detailsViewModel.diaryDetailsApi(widget.item.userId,widget.item.plotId,widget.item.cropId);
    // TODO: implement initState
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
              )),
          title: Text(
            'Diary',
            style: TextStyle(
                color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: ChangeNotifierProvider<DiaryDetailsViewModel>(
            create: (BuildContext context) => detailsViewModel,
            child: Consumer<DiaryDetailsViewModel>(builder: (context, value, _) {
              switch (value.plotinromeationList.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.plotinromeationList.message.toString()));
                case Status.COMPLETED:
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Util.backgroundImage))),
                      child:value.plotinromeationList.data!.data.isEmpty?Center(
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
                                        child: value.plotinromeationList.data!
                                                    .responseMessage ==
                                                null
                                            ? Text("")
                                            : Html(
                                                data: value.plotinromeationList.data!
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
                        
                        itemCount: value.plotinromeationList.data!.data.length,
                     
                      
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                             dynamic item = value.plotinromeationList.data!.data[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(DiarySubDetails(item:item));
                                    },
                                    child: Container(
                                     width: MediaQuery.of(context).size.width- 17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(3.0),
                                              height: 25,
                                             
                                              color: lgreen,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Title : ${value.plotinromeationList.data!.data[index].udTitle}',
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Date : ',
                                                  style: TextStyle(
                                                      color: kgrey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                 value.plotinromeationList.data!.data[index].regDate,
                                                  style: TextStyle(
                                                      color: kgrey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              value.plotinromeationList.data!.data[index].udDesc,
                                              style: TextStyle(
                                                  color: kgrey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ));
              }
            })),
        floatingActionButton: Container(
          height: 70.0,
          width: 90.0,
          child: FittedBox(
              child: FloatingActionButton(
                  backgroundColor: Colors.orange,
                  child: Text("Add Diary",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Get.to(AddDiaryFrom(item: widget.item,));
                    //Get.to(AddYourQuestion());
                  })),
        ));
  }
}
