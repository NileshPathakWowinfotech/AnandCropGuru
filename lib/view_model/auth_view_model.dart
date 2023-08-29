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
      dynamic data, BuildContext context, mobileNumber, uesrName) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userpreference = Provider.of<UserViewModel>(context, listen: false);
      Util.flushBarErrorMessage("Login Successfull", context);
      alertbox().showAlertDialog(
          context, value['ID'], value['DATA'], mobileNumber, uesrName);
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
    dynamic data,
    BuildContext context,
  ) async {
    setsignUpLoading(true);
    setsignUpLoading(true);
    _myRepo.registerApi(data).then((value) {
      List data = value['DATA'];
      setAddressLoading(false);
      final userpreference = Provider.of<UserViewModel>(context, listen: false);
      userpreference.saveUser(
        UserModel(
          userId: data[0]['USER_ID'].toString(),
          fullName: data[0]['FULL_NAME'].toString(),
          mobileNumber: data[0]['MOBILE_NO'].toString(),
          address: data[0]['ADDRESS'].toString(),
          email: data[0]['EMAIL'].toString(),
          destrict: data[0]['DISTRICT_NAME'].toString(),
          taluke: data[0]['TALUKA_NAME'].toString(),
        ),
      );
      Navigator.popAndPushNamed(context, RoutesName.address);
      Util.flushBarErrorMessage("SignUp Successful", context);
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
