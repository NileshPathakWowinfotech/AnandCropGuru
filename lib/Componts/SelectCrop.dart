

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/myplot_view_model/crop_list_view_model.dart';

class SelecctCrop extends StatefulWidget {
   SelecctCrop({Key? key}) : super(key: key);

  @override
  State<SelecctCrop> createState() => _SelecctCropState();
}

class _SelecctCropState extends State<SelecctCrop> {
  CropAddListViewModel selectCropViewModel = CropAddListViewModel();
  

  @override
  void initState() {
     selectCropViewModel.addPlotListListView();
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
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: kgrey,)),
        title: Text('Select crop',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kgrey),),
      ),
      body: Container(
        decoration: BoxDecoration( 
          image: DecorationImage( 
            image: AssetImage(Util.backgroundImage),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: klgreen3,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    // top: 5,
                    right: 15,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Util.colorPrimary, fontSize: 13),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Util.colorPrimary,
                    ),
                    ),
                  ),
                ),
                
              ],
            ),
      SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Column( 
                  children: [ 
                     ChangeNotifierProvider<CropAddListViewModel>(
                        create: (BuildContext context) => selectCropViewModel,
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                  ],
                ),
              ),
            )
        ]
        ),
      )
        );
  }
}
                  
                
              
            
           
              



          
        
      
    
  

 



//  ChangeNotifierProvider<HomeViewViewModel>(
//                create: (BuildContext context) => listLabView,
//                child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
//                  switch (value.lablist.status!) {
//                    case Status.LOADING:
//                      return const Center(child: CircularProgressIndicator());
//                    case Status.ERROR:
//                      return Center(child: Text(value.lablist.message.toString()));
//                    case Status.COMPLETED:
//                      return ListView.builder(
//                        itemCount: value.lablist.data!.data.length,
//                        shrinkWrap: true,
//                        itemBuilder: (context, index) {
//                          dynamic item = value.lablist.data!.data[index];
//                          return Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Material(
//                              elevation: 5,
//                              borderRadius: BorderRadius.circular(8),
//                              child: Container(
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(8),
//                                ),
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: [
//                                      Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Row(
//                                            children: [
//                                              Text(
//                                                'Enquiry ID :  ',
//                                                style: TextStyle(
//                                                  color: kgreyy,
//                                                ),
//                                              ),
//                                              Text(
//                                                value
//                                                    .lablist.data!.data[index].enquiryId
//                                                    .toString(),
//                                                style: TextStyle(
//                                                  color: kblack,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                          Container(
//                                              alignment: Alignment.center,
//                                              height: 32,
//                                              width: 70,
//                                              decoration: BoxDecoration(
//                                                color: Colors.yellow,
//                                                borderRadius: BorderRadius.circular(16),
//                                              ),
//                                              child: Text(
//                                                'Active',
//                                                style: TextStyle(
//                                                    fontWeight: FontWeight.bold,
//                                                    color: kWhite,
//                                                    fontSize: 15),
//                                              )),
//                                        ],
//                                      ),
//                                      Row(
//                                        children: [
//                                          Text(
//                                            'Amount :',
//                                            style: TextStyle(
//                                              color: kgreyy,
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: 2,
//                                          ),
//                                          Text(
//                                            '₹ ${value.lablist.data!.data[index].amount.toString()}',
//                                            style: TextStyle(
//                                              color: kgreen,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Row(
//                                        children: [
//                                          Text(
//                                            'Category :',
//                                            style: TextStyle(
//                                              color: kgreyy,
//                                            ),
//                                          ),
//                                          SizedBox(
//                                            width: 2,
//                                          ),
//                                          Text(
//                                            value.lablist.data!.data[index]
//                                                .testingCategory
//                                                .toString(),
//                                            style: TextStyle(
//                                              color: kgreen,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Row(
//                                        children: [
//                                          Text(
//                                            'Remark :',
//                                            style: TextStyle(
//                                                fontWeight: FontWeight.bold,
//                                                color: kblack),
//                                          ),
//                                          SizedBox(
//                                            width: 2,
//                                          ),
//                                          Text(
//                                            value.lablist.data!.data[index].remark
//                                                .toString(),
//                                            style: TextStyle(
//                                              color: kgreen,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 5,
//                                      ),
//                                      Text(
//                                        'Admin Remark :  ${value.lablist.data!.data[index].adminRemark.toString()}',
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.bold, color: kblack),
//                                      ),
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        crossAxisAlignment: CrossAxisAlignment.end,
//                                        children: [
//                                          Text(
//                                            value.lablist.data!.data[index].regDate
//                                                .toString(),
//                                            style: TextStyle(
//                                                fontWeight: FontWeight.bold,
//                                                color: kblack),
//                                          ),
//                                        ],
//                                      )
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                          );
//                        },
//                      );
//                  }
//                  return Container();
//                }),
//              )