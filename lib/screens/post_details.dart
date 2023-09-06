

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Api/comment_post_api.dart';
import '../Api/postLike.dart';
import '../Componts/GoogleMapLocattion/google_map.dart';
import '../data/Model/CropModels/community_model.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key, required this.communityListMOdel,}) : super(key: key);

   final CommunityListMOdel communityListMOdel;
   

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> with TickerProviderStateMixin{
  
  bool like = false;

  late Map mapresponse;
  TextEditingController commentController = TextEditingController();
  List? listresponse;
  bool isLoaded = false;
  late AnimationController _controller;
  var jsonResponse;
  Future commentapi() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'http://mycropguruapiwow.cropguru.in/api/Get_Data'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "START": "0",
          "END" : 10000,
          "WORD": "NONE",
          "GET_DATA": "Get_AllPostCommentsByPostId",
          "ID1":"21013",
          "ID2": "",
          "ID3": "",
          "STATUS": "",
          "START_DATE": "",
          "END_DATE": "",
          "EXTRA1": "",
          "EXTRA2" :"",
          "EXTRA3" : "",
          "LANG_ID": "1"
        }));

    jsonResponse = json.decode(response.body);
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      print(widget.communityListMOdel.userId);

      mapresponse = json.decode(response.body);
      listresponse = mapresponse["DATA"];
      isLoaded = true;
    }
    widget.communityListMOdel.userId.toString();
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
    commentapi().then((value) {
      _controller.reset();
      Navigator.pop(context);
      setState(() {});
      return value;
    });
    commentapi();
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
        title: InkWell(
          onTap: (){
            commentapi();
          },
          child: Text(
            "Post Details",
            style: TextStyle(
                color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: kgreen,
                            child: CircleAvatar(
                              radius: 20,
                              child: Image.network(widget.communityListMOdel.profilePhoto, errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/profile.png",
                                  height: 200,
                                );
                              })
                          ),),
                          SizedBox(width: 8,),
                          Text(widget.communityListMOdel.fullName, style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,),

                      Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                              color: sgreen,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kgreen)

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(widget.communityListMOdel.cropName, style: TextStyle(
                                color: kblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          )),
                      SizedBox(height: 8,),

                      Text(widget.communityListMOdel.postName, style: TextStyle(
                          color: kblack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 12,),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(

                            image: DecorationImage(image: NetworkImage(
                            widget.communityListMOdel.postPhoto == null? "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/134557216-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6":   widget.communityListMOdel.postPhoto),
                                fit: BoxFit.fill)
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: [
                                InkWell(
                                  onTap: (){

                                  setState(() {
                                    like= !like;
                                    PostLikeApi.postlikeapi(widget.communityListMOdel.userId,widget.communityListMOdel.postId);
                                  });
                                  print("true");
                                  },
                                  child: like == true ?Image.asset("assets/images/like2.png",
                                    height: 25, color: kgreen): Image.asset("assets/images/like.png", height: 25, color: kgreen),
                                ),
                                SizedBox(width: 5,),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5),
                                  child: Text( "Like", style: TextStyle(
                                      color: kblack, fontSize: 17),),
                                ),

                              ],
                            ),
                          ),


                          Container(
                            height: 40, width: 1, color: kblack,),
                          SizedBox(width: 2,),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: [
                                Icon(Icons.share, size: 25,
                                  color: kgreen,),
                                SizedBox(width: 8,),
                                Text("Share", style: TextStyle(
                                    color: kblack, fontSize: 16),),

                              ],
                            ),
                          ),

                        ],
                      ),
                      Text("${widget.communityListMOdel.myLikeCount} Likes",style: TextStyle(color: kblack,fontSize: 12 , fontWeight: FontWeight.bold),),
                      Text(widget.communityListMOdel.postDescription,style: TextStyle(fontSize: 12 ),),
                      SizedBox(height: 8,),
                      Text(widget.communityListMOdel.regDate,style: TextStyle(color: kblack,fontSize: 12 ),),
                      SizedBox(height: 8,),
                      Text("Comments",style: TextStyle(color: Colors.orange,fontSize: 15,fontWeight: FontWeight.bold ),),
                      SizedBox(height: 5,),
                      Container(
                        height: 200,

                width: 200,                       
                 child: commentslist()),
                    ],
                  ),
                ),
              ),
            ),

              ) ,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: TextFormField(
                     controller: commentController,
                      maxLines: 5,
                      onChanged: (value) {},
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Enter your Comments',
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
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){
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
                    CommentPostApi.commentpostapi(commentController.text,widget.communityListMOdel.postId,widget.communityListMOdel.userId).then((value) {
                      _controller.reset();
                      Navigator.pop(context);
                      setState(() {});
                      return value;
                    });
                    commentController.clear();
                    commentapi();

                  },
                    child: Icon(Icons.send,size: 45,color: kgreen,)),
              ],
            ),
          ),
          SizedBox(height: 5,)
        ],
      ),
    );

  }
   Widget commentslist(){
    return Visibility(
      visible: isLoaded,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return
            Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.network(listresponse![index]["PROFILE_PHOTO"].toString(),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/profile.png",
                              height: 200,
                            );
                          }
                      ),

                    ),
                  ],
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listresponse![index]["FULL_NAME"].toString(),
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text( listresponse![index]["REG_DATE"].toString(),

                        style: TextStyle(color: kgrey, fontSize: 12),),
                      SizedBox(height: 2,),
                      Text(maxLines:3,
                        listresponse![index]["COMMENT"].toString(), style: TextStyle(color: kblack, fontSize: 12),),
                      SizedBox( width :MediaQuery.of(context).size.width-100,child: Divider(thickness: 0, color: kblack,))




                    ],
                  ),
                )
              ],


            );
        },itemCount: listresponse == null ? 0 : listresponse!.length,
      ),
    );
  }

}
