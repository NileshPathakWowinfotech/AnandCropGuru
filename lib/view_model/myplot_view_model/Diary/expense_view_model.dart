import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/category_model.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/productname_model.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/totalexpenses_model.dart';
import '../../../data/network/BaseApiServices.dart';
import '../../../data/network/NetworkApiServices.dart';
import '../../../data/response/api_response.dart';
import '../../../repository/myplot/Diary/expense_repository.dart';
import '../../../utils/util.dart';

class ExpansesViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = ExpensesRepository();


  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<CategoryNameModel> categoryNameList = ApiResponse.loading();

  setlabTestingType(ApiResponse<CategoryNameModel> response) {
    categoryNameList = response;

    print('  Report data $response');
    notifyListeners();
  } 
  ApiResponse<ProductNameModel> productNameList = ApiResponse.loading();






  setproductType(ApiResponse<ProductNameModel> response) {
    productNameList = response;

    print('  product data $response');
    notifyListeners();
  } 
  

 // registerapi UP API
  Future<void>addExpencepost(
    dynamic dataa,
    BuildContext context,
  ) async {
    setLoading(true);
    setLoading(true);
    _myRepo.addExpensesPostApi(dataa).then((value) {
      List dataList = value['DATA'];
      setLoading(false);
     
      Util.flushBarErrorMessage("SignUp Successful", context);
      setLoading(false);
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }


  Future<void> categoryListDropDownList(userId) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": userId.toString()
    });
    setlabTestingType(ApiResponse.loading());
    _myRepo.categoryNameApi(registerdata).then((value) {
      setlabTestingType(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setlabTestingType(ApiResponse.error(error.toString()));
       notifyListeners();
    });
  }

  Future<void> productListDropDownList(userId,catId) async {
    final productdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID":userId,
      "CAT_ID": catId,

    
    });
   print('cat data $productdata');
    setproductType(ApiResponse.loading());
    _myRepo.productNameApi(productdata).then((value) {
      setproductType(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setproductType(ApiResponse.error(error.toString()));
    });
  }  


 












}