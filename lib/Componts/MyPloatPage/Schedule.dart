import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/schedule_1_details.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/schedule_view_model.dart';
import 'new_schedule(spray).dart';
import 'old_schedule_ferilizer.dart';

class Schedule extends StatefulWidget {
  Schedule({Key? key, required this.item}) : super(key: key);
  final PlotModel item;

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  SchduleViewModel schduleViewModel = SchduleViewModel();

  bool visibility = true;
  bool visibility1 = false;
  bool visibility2 = false;
  String? msg;
  @override
  void initState() {
    schduleViewModel.scheduleApi(
        widget.item.cropId, widget.item.plotId, widget.item.userId);

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
            size: 25,
          ),
        ),
        title: Text(
          "Schedule",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Text("SPRAY",
                                  style: TextStyle(
                                      color:
                                          visibility == true ? kWhite : kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)))),
                    ),
                    onTap: () {
                      setState(() {
                        visibility = true;
                        visibility1 = false;
                        visibility2 = false;
                        print(visibility);
                        schduleViewModel.typename = "Spray";
                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                      });
                    },
                  ),
                  InkWell(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility1 == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Text("FERTILIZER",
                                  style: TextStyle(
                                      color:
                                          visibility1 == true ? kWhite : kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)))),
                    ),
                    onTap: () {
                      setState(() {
                        schduleViewModel.typename = "Fertilizer";
                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                        visibility1 = true;
                        visibility = false;
                        visibility2 = false;
                        // Here you can write your code
                      });
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        schduleViewModel.typename = "Cultivation";

                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                        visibility2 = true;
                        visibility1 = false;
                        visibility = false;
                      });
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility2 == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("CULTIVATION\n    WORKS",
                                style: TextStyle(
                                    color:
                                        visibility2 == true ? kWhite : kgreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ChangeNotifierProvider<SchduleViewModel>(
                create: (BuildContext context) => schduleViewModel,
                child: Consumer<SchduleViewModel>(builder: (context, value, _) {
                  switch (value.scheduleList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.scheduleList.message.toString()));
                    case Status.COMPLETED:
                      return value.scheduleList.data!.data.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: kgreen),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: value.scheduleList.data!
                                                  .responseMessage ==
                                              null
                                          ? Text("")
                                          : Html(
                                              data: value.scheduleList.data!
                                                  .responseMessage)),
                                  InkWell(
                                    onTap: () {
                                      Get.to(ViewOldShedue(
                                        item: widget.item,
                                      ));
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
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Util.backgroundImage))),
                              child: Column(
                                children: [
                                  value.scheduleList.data!.data.isEmpty
                                      ? Text('')
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                schduleViewModel.typename;
                                              });
                                              Get.to(OldSchedule(
                                                item: widget.item,
                                                typeSchedule:
                                                    schduleViewModel.typename,
                                              ));
                                            },
                                            child: Container(
                                              height: 40,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                    "View Previous Schedule",
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        value.scheduleList.data!.data.length,
                                    itemBuilder: (context, index) {
                                      dynamic item =
                                          value.scheduleList.data!.data[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                              Schedule1Details(schedule: item));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          child: Container(
                                            margin: EdgeInsets.all(0.0),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: const Offset(
                                                      2.0,
                                                      2.0,
                                                    ),
                                                    blurRadius: 2.0,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                                color: kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: Container(
                                                    height: 25,
                                                    color: kgreen,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            value
                                                                .scheduleList
                                                                .data!
                                                                .data[index]
                                                                .scheduleDay,
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Row(
                                                    children: [
                                                      Text("Title:",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                            value
                                                                .scheduleList
                                                                .data!
                                                                .data[index]
                                                                .title,
                                                            style: TextStyle(
                                                                color: kgreen,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Row(
                                                    children: [
                                                      Text("Schedule Type:",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          value
                                                              .scheduleList
                                                              .data!
                                                              .data[index]
                                                              .scheduleType,
                                                          style: TextStyle(
                                                              color: kgreen,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_right_alt_sharp,
                                                      size: 28,
                                                      color: Colors.orange,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  value.scheduleList.data!.data.isEmpty
                                      ? Text('')
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(NewSchedule());
                                            },
                                            child: Container(
                                              height: 40,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                    "View Next Schedule",
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ));
                  }
                })),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ViewOldShedue extends StatefulWidget {
  const ViewOldShedue({super.key, required this.item});
  final PlotModel item;

  @override
  State<ViewOldShedue> createState() => _ViewOldShedueState();
}

class _ViewOldShedueState extends State<ViewOldShedue> {
  SchduleViewModel schduleViewModel = SchduleViewModel();

  bool visibility = true;
  bool visibility1 = false;
  bool visibility2 = false;
  String? msg;
  @override
  void initState() {
    schduleViewModel.scheduleApi(
        widget.item.cropId, widget.item.plotId, widget.item.userId);

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
            size: 25,
          ),
        ),
        title: Text(
          "Schedule",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
     body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Text("SPRAY",
                                  style: TextStyle(
                                      color: visibility == true ? kWhite : kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)))),
                    ),
                    onTap: () {
                      setState(() {
                        visibility = true;
                        visibility1 = false;
                        visibility2 = false;
                        print(visibility);
                        schduleViewModel.typename = "Spray";
                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                      });
                    },
                  ),
                  InkWell(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility1 == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Text("FERTILIZER",
                                  style: TextStyle(
                                      color:
                                          visibility1 == true ? kWhite : kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)))),
                    ),
                    onTap: () {
                      setState(() {
                        schduleViewModel.typename = "Fertilizer";
                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                        visibility1 = true;
                        visibility = false;
                        visibility2 = false;
                        // Here you can write your code
                      });
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        schduleViewModel.typename = "Cultivation";
    
                        schduleViewModel.scheduleApi(widget.item.cropId,
                            widget.item.plotId, widget.item.userId);
                        visibility2 = true;
                        visibility1 = false;
                        visibility = false;
                      });
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                          height: 43,
                          width: 90,
                          decoration: BoxDecoration(
                              color: visibility2 == true ? kgreen : kWhite,
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("CULTIVATION\n    WORKS",
                                style: TextStyle(
                                    color: visibility2 == true ? kWhite : kgreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ChangeNotifierProvider<SchduleViewModel>(
                create: (BuildContext context) => schduleViewModel,
                child: Consumer<SchduleViewModel>(builder: (context, value, _) {
                  switch (value.scheduleList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.scheduleList.message.toString()));
                    case Status.COMPLETED:
                      return value.scheduleList.data!.data.isEmpty
                          ?  Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                schduleViewModel.typename;
                                              });
                                              Get.to(OldSchedule(
                                                item: widget.item,
                                                typeSchedule:
                                                    schduleViewModel.typename,
                                              ));
                                            },
                                            child: Container(
                                              height: 40,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                    "View Previous Schedule",
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                          )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Util.backgroundImage))),
                              child: Column(
                                children: [
                                  value.scheduleList.data!.data.isEmpty
                                      ? Text('')
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                schduleViewModel.typename;
                                              });
                                              Get.to(OldSchedule(
                                                item: widget.item,
                                                typeSchedule:
                                                    schduleViewModel.typename,
                                              ));
                                            },
                                            child: Container(
                                              height: 40,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                    "View Previous Schedule",
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        value.scheduleList.data!.data.length,
                                    itemBuilder: (context, index) {
                                      dynamic item =
                                          value.scheduleList.data!.data[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                              Schedule1Details(schedule: item));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          child: Container(
                                            margin: EdgeInsets.all(0.0),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: const Offset(
                                                      2.0,
                                                      2.0,
                                                    ),
                                                    blurRadius: 2.0,
                                                    spreadRadius: 0.0,
                                                  ),
                                                ],
                                                color: kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                  child: Container(
                                                    height: 25,
                                                    color: kgreen,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            value
                                                                .scheduleList
                                                                .data!
                                                                .data[index]
                                                                .scheduleDay,
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Row(
                                                    children: [
                                                      Text("Title:",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                            value
                                                                .scheduleList
                                                                .data!
                                                                .data[index]
                                                                .title,
                                                            style: TextStyle(
                                                                color: kgreen,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 5),
                                                  child: Row(
                                                    children: [
                                                      Text("Schedule Type:",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          value
                                                              .scheduleList
                                                              .data!
                                                              .data[index]
                                                              .scheduleType,
                                                          style: TextStyle(
                                                              color: kgreen,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_right_alt_sharp,
                                                      size: 28,
                                                      color: Colors.orange,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  value.scheduleList.data!.data.isEmpty
                                      ? Text('')
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(NewSchedule());
                                            },
                                            child: Container(
                                              height: 40,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text("View Next Schedule",
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ));
                  }
                })),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
