import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../view_model/offer_view_model.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  OfferViewModel offerViewModel = OfferViewModel();
  @override
  void initState() {
    offerViewModel.offerListAPi();
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
            child: Icon(Icons.arrow_back, color: kgrey)),
        title: Text(
          "Offer's",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ChangeNotifierProvider<OfferViewModel>(
          create: (BuildContext context) => offerViewModel,
          child: Consumer<OfferViewModel>(builder: (context, value, _) {
            switch (value.offerList.status!) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.offerList.message.toString()));
              case Status.COMPLETED:
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Util.backgroundImage))),
                    child: ListView.builder(
                      itemCount: value.offerList.data!.data.length,
                      itemBuilder: (context, index) {
                        dynamic item = value.offerList.data!.data[index].offerId;
                         dynamic sub = value.offerList.data!.data[index].pSubCatId;
                        return Column(
                          children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: (){
                                    Get.to(ProductDetailsScreen(offerId: item,pSubCatId: sub,));
                                    },
                                    child: Material(
                                        elevation: 1,
                                                                  borderRadius: BorderRadius.circular(2),
                                      child: Container(
                                        height:155,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(2),
                                          child: Image.network(
                                            fit: BoxFit.cover,
                                             errorBuilder:
                                                      (context, error, stackTrace) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Image.asset(
                                                          'assets/images/imagenotavailable.jpg',
                                                          fit: BoxFit.cover),
                                                    );
                                                  },
                                            value.offerList.data!.data[index].offerBanner)),
                                      ),
                                    ),
                                  ),
                                )
                          ],
                        );
                      },
                    ));
            }
          })),
    );
  }
}
