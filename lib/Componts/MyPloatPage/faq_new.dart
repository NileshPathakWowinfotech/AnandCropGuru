import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/repository_of_knowledge.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../view_model/myplot_view_model/faq_view_model.dart';

class Faq extends StatefulWidget {
  Faq({super.key, required this.item});
  final PlotModel item;

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  FaqViewModel faqviewmodel = FaqViewModel();
  String? catID;

  @override
  void initState() {
    faqviewmodel.faqListApi(widget.item.userId, widget.item.plotId);
     faqviewmodel.faqSubListApi(41);
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
            child: Icon(
              Icons.arrow_back,
              color: kgrey,
              size: 25,
            ),
          ),
          title: Text(
            "FAQ",
            style: TextStyle(
                color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Util.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(

              child: Column(children: [
                SizedBox(
                  height: 100,
                  child: Row(children: [
                    ChangeNotifierProvider<FaqViewModel>(
                        create: (BuildContext context) => faqviewmodel,
                        child:
                            Consumer<FaqViewModel>(builder: (context, value, _) {
                          switch (value.faqlist.status!) {
                            case Status.LOADING:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case Status.ERROR:
                              return Center(
                                  child: Text(value.faqlist.message.toString()));
                            case Status.COMPLETED:
                              return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(Util.backgroundImage))),
                                  child: ListView.builder(
                                    itemCount: value.faqlist.data!.data.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                     
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                 faqviewmodel.faqSubListApi(value.faqlist.data!.data[index].qcId);
                                              },
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.orange,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    value.faqlist.data!.data[index].qcImg,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Text(
                                              value.faqlist.data!.data[index]
                                                  .qcName,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: kblack),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ));
                          }
                        }))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: list(),
                )
              ]),
            )));
  }

  Widget list() {
    // final List<Map> myProducts =
    //     List.generate(10, (index) => {"id": index, "name": "Product $index"})
    //         .toList();

    return ChangeNotifierProvider<FaqViewModel>(
        create: (BuildContext context) => faqviewmodel,
        child: Consumer<FaqViewModel>(builder: (context, value, _) {
          switch (value.faqSublist.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.faqSublist.message.toString()));
            case Status.COMPLETED:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    childAspectRatio: 3.50 / 4.00,
                    crossAxisSpacing: 19,
                    mainAxisSpacing: 15),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.faqSublist.data!.data.length,
                itemBuilder: (BuildContext ctx, index) {
                   dynamic item = value.faqSublist.data!.data[index];
                  return InkWell(
                    onTap: () {
                      Get.to(RepositoryOfKnowledge(submodel: item,
                     
                      ));
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
                          image: NetworkImage(value.faqSublist.data!.data[index].qImg), 
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  )),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "  प्र ${value.faqSublist.data!.data[index].qName}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        }));
  }
}
