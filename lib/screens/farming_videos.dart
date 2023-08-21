

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../utils/Colors.dart';

class FarmingVideos extends StatefulWidget {
  const FarmingVideos({Key? key}) : super(key: key);

  @override
  State<FarmingVideos> createState() => _FarmingVideosState();
}


class _FarmingVideosState extends State<FarmingVideos> {

  late Map mapresponse;
  List? listresponse;
  late Map postdetailsmapresponse;
  List? postdetailslistresponse;
  int? catId;


  bool isLoaded = false;
  var jsonResponse;

  String? name;
  Future farminglistcatigory() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/GetVideoHome?USER_ID=21013&TYPE=User'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 100,
          "LANG_ID": "1",
          "WORD": "None"
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


 @override
  void initState() {
   farminglistcatigory().then((value) {
     setState(() {});
     catId;
     return value;
   });




    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpagebackgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(
              height: 100,

              child: Visibility(
                visible: isLoaded,
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  //  padding: EdgeInsets.only(top: 12,),
                    itemCount:   listresponse == null ? 0 : listresponse!.length,
            itemBuilder: (context, index) {
              catId = listresponse![index]["QC_ID"];
             return
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                 children: [
                   Material(
                elevation:1,
                     borderRadius: BorderRadius.circular(32),
                     child: InkWell(
                       onTap: (){
                         setState(() {
                           print(catId);
                         });

                       },
                       child: CircleAvatar(
                         radius: 32,
                         backgroundColor: kWhite,
                         child: CircleAvatar(
                           backgroundColor: kWhite,
                           radius: 31,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(32),
                               child: Image.network( listresponse![index]["QC_IMG"].toString())),
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 5,),
                   Text( listresponse![index]["QC_NAME"].toString())
                 ],
                ),
              );
          }
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: VideoList(catId:catId ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
} 


class VideoList extends StatefulWidget {
  const VideoList({Key? key, this.text, this.image, this.catId}) : super(key: key);
  final text;
  final image;
  final catId;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late Map mapresponse;
  List? listresponse;
  late Map postdetailsmapresponse;
  List? postdetailslistresponse;


  bool isLoaded = false;
  var jsonResponse;

  String? name;

  Future videolist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/GetVideoHome?USER_ID=21013&TYPE=User&CAT_ID=3'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{

          "START": 0,
          "END": 10,
          "LANG_ID": "1",
          "WORD": "None"

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
  @override
  void initState() {
    videolist().then((value) {
      setState(() {});
      return value;
    });




    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0 ,horizontal: 0),

          shrinkWrap: true,
          //  padding: EdgeInsets.only(top: 12,),
          physics: NeverScrollableScrollPhysics(),
          itemCount:   listresponse == null ? 0 : listresponse!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(6),

              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [],
                      ),
                      Text(
                        listresponse![index]["VIDEO_TITLE"].toString(),
                        style: TextStyle(
                          color: kblack,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 5,),
                      InkWell(


                          onTap: () async {
                            String? url;
                            print("hello");

                            url = "https://www.youtube.com/watch?v=${listresponse![index]["VIDEO_URL"].toString()}";
                            if (await canLaunch(url!)) {
                              await launch(
                                url!,
                                headers: {
                                  "Content-Type": "application/x-www-form-urlencoded",
                                  "Content-Disposition": "inline"
                                },
                              );
                              print("browser url");
                              print(url);
                            } else
                              // can't launch url, there is some error
                              throw "Could not launch $url";
                          },

                        child: Container(
                          height: 200,
                          alignment: Alignment.center,

                          decoration: BoxDecoration(



                          ),
                          child: Stack(
                            children: [

                              // Image.network(
                              //   YoutubeThumbnail(youtubeId: listresponse![index]["VIDEO_URL"].toString()).hd(),
                              //   fit: BoxFit.cover, width: MediaQuery
                              //     .of(context)
                              //     .size
                              //     .width, height: MediaQuery
                              //     .of(context)
                              //     .size
                              //     .height,),
                              // Center(child: Image.asset(
                              //   "assets/images/play.png", height: 40,
                              //   color: Colors.red,)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
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

