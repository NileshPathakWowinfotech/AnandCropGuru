import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Api/old_schedule_api.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/schedule_view_model.dart';
import 'Schedule_details.dart';

class OldSchedule extends StatefulWidget {
  const OldSchedule({Key? key, required this.item, this.typeSchedule}) : super(key: key);
   final PlotModel item;
   final typeSchedule;

  @override
  State<OldSchedule> createState() => _OldScheduleState();
}

class _OldScheduleState extends State<OldSchedule> {
  SchduleViewModel oldSchduleViewModel = SchduleViewModel();
  @override
  void initState() {
    print(oldSchduleViewModel.typename);
   oldSchduleViewModel.oldScheduleApi(widget.typeSchedule,widget.item.cropId, widget.item.plotId, widget.item.userId);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          Util.backgroundImage,
          fit: BoxFit.cover,
        ),
       leading:  InkWell(
        onTap: (){
          Navigator.pop(context);
        },
         child: Icon(
                  Icons.arrow_back,
                  color: kgrey,
                ),
       ),
        title: InkWell(
          onTap: (){
           
          },
          child: Text(
            'Old Schedule(${widget.typeSchedule})',
            style: TextStyle(
                color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ChangeNotifierProvider<SchduleViewModel>(
                create: (BuildContext context) => oldSchduleViewModel,
                child: Consumer<SchduleViewModel>(builder: (context, value, _) {
                  switch (value.oldScheduleList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.oldScheduleList.message.toString()));
                    case Status.COMPLETED:
                      return value.oldScheduleList.data!.data.isEmpty?Center(child: Text('No Data Found'),):Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Util.backgroundImage))),
                          child: ListView.builder(
                           
                            shrinkWrap: true,
                            itemCount: value.oldScheduleList.data!.data.length,
                            itemBuilder: (context, index) {
                              dynamic item = value.oldScheduleList.data!.data[index];
                              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: InkWell(
                onTap: () {
                  Get.to(ScheduleDetails(scheduleitem: item,type: widget.typeSchedule,
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    ),
                  ], color: kWhite, borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Container(
                          height: 25,
                          color: kgreen,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  value.oldScheduleList.data!.data[index].scheduleDay,
                                  style: TextStyle(
                                      color: kWhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Flexible(
                          child: Row(
                            children: [
                              Text("Title:",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                     value.oldScheduleList.data!.data[index].title,
                                    style: TextStyle(
                                        color: kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Text("Schedule Type:",
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text(
                               value.oldScheduleList.data!.data[index].scheduleType,
                                style: TextStyle(
                                    color: kgreen,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                          ));
                  }
                })));
          }


}