import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/blog_view_model.dart';
import '../view_model/CropModels/my_post_view_model.dart';
import 'blogdetails2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class MYPostHomeScreen extends StatefulWidget {
  const MYPostHomeScreen({super.key});

  @override
  State<MYPostHomeScreen> createState() => _MYPostHomeScreenState();
}

class _MYPostHomeScreenState extends State<MYPostHomeScreen> {
  MyPostViewModel myPostViewModel = MyPostViewModel();
  bool like = false;
  @override
  void initState() {
    myPostViewModel.myPosListAPi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ChangeNotifierProvider<MyPostViewModel>(
                create: (BuildContext context) => myPostViewModel,
                child: Consumer<MyPostViewModel>(builder: (context, value, _) {
                  switch (value.myPostList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.myPostList.message.toString()));
                    case Status.COMPLETED:
                      return Column(
                          children: value.myPostList.data!.data.map((doc) {
                        return  Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 12),
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 15, top: 10),
                              width: MediaQuery.of(context).size.width,
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
                                     doc.blogTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        doc.blogImage,
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                            final response = await get(
                                                Uri.parse(doc.blogImage ??
                                                    ' '));
                                            // final bytes = response.bodyBytes;
                                            final Directory temp =
                                                await getTemporaryDirectory();
                                            final File imageFile = File(
                                                '${temp.path}/productImage.jpg');
                                            await Util.validateImage(doc.blogImage)
                                                .then((value) async {
                                              if (value) {
                                                imageFile.writeAsBytesSync(
                                                    response.bodyBytes);
                                              } else {
                                                ByteData bytes =
                                                    await rootBundle.load(
                                                        'assets/images/anand_crop_guru_logo.png');
                                                imageFile.writeAsBytes(
                                                    bytes.buffer.asUint8List(
                                                        bytes.offsetInBytes,
                                                        bytes.lengthInBytes));
                                              }
                                              return value;
                                            });
                                            var widget;
                                            Share.shareFiles(
                                              ['${temp.path}/productImage.jpg'],
                                              text:
                                                  '${Util.stripHtmlIfNeeded(doc.blogTitle ?? '')}\n\n\n'
                                                  'Get more information download this app\n'
                                                  'https://play.google.com/store/apps/details?id=com.cropguru&hl',
                                            );
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Util.endColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
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

                                              like
                                                  ? temp = "like"
                                                  : temp = "deslike";
                                              like
                                                  ? doc.blogLikeCount += 1
                                                  : doc
                                                      .blogLikeCount -= 1;
                                            });

                                            // LikesDeslikeDrPostApi.likesDeslikedrpost(widget.UserId,widget.blogId,temp);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Util.endColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: like == true
                                                    ? Icon(
                                                        Icons
                                                            .thumb_up_off_alt_sharp,
                                                        color: Colors.white,
                                                        size: 15,
                                                      )
                                                    : Icon(
                                                        Icons.thumb_up_outlined,
                                                        color: Colors.white,
                                                        size: 15,
                                                      )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${doc.blogLikeCount} Likes',
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
                                          ' ${doc.blogView} Views',
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
                            );
                          
                      }).toList() // all the children is making an error
                          );
                  }
                }))));
  }
}

    
  
 