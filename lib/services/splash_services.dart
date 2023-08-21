import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/Model/user_model.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      print(value.userId.toString());
      if (value.userId == 'null' || value.userId == '') {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.login );
        }); 
        
      }
       else {
         Future.delayed(const Duration(seconds: 1), () {
          Navigator.popAndPushNamed(context, RoutesName.home);
        });
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        //  Navigator.popAndPushNamed(context,RoutesName.login);
        print("error ${error.toString()}");
      }
    });
  }
}
