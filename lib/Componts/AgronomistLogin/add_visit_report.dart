import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Componts/AgronomistLogin/view_templates.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api/add_visit_api.dart';
import '../../utils/Colors.dart';
class AddVisitReporrt extends StatefulWidget {
  const AddVisitReporrt({Key? key}) : super(key: key);

  @override
  State<AddVisitReporrt> createState() => _AddVisitReporrtState();
}

class _AddVisitReporrtState extends State<AddVisitReporrt> {
  final _addreport = GlobalKey<FormState>();
  dynamic imageData = "";
  TextEditingController  title_Controller = TextEditingController();
  TextEditingController description_Controller = TextEditingController();

  File? image;
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());
      print(imageData);
      setState(() {});
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kgreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text("Add visit Report",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,  color: Colors.white,)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
               Get.to(ViewTemplates());
              },
              child: Container(
                alignment: Alignment.center,
                height: 20,
                width: 120,
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                  color: kWhite
                ),
                child: Text("View Templates",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,  color: kgreen,)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _addreport,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 14,),
                      Text(
                        'Title :',
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12,),
                      TextFormField(

                        controller: description_Controller,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Title',
                          border: OutlineInputBorder(

                            borderSide: BorderSide(
                              //  color: Util.colorPrimary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Title can not be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Select Image :",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 13,),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40))),
                              context: context,
                              builder: (BuildContext mContext) {
                                return Container(
                                  height: 140,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            PickImageImag(ImageSource.gallery),
                                        child: Image.asset(
                                          "assets/images/gallary.png",
                                          height: 90,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            PickImageImag(ImageSource.camera),
                                        child: Image.asset(
                                          "assets/images/camera.png",
                                          height: 45,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: image != null
                                ? Image.file(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              image!,
                              fit: BoxFit.fitWidth,
                            )
                                : Image.asset(
                              width: 40,
                              height: 40,
                              "assets/images/camera.png",
                              color: kgreen,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15,),
                      Text(
                        'Description',
                        style: TextStyle(
                            color: kblack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: description_Controller,
                        maxLines: 5,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              //  color: Util.colorPrimary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Description can not be empty";
                          }
                          return null;
                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              AddvisitReport.addvisitreport("","","");
    if (_addreport.currentState!.validate()) {


    }else{
    Fluttertoast.showToast(
    msg: "Please select report image",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kblack,
    textColor: kWhite,
    fontSize: 13.0,
    );
    }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: kgreen,
              child:  Text(
                "Submit",
                style: TextStyle(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),

            ),
          )

        ],
      ),
    );
  }
}
