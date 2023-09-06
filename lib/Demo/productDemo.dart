import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../repository/Mart/demoproduct.dart';
import '../screens/product_details_screen.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';

class Demoomy extends StatefulWidget {
  const Demoomy({super.key});

  @override
  State<Demoomy> createState() => _DemoomyState();
}

class _DemoomyState extends State<Demoomy> {
  ProductDetailsViewModel productDetailsViewModel = ProductDetailsViewModel();
  @override
  void initState() {
    productDetailsViewModel.ProductDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<ProductDetailsViewModel>(
            create: (BuildContext context) => productDetailsViewModel,
            child:
                Consumer<ProductDetailsViewModel>(builder: (context, value, _) {
              switch (value.movieslLists.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.movieslLists.message.toString()));
                case Status.COMPLETED:
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Util.backgroundImage))),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        itemCount: value.movieslLists.data!.DATA!.length,
                        itemBuilder: (context, index) {
                          dynamic item = value.movieslLists.data!.DATA![index];
                          dynamic price =
                              value.movieslLists.data!.DATA![index]!.PRICE;
                          dynamic discount =
                              value.movieslLists.data!.DATA![index]!.DISCOUNT;
                          dynamic percentage = double.parse(discount) /
                              double.parse(price) *
                              100;
                          dynamic priceWithDiscount =
                              double.parse(price) - double.parse(discount);
                          return InkWell(
                            onTap: () {
                              Get.to(ProductDetailsScreen(
                                ProductdId: value
                                    .movieslLists.data!.DATA![index]!.PRODUCT_ID
                                    .toString(),
                                pSubCatId: value
                                    .movieslLists.data!.DATA![index]!.PSUBCAT_ID
                                    .toString(),
                                offerId: value
                                    .movieslLists.data!.DATA![index]!.PRODUCT_ID
                                    .toString(),
                              ));
                            },
                            child: Container(
                                margin: EdgeInsets.all(6),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        // height: 15,
                                        // width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Util.newHomeColor,
                                              Util.endColor,
                                            ],
                                          ),
                                        ),
                                        child: Text(
                                            '${percentage.toStringAsFixed(0)}% Off',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 100,
                                            color: Colors.transparent,
                                            child: Center(
                                              child: Image.network(
                                                  value
                                                      .movieslLists
                                                      .data!
                                                      .DATA![index]!
                                                      .PRODUCT_IMAGE
                                                      .toString(),
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                    'assets/images/bottle.png',
                                                    fit: BoxFit.cover);
                                              }, fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      value.movieslLists.data!.DATA![index]!
                                          .PRODUCT_NAME
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: kblack),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                232,
                                        child: Divider(
                                          color: lgreen,
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '₹ ${value.movieslLists.data!.DATA![index]!.PRICE.toString()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey)),
                                        Text('₹ $priceWithDiscount'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )),
                          );
                        },
                      ));
              }
            }
            )
            )
            );
  }
}
