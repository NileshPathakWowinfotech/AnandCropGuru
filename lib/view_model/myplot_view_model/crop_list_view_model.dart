import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/Model/MyPlotModel.dart/addplot_list_model.dart';
import '../../data/Model/MyPlotModel.dart/crop_variety_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/add_plot_list_repository.dart';

class CropAddListViewModel with ChangeNotifier {
  late List datais;

  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = CropListRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<CropAddListModel> CropAddList = ApiResponse.loading();

  setlabTestingType(ApiResponse<CropAddListModel> response) {
    CropAddList = response;

    print('Report data $response');
    notifyListeners();
  } 


  //Crop Variety response
  ApiResponse<CropVarietyListModel> cropVarietyList = ApiResponse.loading();

  setCropVarietyList(ApiResponse<CropVarietyListModel> response) {
    cropVarietyList = response;

    print('  Report data $response');
    notifyListeners();
  } 


  

 // add plot list api  
  Future<void> addPlotListListView() async {
    final croplistdata =
        jsonEncode({
          "START":"1",
        "END":"10000",
        "WORD":"",
        "EXTRA1":"",
        "EXTRA2":"",
        "EXTRA3":"",
        "LANG_ID":"3",
        "USER_ID":"62239"
           
            });
    setlabTestingType(ApiResponse.loading());
    _myRepo.AddPlotListApi(croplistdata).then((value) {
      setlabTestingType(ApiResponse.completed(value));
      print('hello');
    }).onError((error, stackTrace) {
      print('error this $error');
      setlabTestingType(ApiResponse.error(error.toString()));
    });
  } 

   // add plot list api  
  Future<void> cropVarietyApi() async {
    final croplistdata =
        jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "",
        "LANG_ID": "3",
        "CROP_ID": "45",
        "ACCESS_CODE": "123456",
        "TYPE": "user",
        "USER_ID": "3"
        });
        
    setCropVarietyList(ApiResponse.loading());
    _myRepo.CropVarietyListApi(croplistdata).then((value) {
      setCropVarietyList(ApiResponse.completed(value));
      print('hello');
    }).onError((error, stackTrace) {
      print('error this $error');
      setCropVarietyList(ApiResponse.error(error.toString()));
    });
  } 
}
