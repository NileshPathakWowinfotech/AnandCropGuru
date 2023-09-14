
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/community_view_model.dart';

class CommunityComment extends StatefulWidget {
  const CommunityComment({super.key, this.userID});
  final userID;

  @override
  State<CommunityComment> createState() => _CommunityCommentState();
}

class _CommunityCommentState extends State<CommunityComment> {
    CommunityViewModel communityViewModel = CommunityViewModel();
    @override
  void initState() {
    communityViewModel.commentListAPi(widget.userID);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<CommunityViewModel>(
        create: (BuildContext context) => communityViewModel,
        child: Consumer<CommunityViewModel>(builder: (context, value, _) {
          switch (value.CommentList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(
                  child: Text(value.CommentList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.CommentList.data!.data.length,
                itemBuilder: (context, index) {
                  dynamic item = value.CommentList.data!.data[index];
                  //  dynamic sub = value.CommunityList.data!.data[index].pSubCatId;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Image.network(
                              value.CommentList.data!.data[index].profilePhoto,
                                errorBuilder:
                                    (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/profile.png",
                                height: 200,
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                               value.CommentList.data!.data[index].fullName,
                              style: TextStyle(
                                color: kblack,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                               value.CommentList.data!.data[index].regDate,
                              style:
                                  TextStyle(color: kgrey, fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              maxLines: 3,
                               value.CommentList.data!.data[index].comment,
                              style:
                                  TextStyle(color: kblack, fontSize: 12),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    100,
                                child: Divider(
                                  thickness: 0,
                                  color: kblack,
                                ))
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
          }
        }));
  }
}