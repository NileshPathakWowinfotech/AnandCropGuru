import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/myplot_view_model/crop_list_view_model.dart';

class MyApiNestedList extends StatefulWidget {
  @override
  _MyApiNestedListState createState() => _MyApiNestedListState();
}

class _MyApiNestedListState extends State<MyApiNestedList> {
  CropAddListViewModel nilw = CropAddListViewModel();
  final int rowCount = 3;
  final int columnCount = 2;
  @override
  void initState() {
    nilw.addPlotListListView();
    super.initState();
    // fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API Nested List with Visibility'),
        ),
        body: ChangeNotifierProvider<CropAddListViewModel>(
          create: (BuildContext context) => nilw,
          child: Consumer<CropAddListViewModel>(
            builder: (context, value, _) {
              switch (value.CropAddList.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.CropAddList.message.toString()));
                case Status.COMPLETED:
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Util.backgroundImage))),
                      child: ListView.builder(
                        itemCount: value.CropAddList.data!.data.length,
                        itemBuilder: (context, index) {
                          final cropCategory =
                              value.CropAddList.data!.data[index];
                          return Container(
                            // Adjust margin as needed
                            decoration: BoxDecoration(
                              border: Border(
                             bottom: BorderSide(width: 0, color: kblack),
                            ),
                            ),
                            child: ExpansionTile(
                              leading: Material(
                                borderRadius: BorderRadius.circular(100),
                                elevation: 5,
                                child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: kWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/imagenotavailable.jpg',
                                                  fit: BoxFit.fitWidth);
                                            },
                                            value.CropAddList.data!.data[index]
                                                .cropcatImage,
                                            height: 25,
                                          )),
                                    )),
                              ),
                              title: Text(cropCategory.cropcatName),
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1.1,
                                          mainAxisSpacing: 0),
                                  itemCount: cropCategory.cropList.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, cropIndex) {
                                    final crop =
                                        cropCategory.cropList[cropIndex];
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            elevation: 5,
                                            child: CircleAvatar(
                                                radius: 35,
                                                backgroundColor: kWhite,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.network(
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/imagenotavailable.jpg',
                                                            fit: BoxFit
                                                                .fitWidth);
                                                      },
                                                      crop.cropImage,
                                                      height: 70,
                                                    ))),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(crop.cropName),
                                          
                                        ],
                                      ),
                                    );
                                  },
                                ),
                               
                              ],
                            ),
                          );
                        },
                      ));
              }
            },
          ),
        ),
        floatingActionButton: Container(
          height: 70.0,
          width: 90.0,
          child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Text("AddReport",
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                onPressed: () {
                  //  Get.to(Add_Report(item: widget.item));
                  //Get.to(AddYourQuestion());
                }),
          ),
        ));
  }
}
