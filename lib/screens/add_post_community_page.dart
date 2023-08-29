
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../Api/add_post_community_api.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class AddPostCommunity extends StatefulWidget {
  const AddPostCommunity({Key? key}) : super(key: key);

  @override
  State<AddPostCommunity> createState() => _AddPostCommunityState();
}

class _AddPostCommunityState extends State<AddPostCommunity>   with TickerProviderStateMixin {
  File? image;
  dynamic imageData = "";
  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());
      setState(() {});
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final anandcenter = GlobalKey<FormState>();

  late Map mapresponse;
  List? listresponse;
  bool isLoaded = false;
  bool likebtn  = false;
  int? _value3;
  String cropNameGlobal = '';
  String cropId = '';
  late AnimationController _controller;
  var jsonResponse;
  Future varietylist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/CropMaster'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": 0,
          "END": 10000,
          "WORD": "NONE",
          "LANG_ID": 3,
          "USER_ID": 60640,
          "ACCESS_TOKEN": "123456"
        }));
    jsonResponse = json.decode(response.body);

    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(response.body);


      mapresponse = json.decode(response.body);
      listresponse = mapresponse["DATA"];
      isLoaded = true;
    }
  }

  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
    });
    varietylist().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    varietylist();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: kgrey)),
        title: Text(
         "Add Post",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(  
                image: DecorationImage(  
                  image: AssetImage(Util.backgroundImage)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                    key: anandcenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),



                        SizedBox(height: 10,),
                        Text(
                          "Title :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: titleController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'Shop Name / Company Name',
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
                              return "Title";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Select crop :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        productName(),

                        SizedBox(height: 10,),
                        Text(
                          "Description :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                         controller: addressController,
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
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Address";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
                        Text(
                          "Photo :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
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



                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){

              if (anandcenter.currentState!.validate()) {

                AddPostCommunittyApi.addpostapi(cropId,addressController.text,titleController.text,"62819",imageData);
               // Navigator.pop(context);

              }else{

              }

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                color: kgreen,
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,

                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget productName() {
    // final cityapi = Provider.of<CityApiProvider>(context);


    return DropdownButtonHideUnderline(

      child: ButtonTheme(

          alignedDropdown: true,
          child: DropdownButtonFormField(

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            ),
            value: _value3,

            hint: Text(
              "Select Crop",
              style: TextStyle(fontSize: 12, color: kgreyy),
            ),
            isExpanded: true,

            items: listresponse?.map((product) {


              return DropdownMenuItem(
                onTap: (){
                  cropNameGlobal= product["CROP_NAME"].toString();
                  cropId= product["CROP_ID"].toString();
                },
                child: Text(product["CROP_NAME"]),
                value: product,
              );
            }).toList(),
            onChanged: (value) {
              print(cropNameGlobal);
              print(cropId);
              setState(() {
                _value3 = value as int;
              });
              print("Selected list demo is  $_value3");
            },

          )),
    );
  }
}


