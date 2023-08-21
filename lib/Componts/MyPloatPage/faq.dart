import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/repository_of_knowledge.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/faq_view_model.dart';
import 'my_crop.dart';

class FAQ extends StatefulWidget {
  FAQ({Key? key, this.cropId, this.plotID, this.userID}) : super(key: key);
  final cropId;
  final plotID;
  final userID;


  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> with TickerProviderStateMixin {
  FaqViewModel faqviewmodel = FaqViewModel();

  late Map schedulemapresponse;
  List? schedulelistresponse;
  late Map faqemapresponse;
  List? faqlistresponse;
  late AnimationController _controller;

  var jsonResponse;
  var faqjsonResponse;
  String? massage = "";
  String? data;

  bool flag = false;

  bool isLoaded = false;

  Future faqapi() async {
    http.Response response;
    response = await http.post(
        Uri.parse('https://mycropguruapiwow.cropguru.in/api/Question'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "0",
          "END": "35000",
          "WORD": "NONE",
          "LANG_ID": "1",
          "CROP_ID": "3",
          "ACCESS_CODE": "123456",
          "USER_ID": widget.userID,
          "TYPE": "User",
          "PLOT_ID": widget.plotID
        }));
    jsonResponse = json.decode(response.body);
    massage = jsonResponse["ResponseMessage"];
    print(jsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      schedulemapresponse = json.decode(response.body);
      schedulelistresponse = schedulemapresponse["DATA"];
      print(schedulelistresponse![0]["SCHEDUEL_ID"]);
      isLoaded = true;
    }
  }

  Future treelist() async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            'https://mycropguruapiwow.cropguru.in/api/Question?CAT_ID=41'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "START": "0",
          "END": "35000",
          "WORD": "NONE",
          "LANG_ID": "1",
          "CROP_ID": "3",
          "ACCESS_CODE": "123456",
          "USER_ID": widget.userID,
          "TYPE": "User",
          "PLOT_ID": widget.plotID
        }));
    faqjsonResponse = json.decode(response.body);
    massage = faqjsonResponse["ResponseMessage"];
    print(faqjsonResponse["ResponseMessage"]);
    if (response.statusCode == 200) {
      faqemapresponse = json.decode(response.body);
      faqlistresponse = faqemapresponse["DATA"];
      data = faqemapresponse["DATA"];

      isLoaded = true;
    }
  }

  @override
  void initState() {
   // faqviewmodel.faqListApi(it);
    // _controller = AnimationController(
    //   duration: const Duration(
    //       milliseconds: 3000),
    //   vsync: this,
    // );
    // _controller.addListener(() {
    //   if (_controller.isCompleted) {
    //     _controller.reset();
    //     _controller.forward();
    //   }
    // });
    // WidgetsBinding.instance
    //     .addPostFrameCallback(
    //         (timeStamp) {
    //       Util.animatedProgressDialog(
    //           context, _controller);
    //       _controller.forward();
    //     });
    // faqapi().then((value) {
    //   _controller.reset();
    //   Navigator.pop(context);
    //   setState(() {});
    //   return value;
    // });
    //
    //
    // faqapi().then((value) {
    //   setState(() {});
    //   return value;
    // });

    // faqapi().then((value) {
    //   setState(() {});
    //
    //   treelist().then((value) {
    //     setState(() {});
    //     return value;
    //   });
    //   unitapi().then((value) {
    //     setState(() {});
    //     return value;
    //   });
    //
    //   return value;
    // });
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      child: InkWell(
                        child: Icon(
                          Icons.arrow_back,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          treelist();
                        },
                        child: Text(
                          "Schedule",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kWhite),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                    height: 120,
                    child: ChangeNotifierProvider<FaqViewModel>(
                        create: (BuildContext context) =>
                            faqviewmodel,
                        child: Consumer<FaqViewModel>(
                            builder: (context, value, _) {
                          switch (value.faqlist.status!) {
                            case Status.LOADING:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.faqlist.message
                                      .toString()));
                            case Status.COMPLETED:
                              return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              Util.backgroundImage))),
                                  child: ListView.builder(
                                    itemCount: value
                                        .faqlist.data!.data.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets
                                                .symmetric(
                                            horizontal: 18),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.orange,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                child: Image.network(
                                                  value
                                                      .faqlist
                                                      .data!
                                                      .data[index]
                                                      .qcImg,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Text(
                                              value.faqlist.data!
                                                  .data[index].qcName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  color: kWhite),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ));
                          }
                        })))
              ]),
              // .
            ]),
                    ));
  }

  Widget list() {
    // final List<Map> myProducts =
    //     List.generate(10, (index) => {"id": index, "name": "Product $index"})
    //         .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4.00,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: faqlistresponse == null ? 0 : faqlistresponse!.length,
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          onTap: () {
            // Get.to(RepositoryOfKnowledge(
            //   firstname: faqlistresponse![index]["Q_NAME"],
            //   image: faqlistresponse![index]["Q_IMG"],
            //   text: faqlistresponse![index]["Q_ANSWER"],
            // ));
          },
          child: Container(
            margin: const EdgeInsets.all(0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: kgrey,
                  blurRadius: 2,
                  spreadRadius: 1,
                )
              ],
              image: DecorationImage(
                image: NetworkImage(faqlistresponse![index]["Q_IMG"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "  प्र ${faqlistresponse![index]["Q_NAME"]}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
