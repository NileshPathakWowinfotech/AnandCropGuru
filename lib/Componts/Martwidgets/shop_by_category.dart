import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/Martwidgets/shop_by_sub_cat.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../view_model/Mart/shop_by_category_view_model.dart';

class ShopByCategory extends StatefulWidget {
  const ShopByCategory({super.key});

  @override
  State<ShopByCategory> createState() => _ShopByCategoryState();
}

class _ShopByCategoryState extends State<ShopByCategory> {
  ShopByCategoryViewModel shopByCategoryViewModel = ShopByCategoryViewModel();

  @override
  void initState() {
    shopByCategoryViewModel.shopByCategorylList('0');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopByCategoryViewModel>(
      create: (BuildContext context) => shopByCategoryViewModel,
      child: Consumer<ShopByCategoryViewModel>(builder: (context, value, _) {
        switch (value.shopByCategorylLists.status!) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
                child: Text(value.shopByCategorylLists.message.toString()));
          case Status.COMPLETED:
            return value.shopByCategorylLists.data!.DATA!.isEmpty
                ? Center(
                    child: Text('Data Not Found'),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.shopByCategorylLists.data!.DATA!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      dynamic item =
                          value.shopByCategorylLists.data!.DATA![index];
                      return InkWell(
                        onTap: () {
                          Get.to(Shop_by_subList(
                            name: value.shopByCategorylLists.data!.DATA![index]!
                                .PCAT_NAME,
                          ));
                        },
                        child: Container(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Material(
                                  elevation: 3.5,
                                  shape: const CircleBorder(),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/crop_ig.png'),
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      child: Image.network(
                                        value.shopByCategorylLists.data!
                                                .DATA![index]!.PCAT_IMAGE ??
                                            'uif',
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                              SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  value.shopByCategorylLists.data!.DATA![index]!
                                          .PCAT_NAME ??
                                      'Loading',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
        }
        return Container();
      }),
    );
  }
}
