

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../data/Model/CropModels/blog_model.dart';
import '../services2.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class BlogDetails2 extends StatefulWidget {
 final BlogsModels item;
 


  BlogDetails2( {Key? key, required this.item}) : super(key: key);

  @override
  State<BlogDetails2> createState() => _BlogDetails2State();
}

class _BlogDetails2State extends State<BlogDetails2> {
  bool like = false;
  Map<String, dynamic>? responses;
  void getDetails() async{
    responses = await Services2.getBlogDetails2(widget.item.blogId.toString()).then((value) {
      setState(() {
        responses = value;
      });
      return value;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDetails();
    });
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
          "Blogs Details",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: kgreen,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: like== true ?Icon(
                                Icons.thumb_up_off_alt_sharp,
                                color: Colors.white,
                                size: 25,
                              ):Icon(
                                Icons.thumb_up_outlined,
                                color: Colors.white,
                                size: 25,
                              )
                          ),
                        ),
           ),
        ],
      ),
        body: Column(
          children: [
            Expanded(
              child: responses != null ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(responses!['BLOG_IMAGE'] ?? ' ' ,width: MediaQuery.of(context).size.width, height: 300, fit: BoxFit.fitWidth,  errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930",
                          height: 200,
                        );
                      },) ,
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thumb_up_off_alt_sharp,
                                color: kgreyy,
                                size: 16,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "${widget.item.blogLikeStatus} like",
                                style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),


                            ],
                          ),
                          SizedBox(width: 5,),
                          Container(height: 20,width: 1,color: kblack,),
                          SizedBox(width: 5,),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 17,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "${widget.item.blogView} views",
                                style: TextStyle(
                                    color: kgreyy,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),


                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          responses!['BLOG_TITLE'] ?? ' ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),


                        child: Html(
                          data: responses!['BLOG'] ?? ' ',

                        ),
                      )

                    ],
                  ),
                ),
              ) : Center( child: Text('Loading details...'),),
            )
          ],
        )
    );
  }
}
