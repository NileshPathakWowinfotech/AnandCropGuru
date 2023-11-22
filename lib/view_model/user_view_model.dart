import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.userId.toString());
    sp.setString('fullName', user.fullName.toString());
    sp.setString('MobileNumber', user.mobileNumber.toString());
    sp.setString('address', user.address.toString());
    sp.setString('email', user.email.toString());
    sp.setString('taluka', user.talukaName.toString());
    sp.setString('statename', user.stateName.toString());
    sp.setString('stateId', user.stateId.toString());
    sp.setString('cityName', user.stateId.toString());
    sp.setString('districtId', user.districtId.toString());
    sp.setString('distructname', user.distructName.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token').toString();
    final String fullName = sp.getString('fullName').toString();
    final String mobileNumber = sp.getString('MobileNumber').toString();
    final String address = sp.getString('address').toString();
    final String email = sp.getString('email').toString();
    final String destrict = sp.getString('distructname').toString();
    final String taluke = sp.getString('taluka').toString();
    final String statename = sp.getString('statename').toString();
    final String stateId = sp.getString('stateId').toString();
    final String districtId = sp.getString('districtId').toString();
    final String cityName = sp.getString('cityName').toString();
    final String talukaId = sp.getString('talukaId').toString();
    print(talukaId,);
    print(taluke,);
      print(stateId,);
       print(destrict,);
        print(email,);


    return UserModel(
        userId: token,
        fullName: fullName,
        mobileNumber: mobileNumber,
        address: address,
        email: email,
        distructName: destrict,
        taluke: taluke,
        stateName: statename,
        stateId: stateId,
        districtId: districtId,
        talukaId: talukaId ,
       
        
        );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.remove('fullName').toString();
    sp.remove('MobileNumber').toString();
    sp.remove('address').toString();
    sp.remove('email').toString();
    sp.remove('distructname').toString();
    sp.remove('taluka').toString();
    sp.remove('statename').toString();
    sp.remove('stateId').toString();
    sp.remove('districtId').toString();
    sp.remove('talukaId').toString();
    sp.remove('talukaId').toString();
    return true;
  }
}
