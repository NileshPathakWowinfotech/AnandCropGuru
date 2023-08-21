import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
import '../screens/community.dart';
import '../utils/Colors.dart';

class AddPostCommunittyApi{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  addpostapi(cropId,description,postName,userId,imagedata) async {

    Map<String, dynamic> data = {
      "POST_ID": "",
      "USER_ID":userId,
      "CROP_ID":cropId,
      "POST_NAME": postName,
      "POST_DESCRIPTION":description,
      "TASK": "ADD",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "3",
      "POST_PHOTO": imagedata
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/Post"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      var jsonResponse = json.decode(response.body);
      print(data);

      if (jsonResponse["ResponseCode"] == "0") {
        Fluttertoast.showToast(
          msg: "${jsonResponse["ResponseMessage"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kblack,
          textColor: kWhite,
          fontSize: 13.0,
        );
        Get.to(Communitty());




      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}