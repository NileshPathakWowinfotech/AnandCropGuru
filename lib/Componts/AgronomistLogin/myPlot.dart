

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as  http;
import 'my_ploat_information.dart.dart';

class MYploat extends StatefulWidget {
  const MYploat({Key? key}) : super(key: key);

  @override
  State<MYploat> createState() => _MYploatState();
}

class _MYploatState extends State<MYploat>with TickerProviderStateMixin {
  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  var jsonResponse;
  Future myplotlist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/PlotList?SALESTEAM_USER_ID=21013&TYPE=Agronomist&FARMERUSER_ID_ID=0&LANG_ID=1'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 1500000,
          "WORD": "NONE",
          "LANG_ID": "1"
        }));
    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);

      mapresponse = json.decode(response.body);

      listresponse = mapresponse["DATA"];


      isLoaded = true;
    }
  }
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    WidgetsBinding.instance
        .addPostFrameCallback(
            (timeStamp) {
          Util.animatedProgressDialog(
              context, _controller);
          _controller.forward();
        });
    myplotlist().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });

    myplotlist();
    // TODO: implement initState
    super.initState();
  }

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
        title: Text("My Plot",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextFormField(
              //  controller: description_Controller,
                //maxLines: 5,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search by farmer Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      //  color: Util.colorPrimary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Description can not be empty";
                  }
                  return null;
                },
              ),
            ),
           SizedBox(height: 10,),

           Expanded(
             child: Container(
               child:  SingleChildScrollView(
                 child: Column(
                   children: [
                     Visibility(
                       visible: isLoaded,
                       child: ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    //  padding: EdgeInsets.only(top: 12,),
    itemCount:   listresponse == null ? 0 : listresponse!.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: InkWell(
          onTap: () {
            Get.to(MyPloatInformation());
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Plot name :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 10,),
                              Text(listresponse![index]["PLOT_NAME"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Crop name :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["CROP_NAME"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Crop Variety :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["V_NAME"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Carden method :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["STRUCTURE_TYPE"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Pruning date :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["PURNING_DATE"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Farmer name :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["FULL_NAME"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Mobile no :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(listresponse![index]["MOBILE_NO"].toString(),
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                        ],
                      ),
                    ),


                    Column(
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
                                listresponse![index]["STATUS"].toString(),
                                style: TextStyle(
                                    color: kWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "Question :${listresponse![index]["NEW_QUESTION"].toString()}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height - 610,),
                        Icon(Icons.arrow_forward, size: 25, color: kdarkred,)


                      ],
                    )


                  ],
                ),
              ),

            ),
          ),
        ),
      );
    }
                       ),
                     ),


                   ],
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );

  }
}
