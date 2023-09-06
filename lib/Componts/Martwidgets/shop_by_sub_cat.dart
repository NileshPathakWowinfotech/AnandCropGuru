
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../screens/product_details_screen.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/Mart/shop_by_category_sub_view_model.dart';

class Shop_by_subList extends StatefulWidget {
  const Shop_by_subList({super.key, this.name});
  final name;

  @override
  State<Shop_by_subList> createState() => _Shop_by_subListState();
}

class _Shop_by_subListState extends State<Shop_by_subList> {
  ShopBySubCategoryViewModel shopBySubCategoryViewModel =ShopBySubCategoryViewModel();
  @override
  void initState() {
    shopBySubCategoryViewModel.shopForYourCroplList();
    shopBySubCategoryViewModel.ProductApi('1');
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
          title: InkWell(
            onTap: () {},
            child: Text(
           widget.name,
              style: TextStyle(
                  color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ChangeNotifierProvider<ShopBySubCategoryViewModel>(
              create: (BuildContext context) => shopBySubCategoryViewModel,
              child: Consumer<ShopBySubCategoryViewModel>(
                  builder: (context, value, _) {
                switch (value.shopBySublLists.status!) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(
                            value.shopBySublLists.message.toString()));
                  case Status.COMPLETED:
                    return value.shopBySublLists.data!.data!.isEmpty
                        ? Center(
                            child: Text('Data Not Found'),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                value.shopBySublLists.data!.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              dynamic item =
                                  value.shopBySublLists.data!.data![index];
                              return Container(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        shopBySubCategoryViewModel.ProductApi(
                                            value.shopBySublLists.data!
                                                .data![index]!.psubcatId);
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

                                              
                                                value
                                                        .shopBySublLists
                                                        .data!
                                                        .data![index]!
                                                        .psubcatImage ??
                                                    'uif',
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset('assets/images/imagenotavailable.jpg');
                                                },
                                                fit: BoxFit.fitHeight,
                                                height: 60,
                                                width: 60,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        value.shopBySublLists.data!.data[index].psubcatName ??
                                            'Loading',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                }
                return Container();
              }),
            ),
          ),
          
          Expanded(
            child: ChangeNotifierProvider<ShopBySubCategoryViewModel>(
              create: (BuildContext context) => shopBySubCategoryViewModel,
              child: Consumer<ShopBySubCategoryViewModel>(
                  builder: (context, value, _) {
                switch (value.productLists.status!) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.productLists.message.toString()));
                  case Status.COMPLETED:
                    return GridView(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2 / 3.05),
                      children: value.productLists.data!.DATA!.map((e) {
                        dynamic price = e!.PRICE;
                        dynamic discount = e.DISCOUNT;

                        dynamic percentage =
                            double.parse(price) / double.parse(discount) * 100;
                        dynamic priceWithDiscount =
                            double.parse(price) - double.parse(discount);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                      ProductdId: e.PRODUCT_ID,
                                      pSubCatId: e.PSUBCAT_ID,
                                      offerId: e.PRODUCT_ID,
                                    )));
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
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
                                      Container(
                                        height: 150,
                                        color: Colors.transparent,
                                        child: Image.network(
                                            e.PRODUCT_IMAGE.toString(),
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                          return Image.asset(
                                              'assets/images/bottle.png',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('₹ ${e.PRICE}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey)),
                                      Text('₹ $priceWithDiscount'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
                return Container();
              }),
            ),
          ),
        ]));
  }
}
