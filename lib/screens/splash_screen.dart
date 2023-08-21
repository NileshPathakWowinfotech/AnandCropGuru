import 'dart:async';
import 'package:flutter/material.dart';
import '../services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
SplashServices splashServices = SplashServices();
 
  @override
  void initState() {
    super.initState();
   splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          
           image: new DecorationImage(
          image: new AssetImage("assets/images/sp_back_new.png"),
           fit: BoxFit.fill,
          )
        ),
      ),
    );
  }
}
