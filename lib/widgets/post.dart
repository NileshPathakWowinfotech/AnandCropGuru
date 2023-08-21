

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';

import '../Api/likes_deslike_dr_post_api.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../utils/util.dart';

class Post extends StatefulWidget {
  final UserId;
  final  title;
  final  imageUrl;
  int likes;
  final  views;
  final blogId;

  Post(this.title, this.imageUrl, this.likes, this.views, this.blogId, this.UserId, {super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    String url = widget.imageUrl;
    String title = widget.title;
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 10),
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
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19
                ),
              )),
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Image.network(

              widget.imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(

                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930",
                  height: 200,
                );
              },
              fit: BoxFit.cover,
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
                  await get(Uri.parse(url ?? ' '));
                  // final bytes = response.bodyBytes;
                  final Directory temp = await getTemporaryDirectory();
                  final File imageFile =
                  File('${temp.path}/productImage.jpg');
                  await Util.validateImage(url).then((value) async{
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
                    '${Util.stripHtmlIfNeeded(title ?? '')}\n\n\n'
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
                onTap: (){
                  String temp = "";
                  setState(() {
                    like = !like;
                    like ? temp="like" : temp="deslike";
                    like ? widget.likes += 1 : widget.likes -= 1;
                   });

                  LikesDeslikeDrPostApi.likesDeslikedrpost(widget.UserId,widget.blogId,temp);
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
                    child: like== true || widget.likes == "Yes" ?Icon(
                      Icons.thumb_up_off_alt_sharp,
                      color: Colors.white,
                      size: 15,
                    ):Icon(
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
                '${widget.likes} Likes',
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
                '${widget.views} Views',
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
    );
  }
}
