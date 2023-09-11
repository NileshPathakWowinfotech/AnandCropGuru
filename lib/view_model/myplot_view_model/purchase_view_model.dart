import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/Model/MyPlotModel.dart/farmerpurchase_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import 'package:http/http.dart' as http;
import '../../repository/myplot/purchase_model.dart';



class PurchaseViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = PurchaseRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<FarmerPurchaseModel> purchaseList = ApiResponse.loading();

  setpurchase(ApiResponse<FarmerPurchaseModel> response) {
    purchaseList = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> questionAnswerListView() async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": "21013",
      "CAT_ID": ""
    });
    setpurchase(ApiResponse.loading());
    _myRepo.purchaseApi(registerdata).then((value) {
      setpurchase(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setpurchase(ApiResponse.error(error.toString()));
    });
  }
  
}
