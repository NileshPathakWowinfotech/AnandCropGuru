import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/krushi_view_model.dart';
import 'product_details_screen.dart';

class KurshiProductSCreen extends StatefulWidget {
  const KurshiProductSCreen({super.key});

  @override
  State<KurshiProductSCreen> createState() => _KurshiProductSCreenState();
}

class _KurshiProductSCreenState extends State<KurshiProductSCreen> {
  KrushiViewModel  krushiViewModel = KrushiViewModel();
  @override
  void initState() {
    krushiViewModel.krushiListAPi();
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
          "Product",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage( 
            image: AssetImage(Util.backgroundImage),
            fit: BoxFit.cover
          ),
                      color: kWhite, borderRadius: BorderRadius.circular(5)),
        child: ChangeNotifierProvider<KrushiViewModel>(
        create: (BuildContext context) => krushiViewModel,
        child: Consumer<KrushiViewModel>(builder: (context, value, _) {
          switch (value.krushiList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.krushiList.message.toString()));
            case Status.COMPLETED:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170,
                    childAspectRatio: 3.20 / 4.00,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0),
                shrinkWrap: true,
                itemCount: value.krushiList.data!.data.length,
                itemBuilder: (BuildContext ctx, index) {
                   dynamic item = value.krushiList.data!.data[index];
                    dynamic price = value.krushiList.data!.data[index].price ;
                  dynamic discount = value.krushiList.data!.data[index].discount ;
                    dynamic percentage = discount/price * 100;
                     dynamic priceWithDiscount =  price - discount;
                     
                   print(percentage);
                  return  Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                   Get.to(ProductDetailsScreen(
                    ProductdId: value.krushiList.data!.data[index].productId ,
                    offerId: value.krushiList.data!.data[index].productId ,pSubCatId:value.krushiList.data!.data[index].psubcatId ,));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: kWhite, borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 21,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Util.newHomeColor,
                                          Util.endColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    '${percentage.toStringAsFixed(0)}% Off',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: kWhite,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 130,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(value.krushiList.data!.data![index]!.productImage.toString())),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Align(
                          alignment: Alignment.center, child: SizedBox(width: double.infinity,
                                  child: Center(child: Text(value.krushiList.data!.data![index].productName.toString(), overflow: TextOverflow.ellipsis,)))),
                      ), 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row( 
                            children: [ 
                              SizedBox(width: 10,),
                             Text('₹ ${value.krushiList.data!.data![index].price}',style: TextStyle( decoration: TextDecoration.lineThrough, color: Colors.grey)),
                             SizedBox(width: 12,),
                                Text('₹ ${priceWithDiscount.toInt()}',style: TextStyle( color:kblack,fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                        ],
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        );
                },
              );
          }
        })
      ),
    ));
  }
}


