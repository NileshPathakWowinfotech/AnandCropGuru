import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Api/likes_deslike_dr_post_api.dart';
import '../Model/user.dart';
import '../utils/prefs_util.dart';
import '../widgets/post.dart';
import 'blogDetails.dart';

class DrPostScreen extends StatefulWidget {
  @override
  State<DrPostScreen> createState() => _DrPostScreenState();
}

class _DrPostScreenState extends State<DrPostScreen> {
  late Map mapresponse;
  List? listresponse;
  late Map postdetailsmapresponse;
  List? postdetailslistresponse;
  bool isLoaded = false;
  var jsonResponse;
  User? user;

    getdata()async{
      await PrefsUtil.getUserDetails().then((value) {
        setState(() {
        //  user = value!;
        });
        print(user!.USER_ID);
        return value;
      });
    }

  String? name;
  Future emergencycall() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/Get_Data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 500000000,
          "WORD": "",
          "GET_DATA": "Get_DoctorPostList",
          "ID1": "21013",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2": "",
          "EXTRA3": "",
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

 @override
  void initState() {
   getdata();
   emergencycall().then((value) {
     setState(() {});
     return value;
   });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 12,),
        itemCount:   listresponse == null ? 0 : listresponse!.length,
        itemBuilder: (context, index) {
          String blogId = listresponse![index]["BLOG_ID"].toString();
          return InkWell(
            onTap: (){
              Get.to(BlogDetails( listresponse![index]['BLOG_ID'],viwes:listresponse![index]['BLOG_VIEW'] ,likes: listresponse![index]['BLOG_LIKE_COUNT'],));
            },
            child: Post(
                listresponse![index]["BLOG_TITLE"].toString(),
                listresponse![index]["BLOG_IMAGE"].toString(),
                listresponse![index]["BLOG_LIKE_COUNT"],
                listresponse![index]["BLOG_VIEW"].toString(),
                listresponse![index]["BLOG_ID"].toString(),
                21013
            ),
          );
        },
      ),
    );
  }
}
