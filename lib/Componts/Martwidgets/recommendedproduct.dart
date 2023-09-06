import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/user.dart';
import '../../data/response/status.dart';
import '../../screens/product_details_screen.dart';
import '../../utils/util.dart';
import '../../view_model/Mart/rexommended_product_view_model.dart';
import '../../view_model/Mart/shop_by_category_view_model.dart';

class RecommendedProduct extends StatefulWidget {
  const RecommendedProduct({super.key});

  @override
  State<RecommendedProduct> createState() => _RecommendedProductState();
}

class _RecommendedProductState extends State<RecommendedProduct> {
  RecoummendedProdcutViewModel recoummendedProdcutViewModel =
      RecoummendedProdcutViewModel();

  @override
  void initState() {
    recoummendedProdcutViewModel.recommenedProductApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecoummendedProdcutViewModel>(
      create: (BuildContext context) => recoummendedProdcutViewModel,
      child:
          Consumer<RecoummendedProdcutViewModel>(builder: (context, value, _) {
        switch (value.recommendedLists.status!) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
                child: Text(value.recommendedLists.message.toString()));
          case Status.COMPLETED:
            return GridView(
              padding: EdgeInsets.symmetric(vertical: 9),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3.05),
              children: value.recommendedLists.data!.data!.map((e) {
                dynamic price = e.price;
                dynamic discount = e.discount;
                dynamic percentage = (discount / price) * 100;
                dynamic priceWithDiscount = price - discount;
                return GestureDetector(
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(pSubCatId: e.psubcatId,offerId: e.productId,)));
                  },
                  child: Container(
                    // width: 150,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            // height: 15,
                            // width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Util.newHomeColor,
                                  Util.endColor,
                                ],
                              ),
                            ),
                            child: Text('${percentage.toStringAsFixed(0)}% Off',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(height: 15),
                        Stack(
                          children: [
                          
                            Container(
                              height: 150,
                              color: Colors.transparent,
                              child: Image.network(e.productImage, errorBuilder:
                                  (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                return Image.asset('assets/images/bottle.png' ,
                                fit: BoxFit.cover);
                              }, fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  e.productName,
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('₹ ${e.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey)),
                            Text('₹ $priceWithDiscount'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        }
        return Container();
      }),
    );
  }
}
