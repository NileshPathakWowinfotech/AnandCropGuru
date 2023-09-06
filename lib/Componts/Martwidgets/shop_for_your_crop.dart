
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/Martwidgets/shop_for_sub_crop.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../view_model/Mart/shop_for_your_crop_view_model.dart';

class ShopForYourCrop extends StatefulWidget {
  const ShopForYourCrop({super.key});

  @override
  State<ShopForYourCrop> createState() => _ShopForYourCropState();
}

class _ShopForYourCropState extends State<ShopForYourCrop> {
   ShopForYourCropViewModel shopForYourCropViewModel = ShopForYourCropViewModel();
   
   @override
  void initState() {
    shopForYourCropViewModel.shopForYourCroplList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<ShopForYourCropViewModel>(
               create: (BuildContext context) => shopForYourCropViewModel,
               child: Consumer<ShopForYourCropViewModel>(builder: (context, value, _) {
                 switch (value.shopForYourCroplLists.status!) {
                   case Status.LOADING:
                     return const Center(child: CircularProgressIndicator());
                   case Status.ERROR:
                     return Center(child: Text(value.shopForYourCroplLists.message.toString()));
                   case Status.COMPLETED:
                     return value.shopForYourCroplLists.data!.data.isEmpty ? Center(child: Text('Data Not Found'),):
                      ListView.builder(
                        
                        scrollDirection: Axis.horizontal,
                       itemCount: value.shopForYourCroplLists.data!.data.length,
                       shrinkWrap: true,
                       itemBuilder: (context, index) {
                         dynamic item = value.shopForYourCroplLists.data!.data[index];
                         return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(ShopYourCropSubList(item: item,));
                                    },
                                    child: Container(
                                      
                                      height: 60,
                                      width: 60,
                                      child: Material(
                                        elevation: 3.5,
                                        shape: const CircleBorder(),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/crop_ig.png'),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60)),
                                            child: Image.network(
                                             value.shopForYourCroplLists.data!.data[index].cropImage ??
                                                  'uif',
                                              errorBuilder: (context, error,
                                                  stackTrace) {
                                                return Container();
                                              },
                                              fit: BoxFit.cover,
                                              // loadingBuilder: (context, child, loadingProgress) {
                                              //   if(loadingProgress == null) {
                                              //     return child;
                                              //   } else {
                                              //     return Container(color: Colors.white, child: );
                                              //   }
                                              // },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  value.shopForYourCroplLists.data!.data[index].cropName  ??
                                      'Loading',
                                  style: TextStyle(
                                      color:kblack,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            );
                       },
                     );
                 }
                 return Container();
               }),
             );
        
     
    
  }
}
