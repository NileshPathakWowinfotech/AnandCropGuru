import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../data/Model/searchproduct_model.dart';
import '../repository/searchproduct_repository.dart';

class ProfileViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();
  String? fullName; 
  String? mobilenumber; 
  String? address;
  String? districtname;
  String? talukaname;
  String? stateName;

  final _myRepo = SearchProductRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> userDetails()async  {
    getUserData().then((value)async {
      await  value.fullName;
      address = value.address;
      mobilenumber = value.mobileNumber;
      districtname = value.distructName;
       talukaname = value.talukaName;
       stateName = value.stateName;
       
    
    });
     notifyListeners();
  }
    
}
