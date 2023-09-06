import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../repository/Mart/demoproduct.dart';
import '../../utils/util.dart';
import '../../view_model/Mart/related_product_view_model.dart';

class ProductRealtedList extends StatefulWidget {
  const ProductRealtedList({super.key});

  @override
  State<ProductRealtedList> createState() => _ProductRealtedListState();
}

class _ProductRealtedListState extends State<ProductRealtedList> {
  @override
  ProductDetailsViewModel relatedProdcutViewModel = ProductDetailsViewModel();
  @override
  void initState() {
    relatedProdcutViewModel.ProductDetails();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {

 return Column(
  children: [ 
    InkWell(
      onTap:(){
        relatedProdcutViewModel.ProductDetails();
      },
      child: Text('ldldld')),
    SizedBox(height: 25,),
     ChangeNotifierProvider<ProductDetailsViewModel>(
      create: (BuildContext context) => relatedProdcutViewModel,
      child:
          Consumer<ProductDetailsViewModel>(builder: (context, value, _) {
        switch (value.movieslLists.status!) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
                child: Text(value.movieslLists.message.toString()));
          case Status.COMPLETED:
            return GridView(
              padding: EdgeInsets.symmetric(vertical: 9),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3.05),
              children: value.movieslLists.data!.DATA!.map((e) {
                dynamic price = e!.PRICE!;
                dynamic discount = e!.PRICE;
                dynamic percentage = (discount / price) * 100;
                dynamic priceWithDiscount = price - discount;
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(pSubCatId: e.psubcatId,offerId: e.productId,)));
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
                              child: Image.network(e.PRODUCT_IMAGE.toString(), errorBuilder:
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
                                  e.PRODUCT_NAME.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('₹ ${e.PRICE.toString()}',
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
    )
  ],
 );
  }
}


 