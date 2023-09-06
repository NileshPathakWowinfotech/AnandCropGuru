import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../screens/product_details_screen.dart';
import '../../utils/util.dart';
import '../utils/Colors.dart';
import '../view_model/serachproduct_view_model.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  SearchProdcutViewModel searchProdcmutViewModel = SearchProdcutViewModel();
  TextEditingController searchProductController = TextEditingController();

  @override
  void initState() {
    searchProdcmutViewModel.searchProductApi(searchProductController.text);
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
              child: Icon(
                Icons.arrow_back,
                color: kgrey,
              )),
          title: Text(
            "Search",
            style: TextStyle(
                color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: green100,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
              ),
              padding: EdgeInsets.only(
                left: 20,
                // top: 5,
                right: 15,
              ),
              child: TextField(
                controller: searchProductController,
                onChanged: (value) {
                  searchProdcmutViewModel
                      .searchProductApi(searchProductController.text);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search by product name',
                  hintStyle: TextStyle(color: green700, fontSize: 16),
                  suffixIcon: Icon(
                    Icons.search,
                    color: green700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ChangeNotifierProvider<SearchProdcutViewModel>(
                      create: (BuildContext context) => searchProdcmutViewModel,
                      child: Consumer<SearchProdcutViewModel>(
                          builder: (context, value, _) {
                        switch (value.recommendedLists.status!) {
                          case Status.LOADING:
                            return const Center(
                                child: CircularProgressIndicator());
                          case Status.ERROR:
                            return Center(
                                child: Text(
                                    value.recommendedLists.message.toString()));
                          case Status.COMPLETED:
                            return GridView(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 9),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3.05),
                              children:
                                  value.recommendedLists.data!.data.map((e) {
                                dynamic price = e.price;
                                dynamic discount = e.discount;
                                dynamic percentage = (discount / price) * 100;
                                dynamic priceWithDiscount = price - discount;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                  ProductdId:e.productId ,
                                                  pSubCatId: e.psubcatId,
                                                  offerId: e.productId,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Stack(
                                            children: [
                                              Container(
                                                height: 150,
                                                color: Colors.transparent,
                                                child: Image.network(
                                                    e.productImage,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
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
                                                    e.productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('₹ ${e.price}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough,
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
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
