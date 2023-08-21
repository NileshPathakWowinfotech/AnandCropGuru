import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../data/Model/LabModel/lab_list_model.dart';
import '../data/Model/list_model.dart';
import '../data/Model/soli_testing_type_model.dart';
import '../data/Model/user_model.dart';
import '../data/response/api_response.dart';
import '../repository/home_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/util.dart';

class HomeViewViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = HomeRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<SoilTestingTypeListModel> movieslLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<SoilTestingTypeListModel> response) {
    movieslLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  ApiResponse<LabListModel> lablist = ApiResponse.loading();

  setlablist(ApiResponse<LabListModel> response) {
    lablist = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> labTestingType() async {
    final  registerdata =  jsonEncode({
      "START": '0',
      "END": "10000",
      "WORD": "NONE",
      "GET_DATA": "Get_TestingTypeList",
      "ID1": "",
      "ID2": "",
      "ID3": "",
      "STATUS": "",
      "START_DATE": "",
      "END_DATE": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "3"
    });
    setlabTestingType(ApiResponse.loading());
    _myRepo.soilListApi(registerdata).then((value) {
      setlabTestingType(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setlabTestingType(ApiResponse.error(error.toString()));
    });
  }

  Future<void> labEnquiriesFormApi(BuildContext context, testingcategory,
      amount, address, pincode, remark) async {
    getUserData().then((value) {
      print(value.fullName);
      final data = jsonEncode({
        "ENQUIRY_ID": "",
        "USER_ID": value.userId,
        "TESTING_CATEGORY": testingcategory,
        "AMOUNT": amount,
        "ADDRESS": address,
        "PINCODE": pincode,
        "REMARK": remark,
        "TASK": "ADD",
        "LATITUDE": "19.9975",
        "LONGITUDE": "19.9975",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": "3"
      });
      print(data);
      setLoading(true);
      _myRepo.labEnquiriesService(data).then((value) {
        Navigator.pop(context);
        setLoading(false);
        if (kDebugMode) {
          print(value.toString());
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        if (kDebugMode) {
          Util.flushBarErrorMessage(error.toString(), context);
          print(error.toString());
        }
      });
    });
  }

  Future<void> labListApi() async {
    
     getUserData().then((value) {
      print("kddkdkd :- ");
       
      
    final  listData =jsonEncode({
      "START": 0,
    "END": 500000000,
    "WORD": "NONE",
    "GET_DATA": "Get_LabEnquiriesByUserId",
    "ID1":value.userId,
    "ID2": "",
    "ID3": "",
    "STATUS": "",
    "START_DATE": "",
    "END_DATE": "",
    "EXTRA1": "माती परीक्षण",
    "EXTRA2": "",
    "EXTRA3": "",
    "LANG_ID": ""
    });
    print(listData);
    setlablist(ApiResponse.loading());
    _myRepo.labList(listData).then((value) {
      setlablist(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setlablist(ApiResponse.error(error.toString()));
    });
  });
  }
}
