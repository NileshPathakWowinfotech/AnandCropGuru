

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:share_plus/share_plus.dart';
import '../services2.dart';
import '../utils/Colors.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/util.dart';

class BlogDetails extends StatefulWidget {
  int blogId;
  final viwes;
  final likes;

   BlogDetails(this.blogId, {Key? key, this.viwes, this.likes}) : super(key: key);

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  bool like = false;

  Map<String, dynamic>? responses;

  void getDetails() async{
    responses = await Services2.getBlogDetails(widget.blogId.toString()).then((value) {
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
      body: Column(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Util.newHomeColor, Util.endColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,
                                  size:
                                  30, color: kWhite)),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "Blog Details",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final response =
                              await get(Uri.parse(responses!['BLOG_IMAGE'] ?? ' '));
                              // final bytes = response.bodyBytes;
                              final Directory temp = await getTemporaryDirectory();
                              final File imageFile =
                              File('${temp.path}/productImage.jpg');
                              await Util.validateImage(responses!['BLOG_IMAGE']).then((value) async{
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
                                '${Util.stripHtmlIfNeeded(responses!['BLOG'] ?? '')}\n\n\n'
                                    'Get more information download this app\n'
                                    'https://play.google.com/store/apps/details?id=com.cropguru&hl',
                              );
                            },
                            child: Icon(
                              Icons.share_sharp,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            height: 35,
                            width: 35,
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
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: responses != null ? Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(responses!['BLOG_IMAGE'] ?? ' ' ,width: MediaQuery.of(context).size.width, height: 300, fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930",
                          height: 300,width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth
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
                  "${widget.likes} like",
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
                              "${widget.viwes} views",
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
