import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/totalexpenses_model.dart';
import '../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/unitcount_model.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/categorydropdownmode.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/productdropdown_model.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/unitdropdown_model.dart';
import '../../data/Model/MyPlotModel.dart/farmerpurchase_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/purshes_repository.dart';
import '../../utils/util.dart';

class PurchesdropViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = PurchasDropDownRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  } 

   //total expanse list
ApiResponse<TotalExpensesModel> totalExpanseListList = ApiResponse.loading();

  setTotalExpancse(ApiResponse<TotalExpensesModel> response) {
    totalExpanseListList = response;

    print('  Report data $response');
    notifyListeners();
  } 

  // category
  ApiResponse<CategoryDropDownModel> categoryList = ApiResponse.loading();

  setcategoryDropDown(ApiResponse<CategoryDropDownModel> response) {
    categoryList = response;

    print('  Report data $response');
    notifyListeners();
  }

  // product
  ApiResponse<ProductDropDownModel> productList = ApiResponse.loading();

  setproductDropDown(ApiResponse<ProductDropDownModel> response) {
    productList = response;

    print('  Report data $response');
    notifyListeners();
  }

  // Unit
  ApiResponse<UnitDropDownModel> unitList = ApiResponse.loading();

  setUnit(ApiResponse<UnitDropDownModel> response) {
    unitList = response;

    print('  Report data $response');
    notifyListeners();
  } 

    ApiResponse<FarmerPurchaseModel> purchaseList = ApiResponse.loading();

  setpurchase(ApiResponse<FarmerPurchaseModel> response) {
    purchaseList = response;

    print('  Report data $response');
    notifyListeners();
  } 
  //Unit Count 
   ApiResponse<UnitCountModel> unitcountList = ApiResponse.loading();

  setUnitCount(ApiResponse<UnitCountModel> response) {
    unitcountList = response;

    print('  Report data $response');
    notifyListeners();
  }

  //AddPurchase API
  Future<void> addPurchase(
    dynamic data,
    BuildContext context,
  ) async {
    setLoading(true);
    setLoading(true);
    _myRepo.addPursusPostApi(data).then((value) {
      setLoading(false);

      //  Navigator.popAndPushNamed(context, RoutesName.address);

      Util.tostMassage('Sccsess');
      Navigator.pop(context);
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
  // category Dropdown
  Future<void> categoryListView(userId) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID":userId
    });
    setcategoryDropDown(ApiResponse.loading());
    _myRepo.categoryListApi(registerdata).then((value) {
      setcategoryDropDown(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setcategoryDropDown(ApiResponse.error(error.toString()));
    });
  }

  // category Dropdown
  Future<void> productListView(catId,userId) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": userId,
      "CAT_ID": catId
    });
    print(registerdata);
    setproductDropDown(ApiResponse.loading());
    _myRepo.productListApi(registerdata).then((value) {
      setproductDropDown(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setproductDropDown(ApiResponse.error(error.toString()));
    });
  }

  // Product Dropdown
  Future<void> unitListView(unit,userId) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "GET_DATA": "Get_ExpencesUnitMasterList",
      "ID1":unit,
      "ID2": userId,
      "ID3": "",
      "STATUS": "",
      "START_DATE": "",
      "END_DATE": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1"
    });
    print(registerdata);
    setUnit(ApiResponse.loading());
    _myRepo.UnitApi(registerdata).then((value) {
      setUnit(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setUnit(ApiResponse.error(error.toString()));
    });
  } 


Future<void> purshesListView(userID) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": userID,
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


  
Future<void> unitCountListView(unitid,catId,productId,userId) async {
    final registerdata = jsonEncode({
       "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "PRODUCT_ID":productId,
      "USER_ID":userId,
      "CAT_ID":catId,
      "UNIT_ID": unitid
    });
    print(registerdata);
    setUnitCount(ApiResponse.loading());
    _myRepo.unitCountApi(registerdata).then((value) {
      setUnitCount(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setUnitCount(ApiResponse.error(error.toString()));
    });
  } 
  
// Total Expanse Api
  Future<void> totalExpanseApi(usreId,ploatId,startdate,enddate) async {
    final productdata = jsonEncode({
       "CAT_ID": "",
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1",
      "USER_ID": usreId.toString(),
      "START_DATE": startdate.toString(),
      "END_DATE":enddate,
      "PLOT_ID": ploatId

    
    });
   print('cat data $productdata');
    setTotalExpancse(ApiResponse.loading());
    _myRepo.totalExpanseApi(productdata).then((value) {
      setTotalExpancse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setTotalExpancse(ApiResponse.error(error.toString()));
    });
  } 
  
}
