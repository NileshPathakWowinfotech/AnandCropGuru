import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/post_details.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../Api/postLike.dart';
import '../Componts/my_post.dart';
import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/community_view_model.dart';
import 'add_post_community_page.dart';

class Communitty extends StatefulWidget {
  const Communitty({Key? key}) : super(key: key);

  @override
  State<Communitty> createState() => _CommunittyState();
}

class _CommunittyState extends State<Communitty> with TickerProviderStateMixin {
  CommunityViewModel communityViewModel = CommunityViewModel();
  bool likebtn = false;

  @override
  void initState() {
    communityViewModel.communityListAPi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Util.backgroundImage),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        "Krushi Charcha",
                        style: TextStyle(
                            color: kgrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(AddPostCommunity());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text("ADD POST",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(MyPost());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text("MY POST",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChangeNotifierProvider<CommunityViewModel>(
                  create: (BuildContext context) => communityViewModel,
                  child: Consumer<CommunityViewModel>(
                      builder: (context, value, _) {
                    switch (value.CommunityList.status!) {
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child:
                                Text(value.CommunityList.message.toString()));
                      case Status.COMPLETED:
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Util.backgroundImage))),
                            child: ListView.builder(
                              itemCount: value.CommunityList.data!.data.length,
                              itemBuilder: (context, index) {
                                dynamic item =
                                    value.CommunityList.data!.data[index];
                                //  dynamic sub = value.CommunityList.data!.data[index].pSubCatId;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(13),
                                    elevation: 5,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(PostDetailsScreen(
                                          postId: value.CommunityList.data!
                                              .data[index].postId,
                                          communityListMOdel: item,
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 22,
                                                      backgroundColor: kgreen,
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        child: Image.network(
                                                            value
                                                                .CommunityList
                                                                .data!
                                                                .data[index]
                                                                .profilePhoto,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                          return Image.asset(
                                                            "assets/images/profile.png",
                                                            height: 200,
                                                          );
                                                        }),
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    value.CommunityList.data!
                                                        .data[index].fullName,
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: 20,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: sgreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: kgreen)),
                                                  child: Text(
                                                    value.CommunityList.data!
                                                        .data[index].cropName,
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                value.CommunityList.data!
                                                    .data[index].postName,
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: NetworkImage(value
                                                              .CommunityList
                                                              .data!
                                                              .data[index]
                                                              .postPhoto ==
                                                          ""
                                                      ? "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/134557216-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6"
                                                      : value
                                                          .CommunityList
                                                          .data!
                                                          .data[index]
                                                          .postPhoto),
                                                  fit: BoxFit.fill,
                                                )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              likebtn =
                                                                  !likebtn;

                                                              PostLikeApi.postlikeapi(
                                                                  value
                                                                      .CommunityList
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .userId,
                                                                  value
                                                                      .CommunityList
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .postId);
                                                            });
                                                          },
                                                          child: value
                                                                      .CommunityList
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .myLikeCount ==
                                                                  "0"
                                                              ? Image.asset(
                                                                  "assets/images/like.png",
                                                                  height: 25,
                                                                  color: Colors
                                                                      .orange)
                                                              : Image.asset(
                                                                  "assets/images/like2.png",
                                                                  height: 25,
                                                                  color: Colors
                                                                      .orange),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            value
                                                                .CommunityList
                                                                .data!
                                                                .data[index]
                                                                .myLikeCount
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 1,
                                                    color: kblack,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.message,
                                                            size: 27,
                                                            color:
                                                                Colors.orange),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          value
                                                              .CommunityList
                                                              .data!
                                                              .data[index]
                                                              .totalCommentCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 1,
                                                    color: kblack,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.share,
                                                            size: 25,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          onTap: () {
                                                            Share.share(
                                                                "${value.CommunityList.data!.data[index].postPhoto}  ");
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "Share",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    value.CommunityList.data!
                                                        .data[index].regDate,
                                                    style: TextStyle(
                                                        color: kgreyy,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                    }
                  })),
            ),
          )
        ],
      ),
    );
  }
}
