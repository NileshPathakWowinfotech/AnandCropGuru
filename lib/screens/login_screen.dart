//pending:
//OTP throw error handling

import 'dart:convert';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../data/Model/user_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/util.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/user_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isChecked = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _enterRefrralCode = TextEditingController();
  bool _nameValidated = true;
  bool _mobileValidated = true;
  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_all.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/splash_logo.png'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Util.colorCustomPrimary),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 9),
                            child: TextField(
                              onChanged: (value) {
                                if (!_nameValidated) {
                                  setState(() {
                                    _nameValidated = true;
                                  });
                                }
                              },
                              controller: _name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.person,
                                    color: Util.colorPrimary),
                                hintText: 'Your name',
                              ),
                            ),
                          ),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Util.colorCustomPrimary),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 9),
                            child: TextField(
                              onChanged: (value) {
                                if (!_mobileValidated) {
                                  setState(() {
                                    _mobileValidated = true;
                                  });
                                }
                              },
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              controller: _mobile,
                              decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.call, color: Util.colorPrimary),
                                hintText: 'Mobile no',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Util.colorCustomPrimary),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 9),
                            child: TextField(
                              onChanged: (value) {
                                if (!_nameValidated) {
                                  setState(() {
                                    _nameValidated = true;
                                  });
                                }
                              },
                              controller: _enterRefrralCode,
                              decoration: InputDecoration(
                                  hintText: 'Enter referral code',
                                  border: InputBorder.none),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Util.colorPrimary,
                                side: BorderSide(
                                    width: 2, color: Util.colorPrimary),
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  //  alertbox().showAlertDialog(context);
                                },
                                child: Text('I agree to Terms & Conditions',
                                    style: TextStyle(
                                      color: Util.colorPrimary,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.white, width: 1.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green,
                                  Util.endColor,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: SizedBox(
                              height: 45,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_name.text.isEmpty) {
                                    Util.flushBarErrorMessage(
                                        "Enter your name", context);
                                  } else if (_mobile.text.isEmpty) {
                                    Util.flushBarErrorMessage(
                                        "Enter mobile number.", context);
                                  } else if (isChecked == false) {
                                    Util.tostMassage(
                                        "Please accept the terms and conditions");
                                  } else {
                                    final data = jsonEncode({
                                      "MOBILE_NUMBER": _mobile.text,
                                    });
                                    authViewMode.loginApi(data, context,
                                        _mobile.text, _name.text.toString());
                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black54,
                                  splashFactory: NoSplash.splashFactory,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class alertbox {
  TextEditingController otpTextController = TextEditingController();
  bool isTimerOn = true;
  bool isResending = false;

  void toggleIsTimerOn() {
    isTimerOn = !isTimerOn;
  }

  void showAlertDialog(
      BuildContext context, randomOtp, mastrOtp, mobileNumber, userName) {
    final authViewMode = Provider.of<AuthViewModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                size: 30,
                                color: Util.colorCustomPrimary,
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/images/cropguru.png",
                        height: 70,
                      ),
                      Image.asset(
                        "assets/images/otp.png",
                        height: 45,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Successfully Send massage",
                          style: TextStyle(color: kgrey, fontSize: 15),
                        ),
                      )),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Text(
                        "+91${mobileNumber}",
                        style: TextStyle(
                            color: kblack,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 45,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: kgrey)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          controller: otpTextController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '- - - -',
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            if (otpTextController.text.isEmpty) {
                              Util.flushBarErrorMessage(
                                  "Please enter OTP number", context);
                            } else if (otpTextController.text ==
                                    mastrOtp.toString() ||
                                otpTextController.text == mastrOtp) {
                              final data = jsonEncode({
                                "USER_ID": "1",
                                "FULL_NAME": userName,
                                "MOBILE_NO": mobileNumber,
                                "REFERANCE_NO": "",
                                "ADDRESS": "",
                                "EMAIL": "",
                                "LATITUDE": "",
                                "LONGITUDE": ""
                              });
                              print(data);
                              authViewMode.registerApi(data, context);
                            } else {
                              Util.tostMassage("Valid Otp Enter");
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 38,
                              width: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Util.colorPrimary,
                                  border: Border.all(width: 1, color: kgrey)),
                              child: authViewMode.signUpLoading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator()),
                                        Text(
                                          "Loading...",
                                          style: TextStyle(
                                              color: kWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ))))
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
