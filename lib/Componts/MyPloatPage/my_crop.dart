import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/plot_information.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/question_answer_list.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/report_master.dart';
import 'package:get/get.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'diary.dart';
import 'diary_details.dart';
import 'faq.dart';
import 'faq_new.dart';

class MyCrop extends StatelessWidget {
  MyCrop({
    Key? key,
    required this.item,
  });
  final PlotModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage(Util.backgroundImage),
            fit: BoxFit.cover,
          ),
          elevation: 0,
          backgroundColor: Colors.green,
          leading: Builder(
            builder: (context) => IconButton(
              icon: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: kblack,
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          title: Text(
            item.cropName,
            style: TextStyle(
                color: kblack, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kblack,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Util.backgroundImage))),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kblack,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage("assets/images/my_plot_banner.png"))),
                ),
              ),
              SizedBox(height: 10,),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //   Get.to(Schedule(userId: userId,cropId: cropId, plotId:plotId ,));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/timetable.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Schedule",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 1,
                        height: 100,
                        color: Colors.white), // This is divider
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(QuestionAnswer( item: item,
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/timetable.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Ask Question",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                color: kWhite,
              ),

                 SizedBox(height: 18,),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                       
                           Get.to(Faq(item: item,));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/faq1.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "FAQ",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 1,
                        height: 100,
                        color: Colors.white), // This is divider
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          //  Get.to(AgronomistVisits(userID: userId,cropId: cropId, plotID:plotId));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/agrovisit.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "My plot visits",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                color: kWhite,
              ),
            
                
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                             Get.to(Diary(userId: item.userId,cropID: item.cropId, plotID: item.plotId));
                        },
                        child: Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 41,
                                backgroundColor: kblack,
                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: kWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Center(
                                          child: Image.asset(
                                        "assets/images/mdiary.png",
                                        height: 50,
                                        color: kgreen,
                                      )),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Diary",
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 1,
                        height: 100,
                        color: Colors.white), // This is divider
                    Expanded(
                      child: InkWell(
                        onTap: () {
                           Get.to(ReportMaster(item: item,));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/mobservation.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Soil, Water and Petiole\n         Testing Report",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
              Container(
                height: 1,
                color: kWhite,
              ),
                   SizedBox(height: 18,),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(PlotInformation(item: item,));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/info.png",
                                      height: 50,
                                      color: kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Plot information",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),

                      Expanded(
                      child: InkWell(
                        onTap: () {
                         
                             Get.to( DiaryDetails(item: item,));
                       //   Get.to(NRC(userid: userId,cropId: cropId, plotId:plotId));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/info.png",
                                      height: 50,
                                      color:kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Diary details",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: 1,
                        height: 100,
                        color: Colors.white), // This is divider
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Get.to(NRC(userid: userId,cropId: cropId, plotId:plotId));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 41,
                              backgroundColor: kblack,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: kWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Image.asset(
                                      "assets/images/myplot.png",
                                      height: 50,
                                      color:kgreen,
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Update plot",
                              style: TextStyle(
                                  color: kgreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),

                    
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
