import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/Model/register_model.dart';
import '../data/Model/user_model.dart';
import '../repository/auth_repository.dart';
import '../screens/login_screen.dart';
import '../utils/routes/routes_name.dart';
import '../utils/util.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<UserModel> getUserData() => UserViewModel().getUser();

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setsignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  bool _addressLOading = false;
  bool get addressLOading => _signUpLoading;

  setAddressLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(
      dynamic data, BuildContext context, mobileNumber, uesrName,reffrealId) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      print(data);
      final userpreference = Provider.of<UserViewModel>(context, listen: false);
      Util.flushBarErrorMessage("Login Successfully", context);
      alertbox().showAlertDialog(
          context, value['ID'], value['DATA'], mobileNumber, uesrName,reffrealId );
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
  }

  // registerapi UP API
  Future<void> registerApi(
    dynamic dataa,
    BuildContext context,
  ) async {
    setsignUpLoading(true);
    setsignUpLoading(true);
    _myRepo.registerApi(dataa).then((value) {
      List dataList = value['DATA'];
      setAddressLoading(false);
      final userpreference = Provider.of<UserViewModel>(context, listen: false);
      userpreference.saveUser(
        UserModel(
          userId: dataList[0]['USER_ID'].toString(),
          fullName: dataList[0]['FULL_NAME'].toString(),
          distructName: dataList[0]['DISTRICT_NAME'].toString(),
          mobileNumber: dataList[0]['MOBILE_NO'].toString(),
          address: dataList[0]['ADDRESS'].toString(),
          email: dataList[0]['EMAIL'].toString(),
          taluke: dataList[0]['TALUKA_NAME'].toString(),
          stateId: dataList[0]['STATE_ID'].toString(),
          stateName: dataList[0]['STATE_NAME'].toString(),
          districtId: dataList[0]['DISTRICT_ID'].toString(),
          talukaId: dataList[0]['TALUKA_ID'].toString(),
        ),
      ); 
      // print('fddff ${dataList[0]['DISTRICT_NAME'].toString()}');
      
      if(dataList[0]['STATE_NAME'].toString() == 'null'){
         Navigator.popAndPushNamed(context, RoutesName.address);
      }else{
        print(dataList[0]['STATE_NAME'].toString());
        Navigator.popAndPushNamed(context, RoutesName.home);
      }
     
     // Util.flushBarErrorMessage("SignUp Successful", context);
      setAddressLoading(false);
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setAddressLoading(false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  // User Update Address
  Future<void> userUpdateAddress(BuildContext context, talukaId, talukaName,
      districtID, distrctName, stateId, stateName, villageName) async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "USER_ID": value.userId,
        "FULL_NAME": value.fullName,
        "MOBILE_NO": value.mobileNumber,
        "ADDRESS": value.address,
        "EMAIL": value.email,
        "TALUKA_ID": talukaId,
        "TALUKA_NAME": talukaName,
        "DISTRICT_ID": districtID,
        "DISTRICT_NAME": distrctName,
        "STATE_ID": stateId,
        "VILLAGE_NAME": stateName,
        "VILLAGE_ID": "1",
        "PROFILE_PHOTO": ""
      });
      print('register api data is $registerdata');

      setsignUpLoading(true);
      _myRepo.userUpdateAddress(registerdata).then((value) {
        print(value);
        setsignUpLoading(true);
        (false);
        Navigator.popAndPushNamed(context, RoutesName.home);
        Util.flushBarErrorMessage("welcome to Anand Crop Guru", context);
        setsignUpLoading(false);
        if (kDebugMode) {}
      }).onError((error, stackTrace) {
        setsignUpLoading(true);
        (false);
        if (kDebugMode) {
          Util.flushBarErrorMessage(error.toString(), context);
          print(error.toString());
        }
      });
    });
  }
}
