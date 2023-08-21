import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import 'package:http/http.dart' as http;
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> with TickerProviderStateMixin {
  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  bool likebtn  = false;

  late AnimationController _controller;
  var jsonResponse;
  Future postApi() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/GetNotification?USER_ID=60640&TYPE=USER'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": "",
          "END": "500000",
          "LANG_ID": "1",
          "WORD": ""
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

  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
    });
    postApi().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    postApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Util.newHomeColor, Util.endColor]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back,
                                size: 30, color: kWhite)),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Notificaion",
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Material(
    borderRadius: BorderRadius.circular(10),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child:Visibility(
                   visible: isLoaded,
                    child: ListView.builder(
    shrinkWrap: true,
    itemCount:  listresponse == null ? 0 : listresponse!.length,
    itemBuilder: (context, index) {
                     return NotificationList(
                       image:listresponse![index]["P_ICON"].toString(),
                       datetime:listresponse![index]["REG_DATE"].toString(),
                       views:listresponse![index]["VIEW_CNT"].toString(),
                       longtext:listresponse![index]["MESSAGE"].toString(),
                       title:listresponse![index]["TITLE"].toString(),
                     );})),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key, this.image, this.datetime, this.views, this.longtext, this.title}) : super(key: key);
  final image;
  final datetime;
  final views;
  final longtext;
  final title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network('https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80',
                    height: 70,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [

                          SizedBox(width: 5,),
                          Text(
                            datetime,
                            style: TextStyle(
                                color: kgreyy,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),


                        ],
                      ),
                      SizedBox(width: 5,),
                      Container(height: 20,width: 1,color: kblack,),
                      SizedBox(width: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            size: 17,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            "${views} views",
                            style: TextStyle(
                                color: kgreyy,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10,),


                        ],
                      )
                    ],
                  ),
                  Text("lvmmkcmvkcmv\nkjdskfidjf\nfkjfkidf")
                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delete,
                    size: 22,
                    color: lgreen,
                  ),
                ],
              )



            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border(
                      top: BorderSide(width: 1.0, color: kgreen),
                      // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/like2.png", height: 25, color: kgreen),
                      SizedBox(width: 5,),
                      Text("Like", style: TextStyle(
                          color: kblack, fontSize: 16),),
                    ],
                  )
              ),
            ),
            Container(
                width: 1,
                height: 50,
                color: kgreen
            ),

            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border(
                      top: BorderSide(width: 1.0, color: kgreen),
                      // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, size: 25,
                        color: kgreen,),
                      SizedBox(width: 5,),
                      Text("Share", style: TextStyle(
                          color: kblack, fontSize: 16),),
                    ],
                  )
              ),
            ),
          ],
        )
      ],
    );
  }
}

