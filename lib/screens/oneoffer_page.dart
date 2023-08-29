import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../view_model/CropModels/one_offer_view_model.dart';

class OneOfferPage extends StatefulWidget {
  const OneOfferPage({super.key});

  @override
  State<OneOfferPage> createState() => _OneOfferPageState();
}

class _OneOfferPageState extends State<OneOfferPage> {
  OneOfferViewModel offerViewModel = OneOfferViewModel();
  @override
  void initState() {
    offerViewModel.commeListAPi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OneOfferViewModel>(
        create: (BuildContext context) => offerViewModel,
        child: Consumer<OneOfferViewModel>(builder: (context, value, _) {
          switch (value.OfferList.status!) {
            case Status.LOADING:
              return  Container(height: 170,color: kprimarygreen,);
            case Status.ERROR:
              return Center(child: Text(value.OfferList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.OfferList.data!.data.length,
                itemBuilder: (BuildContext ctx, index) {
                  dynamic item = value.OfferList.data!.data[index];
                  return InkWell(
                    onTap: (){
                      Get.to(ProductDetailsScreen(pSubCatId:value.OfferList.data!.data[index].psubcatId ,offerId: value.OfferList.data!.data[index].offerId,));
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                value.OfferList.data!.data[index].offerImage,
                              ))),
                    ),
                  );
                },
              );
          }
        }));
  }
}
