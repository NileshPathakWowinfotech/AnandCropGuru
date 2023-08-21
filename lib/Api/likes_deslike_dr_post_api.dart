import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
import '../utils/Colors.dart';
class LikesDeslikeDrPostApi{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";
  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  likesDeslikedrpost(userId,blogId,temp) async {

    Map<String, String> data = {
      "USER_ID": "21013",
      "ACTION_TYPE": "Blog",
      "STATUS": temp,
      "NOTI_BLOG_ID": blogId,
      "EXTRA": ""
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/Noti_Blog_Like_Dislike"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      var jsonResponse = json.decode(response.body);
      print(response.body);

      if (jsonResponse["ResponseCode"] == "0") {
        Fluttertoast.showToast(
          msg: " ${temp}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kblack,
          textColor: kWhite,
          fontSize: 13.0,



        );
        //et.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}