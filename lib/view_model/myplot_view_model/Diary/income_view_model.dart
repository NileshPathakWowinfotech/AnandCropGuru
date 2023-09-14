import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/unitcount_model.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/IncomeModels/unit_model.dart';
import '../../../data/response/api_response.dart';
import '../../../repository/myplot/Diary/incomeunit_repository.dart';

class IncomeViewModel with ChangeNotifier {
  final _myRepo = IncomeUnitRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _subloading = false;
  bool get subloading => _subloading;
  setsubLoading(bool value) {
    _subloading = value;
    notifyListeners();
  }

  ApiResponse<IncomeUnitModel> unitlist = ApiResponse.loading();

  setFaqList(ApiResponse<IncomeUnitModel> response) {
    unitlist = response;

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

  Future<void> incomeUnitListApi() async {
    final listData = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "GET_DATA": "Get_UnitMasterList",
      "ID1": "",
      "ID2": "",
      "ID3": "",
      "STATUS": "",
      "START_DATE": "",
      "END_DATE": "",
      "EXTRA1": "Income",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1"
    });
    print(listData);
    setFaqList(ApiResponse.loading());
    _myRepo.incomeUnittApi(listData).then((value) {
      setFaqList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setFaqList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> unitCountListView(unitid, catId, productId, userId) async {
    final registerdata = jsonEncode({
      "START": "1",
      "END": "1000",
      "WORD": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "PRODUCT_ID": "",
      "USER_ID":"",
      "CAT_ID":"",
      "UNIT_ID": "2"
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

  // //FAQ Sub List
  //  Future<void> faqSubListApi(catID) async {
  //   final listSubData = jsonEncode({
  //       "START": "0",
  //         "END": "35000",
  //         "WORD": "NONE",
  //         "LANG_ID": "1",
  //         "CROP_ID": "3",
  //         "ACCESS_CODE": "123456",
  //         "USER_ID":21013,
  //         "TYPE": "User",
  //         "PLOT_ID": 82265
  //   });
  //   print(listSubData);
  //   setFaqSubList(ApiResponse.loading());
  //   _myRepo.faqSubListApi(listSubData,catID.toString()).then((value) {
  //     setFaqSubList(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     print('error this $error');
  //     setFaqSubList(ApiResponse.error(error.toString()));
  //   });
  // }
}
