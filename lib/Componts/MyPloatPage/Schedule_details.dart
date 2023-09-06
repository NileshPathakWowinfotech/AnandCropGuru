
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../data/Model/MyPlotModel.dart/Schedule/Schedule_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class ScheduleDetails extends StatelessWidget {
  const ScheduleDetails(
      {Key? key,required this.scheduleitem, this.type})
      : super(key: key);

 final Schedule scheduleitem;
 final type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
        flexibleSpace:Image.asset(Util.backgroundImage,fit: BoxFit.cover,),
      
       
           leading:  InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: kgrey,
              ),
            ),
            
          
        title: Text(
          'Old Schedule(${type})',
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),),
    ),
    
        
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(8),
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
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        height: 25,
                        color: kgreen,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(scheduleitem.scheduleDay,
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Title:",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text("  ${scheduleitem.title}",
                                    style: TextStyle(
                                        color: kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Schedule Type :",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Text(" ${scheduleitem.scheduleType}",
                                  style: TextStyle(
                                      color: kgreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Image.network(scheduleitem.scheduleImage, height: 200,
                                  errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/noimage.png",
                              height: 200,
                            );
                          })),
                          SizedBox(
                            height: 20,
                          ),

                          Html(
                              data:scheduleitem.schedule),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                         // Get.to(AddToDiary());
                        },
                        child: Container(
                          height: 40,
                          color: Colors.orange,
                          child: Center(
                            child: Text("ADD TO DIARY",
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
