import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Componts/MyPloatPage/report_master.dart';
import '../utils/Colors.dart';

class AnandBiochemCenterApi {
  bool _loading = false;
  bool get loading => _loading;
  var jsonResponse;
  dynamic imageData = "";
  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static anandBiochemRanddcenter(testingCategorey,ammount,address,pincode,remark) async {
    Map<String, dynamic> data = {
      "ENQUIRY_ID": "",
      "USER_ID": "21013",
      "TESTING_CATEGORY": testingCategorey,
      "AMOUNT": ammount,
      "ADDRESS": "testing ",
      "PINCODE": "422303",
      "REMARK": "testing ",
      "TASK": "ADD",
      "LATITUDE": "19.9975",
      "LONGITUDE": "19.9975",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "3"
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/LabEnquiries"),
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

      } else if (jsonResponse![0]["ResponseCode"] == "1") {
        print("failed");

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
