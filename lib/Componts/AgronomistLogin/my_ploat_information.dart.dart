import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'add_visit_report.dart';
import 'agronomist_visit_details.dart';
class MyPloatInformation extends StatefulWidget {
   MyPloatInformation({Key? key}) : super(key: key);

  @override
  State<MyPloatInformation> createState() => _MyPloatInformationState();
}

class _MyPloatInformationState extends State<MyPloatInformation> {
   bool flag = false;
   bool flag2 = false;
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
        title: Text("Ploat Information",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                     setState(() {
                       flag  = true;
                       flag2 = false;
                     });
                    },
                    child: Container(height: 45,
                       alignment: Alignment.center,
                       width: 100,
                      decoration: BoxDecoration(
                        color: flag == true ? kgreen :kWhite,
                          borderRadius: BorderRadius.circular(5),border: Border.all(width: 2,color: kgreen )),
                    child: Text("QUESTION ANSWERS",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,  color:flag == true ? kWhite : kgreen)),

                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        flag  = false;
                        flag2 = true;
                      });
                    },
                    child: Container(height: 45,
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          color: flag2 == true ? kgreen :kWhite,
                          borderRadius: BorderRadius.circular(5),border: Border.all(width: 2,color: kgreen )),
                      child: Text("AGRONOMIST VISITS",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,  color:flag2 == true ? kWhite : kgreen)),

                    ),
                  ),
                ),
              ],
            ),


       flag == true? QuestionAnswerList():AgronomistVisitsList(),



          ],
        ),
      ),
      floatingActionButton:flag == false? Container(
        height: 70.0,
        width: 90.0,

        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: Text("AddReport",style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold)),

              onPressed: () {
                Get.to(AddVisitReporrt());
                //Get.to(AddYourQuestion());
              }),
        ),
      ):Text("")
    );
  }
}


class QuestionAnswerList extends StatefulWidget {
  const QuestionAnswerList({Key? key}) : super(key: key);

  @override
  State<QuestionAnswerList> createState() => _QuestionAnswerListState();
}

class _QuestionAnswerListState extends State<QuestionAnswerList>with TickerProviderStateMixin {
  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  var jsonResponse;
  Future questionAnswers() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/QANDAAgronomist?USER_ID=21013&TYPE=Agronomist&AGRONOMIST_ID=20&PLOT_ID=36977'),
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
    questionAnswers();
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
    questionAnswers().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    Visibility(
      visible: isLoaded,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //  padding: EdgeInsets.only(top: 12,),
          itemCount:   listresponse == null ? 0 : listresponse!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: InkWell(
                onTap: (){
                  Get.to(AgronomistVisitDetails(name:listresponse![index]["FULL_NAME"] ,mobilenumber: listresponse![index]["MOBILE_NO"],ploatnamee: listresponse![index]["PLOT_NAME"],  qustions:listresponse![index]["FD_DESCRIPTION"] ,answer:listresponse![index]["FD_ANSWER"].toString(),image: listresponse![index]["FD_IMAGE"],));
                  print(listresponse![index]["FD_ANSWER"].toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(1, 6), // changes position of shadow
                      ),
                    ],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12,),
                        Row(
                          children: [
                            Text("Name",
                                style: TextStyle(fontSize: 14, color: kblack,)),
                            SizedBox(width: 5,),
                            Text(listresponse![index]["FULL_NAME"].toString(),
                                style: TextStyle(fontSize: 14, color: kgreen,)),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Row(
                          children: [
                            Text("Mobile Number",
                                style: TextStyle(fontSize: 14, color: kblack,)),
                            SizedBox(width: 5,),
                            Text(listresponse![index]["MOBILE_NO"].toString(),
                                style: TextStyle(fontSize: 14, color: kgreen,)),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Row(
                          children: [
                            Text("Ploat Name",
                                style: TextStyle(fontSize: 14, color: kblack,)),
                            SizedBox(width: 5,),
                            Text(listresponse![index]["PLOT_NAME"].toString(),
                                style: TextStyle(fontSize: 14, color: kgreen,)),
                          ],
                        ),
                        SizedBox(height: 12,),
                        Row(
                          children: [
                            Text("Q:",
                                style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: kblack,)),
                            SizedBox(width: 5,),
                            Text(listresponse![index]["FD_DESCRIPTION"].toString(),
                                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold,color: kblack,)),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Center(child: Image.network(
                          listresponse![index]["FD_IMAGE"].toString(),
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: 200, errorBuilder: (context, error,
                            stackTrace) {
                          return Text("");
                        },)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("", style: TextStyle(
                              color: kgrey,
                              fontSize: 16,
                            )),
                            SizedBox(height: 5,),

                            Icon(Icons.arrow_forward, size: 30, color: kdarkred,)
                          ],
                        )

                      ],


                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );

  }
}




class AgronomistVisitsList extends StatefulWidget {
  const AgronomistVisitsList({Key? key}) : super(key: key);

  @override
  State<AgronomistVisitsList> createState() => _AgronomistVisitsListState();
}

class _AgronomistVisitsListState extends State<AgronomistVisitsList>with TickerProviderStateMixin {

  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  var jsonResponse;
  Future agronomistvisits() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/PlotVisit?USER_ID=21013&TYPE=Agronomist&AGRONOMIST_ID=20&PLOT_ID=19'),
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
    agronomistvisits();
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
    agronomistvisits().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: isLoaded,
      child: ListView.builder(
        shrinkWrap: true,
        //scrollDirection: Axis.vertical,
      //  physics: NeverScrollableScrollPhysics(),
    //  padding: EdgeInsets.only(top: 12,),
    itemCount:   listresponse == null ? 0 : listresponse!.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () {
            Get.to(AgronomistVisitDetailss(datetime: listresponse![index]["REG_DATE"].toString(),
                                           title: listresponse![index]["TITLE"].toString(),
                                           description: listresponse![index]["DESCRIPTION"].toString(),
              image: listresponse![index]["PV_IMAGE"].toString(),
                                       ));
          },
          child: Container(

            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(1, 6), // changes position of shadow
                ),
              ],

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listresponse![index]["TITLE"].toString(),
                      style: TextStyle(
                          color: kblack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(maxLines: 2,
                      listresponse![index]["DESCRIPTION"].toString(),
                      style: TextStyle(
                        color: kblack,
                        fontSize: 14,
                      )),
                  SizedBox(height: 5,),
                  Center(child: Image.network(
                    listresponse![index]["PV_IMAGE"].toString() ,
                    height: 250, fit: BoxFit.cover,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    errorBuilder: (context, error,
                        stackTrace) {
                      return Container();
                    },)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("",
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
      );
    }
      ),
    );





  }
}




class AgronomistVisitDetailss extends StatelessWidget {
  const AgronomistVisitDetailss({Key? key, this.datetime, this.title, this.description, this.image}) : super(key: key);
  final datetime;
  final title;
  final description;
  final image;

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
          title: Text("Agronomist Visit Details",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),

        ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 5,
                  child: Container(


                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(datetime,
                                  style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                          Text("Title",
                              style: TextStyle(
                                  color: kblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(title,
                              style: TextStyle(
                                color: kblack,
                                fontSize: 16,
                              )),
                          Center(
                              child: Image.network(
                             image,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,

                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
                              )),
                          SizedBox(height: 5,),
                          Text("Description :",
                              style: TextStyle(
                                  color: kblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(description,
                              style: TextStyle(
                                color: kblack,
                                fontSize: 16,
                              )),


                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ));

  }
}
