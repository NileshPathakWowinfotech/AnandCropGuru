
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:get/get.dart';

import '../Componts/Martwidgets/recommendedproduct.dart';
import '../Componts/Martwidgets/shop_by_category.dart';
import '../Componts/Martwidgets/shop_for_your_crop.dart';
import '../Componts/Search_product.dart';
import '../models/user.dart';
import '../services.dart';
import '../utils/Colors.dart';
import '../utils/prefs_util.dart';
import '../utils/util.dart';
import 'cart_screen.dart';

class Mart extends StatefulWidget {
  const Mart({super.key});

  @override
  State<Mart> createState() => _MartState();
}

class _MartState extends State<Mart> with TickerProviderStateMixin{
  User? user;
  bool isCropsLoaded = false;
  bool isCategoriesLoaded = false;
  bool isProductLoaded = false;
  List<dynamic>? cropList;
  List<dynamic>? categoryList;
  List<dynamic>? productList;

  late AnimationController _controller;

  void setUser() async {
      user = await PrefsUtil.getUserDetails().then((value) async {
      cropList = await Services.getCropList(value.USER_ID.toString(), '3')
          .then((value) {
        setState(() {
          isCropsLoaded = true;
        });
        return value;
      });
      categoryList = await Services.getCategoryList(value).then((value) {
        setState(() {
          isCategoriesLoaded = true;
        });
        return value;
      });
      productList = await Services.getProductList(value.USER_ID!.toString(), '3').then((value) {
        setState(() {
          isProductLoaded = true;
        });
        Navigator.of(context).pop();
        return value;
      });
      return  user ;
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          decoration: BoxDecoration(  
            image: DecorationImage(
              image: AssetImage(Util.backgroundImage)
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   color: kblack,
                //   margin: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                // GestureDetector(
                //   onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => CartScreen(user!),
                // ));
                //   },
                //       child : Icon(
                //         Icons.shopping_cart_outlined,
                //         color: Colors.white,
                //         size: 27,
                //       ),)
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: (){
                    Get.to(SearchProduct());
                  },
                  child: Container(
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
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: green700, fontSize: 16),
                        suffixIcon: Icon(
                          Icons.search,
                          color: green700,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          'Shop for your crop',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                     Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                         child: Image.asset('assets/images/next_arr.gif',
                         height: 25,),
                       ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                
                     SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: ShopForYourCrop()),
                      SizedBox(height: 15,),
                   
                //Showing Categories
                Container(
                  height: 155,
                  color: kWhite,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shop by Category'),
                                Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 5),
                             child: Image.asset('assets/images/next_arr.gif',
                             height: 25,),
                                )
                            ],
                          )),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ShopByCategory())
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('Recommended Products'))),
                    
                // SizedBox(height: 6),
                
                  RecommendedProduct()
               
              ],
            ),
          ),
        ),
      );
    
  }
}
