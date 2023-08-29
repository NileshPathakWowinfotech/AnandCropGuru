import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/video_view_model.dart';


class FarmingVideos extends StatefulWidget {
  const FarmingVideos({Key? key}) : super(key: key);

  @override
  State<FarmingVideos> createState() => _FarmingVideosState();
}

class _FarmingVideosState extends State<FarmingVideos> {
  VideoViewModel videoViewModel = VideoViewModel();
  @override
  void initState() {
    videoViewModel.videoListAPi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kWhite,
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
          "Video",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ChangeNotifierProvider<VideoViewModel>(
                create: (BuildContext context) => videoViewModel,
                child: Consumer<VideoViewModel>(builder: (context, value, _) {
                  switch (value.videoList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.videoList.message.toString()));
                    case Status.COMPLETED:
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            scrollDirection: Axis.horizontal,
                            itemCount: value.videoList.data!.data.length,
                            itemBuilder: (context, index) {
                              dynamic item = value.videoList.data!.data[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(32),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: CircleAvatar(
                                          radius: 32,
                                          backgroundColor: kWhite,
                                          child: CircleAvatar(
                                            backgroundColor: kWhite,
                                            radius: 31,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                child: Image.network(value
                                                    .videoList
                                                    .data!
                                                    .data[index]
                                                    .qcImg)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(value
                                        .videoList.data!.data[index].qcName)
                                  ],
                                ),
                              );
                            },
                          ));
                  }
                })),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: VideoList(catId: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoList extends StatefulWidget {
  const VideoList({Key? key, this.text, this.image, this.catId})
      : super(key: key);
  final text;
  final image;
  final catId;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  VideoViewModel videoViewModel = VideoViewModel();
  @override
  void initState() {
    videoViewModel.videoPlayListAPi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<VideoViewModel>(
              create: (BuildContext context) => videoViewModel,
              child: Consumer<VideoViewModel>(builder: (context, value, _) {
                switch (value.videoPlayList.status!) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.videoPlayList.message.toString()));
                  case Status.COMPLETED:
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          itemCount: value.videoPlayList.data!.data.length,
                          itemBuilder: (context, index) {
                            dynamic item = value.videoPlayList.data!.data[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [],
                                        ),
                                        Text(
                                         value.videoPlayList.data!.data[index].videoTitle,
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            String? url;
                                            print("hello");

                                            url =
                                                "https://www.youtube.com/watch?v=${value.videoPlayList.data!.data[index].videoUrl.toString()}";
                                            if (await canLaunch(url!)) {
                                              await launch(
                                                url!,
                                                headers: {
                                                  "Content-Type":
                                                      "application/x-www-form-urlencoded",
                                                  "Content-Disposition":
                                                      "inline"
                                                },
                                              );
                                              print("browser url");
                                              print(url);
                                            } else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                          child: Container(
                                            height: 200,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                 Image.network('https://i.ytimg.com/vi/yEDIJODOE58/maxresdefault.jpg'),
                                                Center(child: Image.asset(
                                                  "assets/images/play.png", height: 40,
                                                  color: Colors.red,)),
                                              ],  
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                }
              }));
        
  }
}


