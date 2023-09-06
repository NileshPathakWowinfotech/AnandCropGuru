import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../utils/Colors.dart';
class BulkOrderApi{
  bool _loading = false;
  bool get loading => _loading;

  dynamic imageData = "";


  setLoading(bool vlaue) {
    _loading = vlaue;
  }

  static  bulkapi(userID,username,mobileNumber,orderType,shopOrComanyName,pinCode,pancardnumbr,gstNumber,address) async {

    Map<String, dynamic> data = {
      "BULK_ORDER_ID":"",
      "USER_ID":userID,
      "USER_NAME":"kunal",
      "MOBILE_NUMBER":mobileNumber.toString(),
      "ORDER_TYPE":orderType,
      "SHOP_OR_COMPANY_NAME":shopOrComanyName,
      "LATITUDE":"",
      "LONGITUDE":"",
      "ADDRESS": address,
      "PINCODE":pinCode,
      "REMARK":"",
      "TASK":"ADD",
      "EXTRA1":"",
      "EXTRA2":"",
      "EXTRA3":"",
      "PAN": pancardnumbr,
      "GST":gstNumber,
      "LANG_ID":""
    };
    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/BulkOrder"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      var jsonResponse = json.decode(response.body);
 

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
   

      }
    } catch (e) {
     
    }
  }


}