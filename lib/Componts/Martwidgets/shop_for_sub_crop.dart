import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/response/status.dart';
import '../../screens/product_details_screen.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/Mart/shop_by_category_view_model.dart';

class ShopYourCropSubList extends StatefulWidget {
  const ShopYourCropSubList({super.key, required this.item});
  final ShopYourCrop item;

  @override
  State<ShopYourCropSubList> createState() => _ShopYourCropSubListState();
}

class _ShopYourCropSubListState extends State<ShopYourCropSubList> {
  ShopByCategoryViewModel shopByCategoryViewModel = ShopByCategoryViewModel();

  @override
  void initState() {
    shopByCategoryViewModel.shopByCategorylList(widget.item.cropId);

    shopByCategoryViewModel.ProductList('1');
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
              widget.item.cropName,
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
            child: ChangeNotifierProvider<ShopByCategoryViewModel>(
              create: (BuildContext context) => shopByCategoryViewModel,
              child: Consumer<ShopByCategoryViewModel>(
                  builder: (context, value, _) {
                switch (value.shopByCategorylLists.status!) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(
                            value.shopByCategorylLists.message.toString()));
                  case Status.COMPLETED:
                    return value.shopByCategorylLists.data!.DATA!.isEmpty
                        ? Center(
                            child: Text('Data Not Found'),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                value.shopByCategorylLists.data!.DATA!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              dynamic item =
                                  value.shopByCategorylLists.data!.DATA![index];
                              return Container(
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        shopByCategoryViewModel.shopSubList(
                                            value.shopByCategorylLists.data!
                                                .DATA![index]!.PCAT_ID);
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
                                                        .shopByCategorylLists
                                                        .data!
                                                        .DATA![index]!
                                                        .PCAT_IMAGE ??
                                                    'uif',
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container();
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
                                        value.shopByCategorylLists.data!
                                                .DATA![index]!.PCAT_NAME ??
                                            'Loading',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 13),
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
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ChangeNotifierProvider<ShopByCategoryViewModel>(
              create: (BuildContext context) => shopByCategoryViewModel,
              child: Consumer<ShopByCategoryViewModel>(
                  builder: (context, value, _) {
                switch (value.SubCategorylLists.status!) {
                  case Status.LOADING:
                    return Text('');
                  case Status.ERROR:
                    return Center(
                        child:
                            Text(value.SubCategorylLists.message.toString()));
                  case Status.COMPLETED:
                    return value.SubCategorylLists.data!.data.isEmpty
                        ? Center(
                            child: Text('Data Not Found'),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  value.SubCategorylLists.data!.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                dynamic item =
                                    value.SubCategorylLists.data!.data[index];
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      shopByCategoryViewModel.ProductList(value
                                          .SubCategorylLists
                                          .data!
                                          .data[index]
                                          .psubcatId);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: kgreen),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 0),
                                        child: Text(value.SubCategorylLists
                                            .data!.data![index].psubcatName),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                }
                return Container();
              }),
            ),
          ),
          Expanded(
            child: ChangeNotifierProvider<ShopByCategoryViewModel>(
              create: (BuildContext context) => shopByCategoryViewModel,
              child: Consumer<ShopByCategoryViewModel>(
                  builder: (context, value, _) {
                switch (value.productList.status!) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(
                        child: Text(value.productList.message.toString()));
                  case Status.COMPLETED:
                    return GridView(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2 / 3.05),
                      children: value.productList.data!.DATA!.map((e) {
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
