import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
import '../utils/Colors.dart';

class AddvisitReport{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  File? image;
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());

      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  static addvisitreport(userId,ploatId,agronomistid) async {

    Map<String, dynamic> data = {
      "USER_ID": userId,
      "PLOT_ID":ploatId,
      "QUESTION_ID":"36",
      "AGRONOMIST_ID":agronomistid,
      "QUESTION":"sfdsf",
      "QUESTION_ANSWER":"dsd",
      "QUESTION_CAT":"",
      "LOCATION":"nashik",
      "LATITUDE":"sf",
      "LONGITUDE":"fs",
      "ANS_IMAGE":""
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/PlotVisit"),
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
      //  Get.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}