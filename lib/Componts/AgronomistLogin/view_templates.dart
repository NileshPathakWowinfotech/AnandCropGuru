
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class ViewTemplates extends StatelessWidget {
  const ViewTemplates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kgreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text("View Templates",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,  color: Colors.white,)),


      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,


                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Title :",
                                  style: TextStyle(fontSize: 16, color: kblack,fontWeight: FontWeight.bold)),
                              SizedBox(width: 5,),
                              Text("name",
                                  style: TextStyle(fontSize: 16, color: kgreen, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Text("Schedule :",
                                  style: TextStyle(fontSize: 16, color: kblack,fontWeight: FontWeight.bold)),
                              SizedBox(width: 5,),
                              Text("Spray",
                                  style: TextStyle(fontSize: 16, color: kgreen,fontWeight: FontWeight.bold )),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text("Schedule :",
                              style: TextStyle(fontSize: 16, color: kblack,fontWeight: FontWeight.bold)),
                        ],
                      ),


                      Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 60,
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
                                  "Active",
                                  style: TextStyle(
                                      color: kWhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_forward, size: 25, color: kdarkred,),
                            ],
                          )
                        ],
                      )


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
