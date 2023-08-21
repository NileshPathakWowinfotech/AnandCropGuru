import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/MyPlotModel.dart/faq_model.dart';
import '../../data/Model/MyPlotModel.dart/faq_sub_Model.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/faq_repository.dart';

class FaqViewModel with ChangeNotifier {
  final _myRepo = FaqRepository();

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

  ApiResponse<FaqModel> faqlist = ApiResponse.loading();

  setFaqList(ApiResponse<FaqModel> response) {
    faqlist = response;

    print('  Report data $response');
    notifyListeners();
  } 

  ApiResponse<FaqSubListModel> faqSublist = ApiResponse.loading();

  setFaqSubList(ApiResponse<FaqSubListModel> response) {
    faqSublist = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> faqListApi(userID,ploatID) async {
    final listData = jsonEncode({
      "START": "0",
      "END": "35000",
      "WORD": "NONE",
      "LANG_ID": "1",
      "CROP_ID": "3",
      "ACCESS_CODE": "123456",
      "USER_ID": userID.toString(),
      "TYPE": "User",
      "PLOT_ID": ploatID.toString()
    });
    print(listData);
    setFaqList(ApiResponse.loading());
    _myRepo.faqListApi(listData).then((value) {
      setFaqList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setFaqList(ApiResponse.error(error.toString()));
    });
  } 

  //FAQ Sub List
   Future<void> faqSubListApi(catID) async {
    final listSubData = jsonEncode({
        "START": "0",
          "END": "35000",
          "WORD": "NONE",
          "LANG_ID": "1",
          "CROP_ID": "3",
          "ACCESS_CODE": "123456",
          "USER_ID":21013,
          "TYPE": "User",
          "PLOT_ID": 82265
    });
    print(listSubData);
    setFaqSubList(ApiResponse.loading());
    _myRepo.faqSubListApi(listSubData,catID.toString()).then((value) {
      setFaqSubList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setFaqSubList(ApiResponse.error(error.toString()));
    });
  }
}


 