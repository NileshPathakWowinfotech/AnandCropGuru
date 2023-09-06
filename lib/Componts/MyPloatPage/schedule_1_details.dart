


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../data/Model/MyPlotModel.dart/Schedule/Schedule_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Schedule1Details extends StatelessWidget {
  const Schedule1Details({Key? key, required this.schedule, }) : super(key: key);
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
            flexibleSpace: Image.asset(Util.backgroundImage,fit: BoxFit.cover,),
            
            
            elevation: 0,
            backgroundColor: Colors.green,
            leading: InkWell(
              onTap: (){
              Navigator.pop(context);
              },
              child: Icon( Icons.arrow_back,
                      color: kgrey,),
            ),
              
            title: Text('Schedule Details',
              style: TextStyle(color: kgrey, fontSize: 20,fontWeight: FontWeight.bold),
            ),),
          
      
      body: Container(
        decoration: BoxDecoration( 
          image: DecorationImage(  
            image: AssetImage(Util.backgroundImage),
            fit: BoxFit.fitHeight
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
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
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                        child: Container(
                          height: 25,
                          color: kgreen,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text(" ${schedule.scheduleDay}",style: TextStyle(color: kWhite,fontSize: 15,fontWeight: FontWeight.bold)),
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
                                Row(
                                  children: [
                                    Text("Title:",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 280,
                                      child: Text(maxLines:3, overflow: TextOverflow.ellipsis,
                                          " ${schedule.title}",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text("Schedule Type :",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold)),
                                SizedBox(
                                    child: Text(maxLines:2, overflow: TextOverflow.ellipsis," ${schedule.scheduleType}",style: TextStyle(color: kgreen,fontSize: 15,fontWeight: FontWeight.bold))),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Center(child: Image.network(schedule.scheduleImage,height: 200,
                              errorBuilder: (context, error,
                                stackTrace) {
                              return Image.asset("assets/images/noimage.png",height: 200,);
                            },)),
                            SizedBox(height: 20,),
      
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("",style: TextStyle(color: kblack,fontSize: 15,fontWeight: FontWeight.bold,height: 3)),
                            ),
                          ],
                        ),
                      ),
      
                      Html(
                          data:schedule.schedule),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}


