import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Componts/MyPloatPage/question_answer_list.dart';
import '../utils/Colors.dart';
class IncomePostApi{
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  int? _value;
  int? _value2;
  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  incomePostApi( productname,unitid,price,incomedate,quantity,remark,userId,plotID) async {

    Map<String, dynamic> data = {
      "USER_ID": userId.toString(),
      "PLOT_ID": plotID.toString(),
      "PRODUCT_NAME": productname.toString(),
      "UNIT_ID":unitid,
      "QUANTITY": quantity.toString(),
      "PRICE": price.toString(),
      "INCOME_DATE": incomedate.toString(),
      "INCOME_TIME": "",
      "FP_ID": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "TASK": "ADD",
      "REMARK":remark.toString()
    };
    print(data);
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/FarmerPlotIncome"),
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
       //et.to(QuestionAnswer());


      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }


}