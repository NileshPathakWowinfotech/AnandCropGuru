import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/add_anand_bichem_r_d_ceenter_api.dart';
import '../data/Model/soli_testing_type_model.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/auth_view_model.dart';
import '../view_model/home_view_model.dart';
import 'Purchase.dart';

class AddAnandBichemRDCenter extends StatelessWidget {
  AddAnandBichemRDCenter({Key? key, required this.category}) : super(key: key);
  final SoilTestingTypeListModelDATA category;
  String? url;

  TextEditingController pincodeController = TextEditingController();

  TextEditingController addresssController = TextEditingController();

  TextEditingController remarkController = TextEditingController();

  dynamic imageData = "";

  @override
  Widget build(BuildContext context) {
    final labEnquiriesFromProvide= Provider.of<HomeViewViewModel>(context, listen: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Util.backgroundImage))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Category :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: ksoilColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Text(
                                  category.TESTING_TYPE_ID.toString(),
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Amount :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Text(
                                  category.AMOUNT.toString(),
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "How to collect sample ? ",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            url =
                                "https://www.youtube.com/watch?v=${category.VIDEO_URL}";
                            if (await canLaunch(url!)) {
                              await launch(
                                url!,
                                headers: {
                                  "Content-Type":
                                      "application/x-www-form-urlencoded",
                                  "Content-Disposition": "inline"
                                },
                              );
                              print("browser url");
                              print(url);
                            } else
                              // can't launch url, there is some error
                              throw "Could not launch $url";
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1, color: kgrey),
                                borderRadius: BorderRadius.circular(5)),
                            child: Stack(
                              children: [
                                Image.network(
                                  category.TESTING_IMG.toString(),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                Center(
                                    child: Image.asset(
                                  "assets/images/play.png",
                                  height: 40,
                                  color: Colors.red,
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pin Code :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: pincodeController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'Enter Question',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Address :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: addresssController,
                          maxLines: 5,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Remark:",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 13),
                          controller: remarkController,
                          maxLines: 5,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: 'Remark',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (pincodeController.text.isEmpty) {
                  Util.flushBarErrorMessage("Please Enter pin code", context);
                } else if (addresssController.text.isEmpty) {
                  Util.flushBarErrorMessage("Please Enter Address", context);
                } else if (remarkController.text.isEmpty) {
                  Util.flushBarErrorMessage("Please Enter Address", context);
                } else {

                    labEnquiriesFromProvide.labEnquiriesFormApi(
                      context,
                      category.TESTING_TYPE_NAME.toString(),
                      category.AMOUNT,
                      addresssController.text,
                      pincodeController.text,
                      remarkController.text


                      
                      );
            
               }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                color: kgreen,
                child:labEnquiriesFromProvide.loading ? Row(
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
                                  ): Text(
                  "Submit",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
