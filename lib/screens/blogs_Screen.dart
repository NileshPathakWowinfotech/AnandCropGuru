


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/util.dart';
import 'blogdetails2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class BolgsScreen extends StatefulWidget {
   BolgsScreen({Key? key}) : super(key: key);

  @override
  State<BolgsScreen> createState() => _BolgsScreenState();
}

class _BolgsScreenState extends State<BolgsScreen> {
  bool like = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlogList() ,

    );

  }
}



class BlogList extends StatefulWidget {
   BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  bool like = false;

  late Map mapresponse;
  List? listresponse;
  late Map postdetailsmapresponse;
  List? postdetailslistresponse;


  bool isLoaded = false;
  var jsonResponse;

  String? name;

  Future videolist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/HomeScreenNews?USER_ID=21013'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{

          "START": "",
          "END": "5000000000000",
          "LANG_ID": "1",
          "WORD": ""
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
  @override
  void initState() {
    videolist().then((value) {
      setState(() {});
      return value;
    });




    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount:   listresponse == null ? 0 : listresponse!.length,
          shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(BlogDetails2(listresponse![index]["BLOG_ID"],viwes:listresponse![index]["BLOG_VIEW"] ,likes:listresponse![index]["BLOG_LIKE_COUNT"] ,));
            },
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 12),
              padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                listresponse![index]["BLOG_TITLE"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Image.network(

                          listresponse![index]["BLOG_IMAGE"],
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(

                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930",
                            height: 80,
                          );
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final response =
                            await get(Uri.parse(listresponse![index]["BLOG_IMAGE"] ?? ' '));
                            // final bytes = response.bodyBytes;
                            final Directory temp = await getTemporaryDirectory();
                            final File imageFile =
                            File('${temp.path}/productImage.jpg');
                            await Util.validateImage(listresponse![index]["BLOG_IMAGE"]).then((value) async{
                              if(value){
                                imageFile.writeAsBytesSync(response.bodyBytes);
                              } else {
                                ByteData bytes = await rootBundle.load('assets/images/anand_crop_guru_logo.png');
                                imageFile.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                              }
                              return value;
                            });
                            var widget;
                            Share.shareFiles(
                              ['${temp.path}/productImage.jpg'],
                              text:
                              '${Util.stripHtmlIfNeeded(listresponse![index]["BLOG_TITLE"] ?? '')}\n\n\n'
                                  'Get more information download this app\n'
                                  'https://play.google.com/store/apps/details?id=com.cropguru&hl',
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Util.endColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Icon(
                                Icons.share_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            String temp = "";
                            setState(() {
                              like = !like;

                              like ? temp = "like" : temp = "deslike";
                                  like ?   listresponse![index]["BLOG_LIKE_COUNT"] += 1 :   listresponse![index]["BLOG_LIKE_COUNT"] -= 1;
                            });

                            // LikesDeslikeDrPostApi.likesDeslikedrpost(widget.UserId,widget.blogId,temp);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Util.endColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: like == true ? Icon(
                                  Icons.thumb_up_off_alt_sharp,
                                  color: Colors.white,
                                  size: 15,
                                ) : Icon(
                                  Icons.thumb_up_outlined,
                                  color: Colors.white,
                                  size: 15,
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${listresponse![index]["BLOG_LIKE_COUNT"]} Likes',
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          height: 15,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          ' ${listresponse![index]["BLOG_VIEW"]} Views',
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Util.orangee,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}



