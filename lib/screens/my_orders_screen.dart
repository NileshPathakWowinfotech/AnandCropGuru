
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Componts/MyAccount/my_order_details.dart';
import '../Model/user.dart';
import '../data/response/status.dart';
import '../services.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/MyAccount.dart/my_order_view_model.dart';

const double basicScreenPadding = 20;

class MyOrdersScreen extends StatefulWidget {
  final user;
  MyOrdersScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>  with TickerProviderStateMixin{
  late AnimationController _controller;
  List<dynamic>? orderList;
  MyOrderViewModel myOrderViewModel = MyOrderViewModel();

  void getData() async {
    Util.animatedProgressDialog(context, _controller);
    _controller.forward();
    orderList = await Services.getOrderList(widget.user.USER_ID!).then((value) {
      _controller.reset();
      Navigator.of(context).pop();
      setState(() {
        orderList = value;
      });
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    myOrderViewModel.myOrderListAPi();

    //  getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          "My Orders",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
        body:ChangeNotifierProvider<MyOrderViewModel>(
                create: (BuildContext context) => myOrderViewModel,
                child: Consumer<MyOrderViewModel>(builder: (context, value, _) {
                  switch (value.myOrderList.status!) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(value.myOrderList.message.toString()));
                    case Status.COMPLETED:
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(  
                              image: AssetImage(Util.backgroundImage)
                            )
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                           
                            itemCount: value.myOrderList.data!.data.length,
                            itemBuilder: (context, index) {
                              dynamic item = value.myOrderList.data!.data[index];
                              return InkWell(
                                onTap: (){
                                  Get.to(MyOrderDetails(myorder:item ,));
                                },
                                child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                                      child: Material(
                                        elevation: 1.5,
                                        shadowColor: lightGrey,
                                        borderRadius: BorderRadius.all(Radius.circular(9)),
                                        child: Padding(
                                          padding: EdgeInsets.all(9),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                    EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(15)),
                                                       color: Colors.orange
                                                            ),
                                                    child: Text('${value.myOrderList.data!.data[index].status}',
                                                        style:
                                                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                                  ),
                                                  SizedBox(height: 9),
                                                  Row(
                                                    children: [
                                                      Text('Order No. ',
                                                          style: TextStyle(color: Colors.black54)),
                                                      Text('ORDER ID 00${value.myOrderList.data!.data[index].orderId}')
                                                    ],
                                                  ),
                                                  SizedBox(height: 9),
                                                  Row(
                                                    children: [
                                                      Text('Ordered ',
                                                          style: TextStyle(color: Colors.black54)),
                                                      Text(
                                                        '${value.myOrderList.data!.data[index].regDate}',
                                                        style: TextStyle(
                                                            color: lightGreenTextColor,
                                                            fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Total Qty '),
                                                      Text('${value.myOrderList.data!.data[index].totalQty}', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 9),
                                                  Text('₹ ${value.myOrderList.data!.data[index].totalPrice}', style: TextStyle(fontWeight: FontWeight.bold, color: lightGreenTextColor, fontSize: 20),)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              );
                                
                            },
                          ));
                  }
                })),
            );
  }
}


