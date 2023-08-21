import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/home_view_model.dart';
import 'add_anand_bichem_r_d_center.dart';
import 'laboratory/lab_list.dart';
import 'laboratory/lab_tab.dart';
import 'laboratory/tab_homePage.dart';

class AnandBiochemRandDCenter extends StatefulWidget {
  const AnandBiochemRandDCenter({Key? key}) : super(key: key);

  @override
  State<AnandBiochemRandDCenter> createState() =>
      _AnandBiochemRandDCenterState();
}

class _AnandBiochemRandDCenterState extends State<AnandBiochemRandDCenter>
    with TickerProviderStateMixin {
  HomeViewViewModel labcenterdevolpment = HomeViewViewModel();
  @override
  void initState() {
    labcenterdevolpment.labTestingType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimarygreen,
        title: Image.asset(
          Util.backgroundImage,
          height: 40,
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            width: 130,
            height: 38,
            decoration: BoxDecoration(
                color: klgreen, borderRadius: BorderRadius.circular(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                          left: 8,
                          top: 10,
                          child: Image.asset(
                            "assets/images/trophy.png",
                            color: lgreen,
                            height: 20,
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 10,
                        child: Icon(
                          Icons.notifications,
                          color: lgreen,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 10,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: lgreen,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back_all.png'))),
        child: Column(
          children: [
            Image.asset('assets/images/labb_img.png'),
            Expanded(
              child: ChangeNotifierProvider<HomeViewViewModel>(
                create: (BuildContext context) => labcenterdevolpment,
                child:
                    Consumer<HomeViewViewModel>(builder: (context, value, _) {
                  switch (value.movieslLists.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.movieslLists.message.toString()));
                    case Status.COMPLETED:
                      return GridView.builder(
                        itemCount: value.movieslLists.data!.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.5,
                          crossAxisCount: 2, // Number of columns in the grid
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          dynamic item = value.movieslLists.data!.data[index];
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: kWhite,
                                    radius: 35,
                                    child: CircleAvatar(
                                      radius: 90,
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            // color: kblack,
                                            image: DecorationImage(
                                                image: NetworkImage(value
                                                    .movieslLists
                                                    .data!
                                                    .data[index]
                                                    .testingImg
                                                    .toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(TabHomePage(
                                      item: item,
                                    ));
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  value.movieslLists.data!.data[index]
                                      .testingTypeName
                                      .toString(),
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                  }
                  return Container();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
