import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/MyAccount.dart/order_details_product_view_model.dart';

class MyOrderDetails extends StatelessWidget {
  const MyOrderDetails({super.key, required this.myorder});
  final MyOrder myorder;

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
          "Order Details",
          style: TextStyle(
              color: kgrey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: kblack,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                          color: kgreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      myorder.paymentMethod,
                      style: TextStyle(
                          color: klblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: kblack,
              ),
              Text(
                "Delivery address",
                style: TextStyle(
                    color: kgreen, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 5,),
              Text(
                myorder.orderAddress,
                style: TextStyle(color: kgrey, fontSize: 14),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    "Order Date - ",
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    myorder.regDate,
                    style: TextStyle(
                        color: klblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 15),
              Divider(
                color: lgreen2,
                thickness: 1,
              ),
              SizedBox(height: 15),
              Text(
                "Billing details",
                style: TextStyle(
                    color: kgreen, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total price',
                          style: TextStyle(color: kgrey, fontSize: 16),
                        ),
                        Text(
                          '₹  ${myorder.totalPrice}',
                          style: TextStyle(color: kblack, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery charges',
                          style: TextStyle(color: kgrey, fontSize: 16),
                        ),
                        Text(
                          '₹  ${myorder.shippingCharges}',
                          style: TextStyle(color: kblack, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'You save',
                          style: TextStyle(color: kgrey, fontSize: 16),
                        ),
                        Text(
                          '₹  ${myorder.totalDisc}',
                          style: TextStyle(color: kblack, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Used wallet amount',
                          style: TextStyle(color: kgrey, fontSize: 16),
                        ),
                        Text(
                          '₹  ${myorder.walletAmount}',
                          style: TextStyle(color: kblack, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Apply coupen discount',
                          style: TextStyle(color: kgrey, fontSize: 16),
                        ),
                        Text(
                          '₹  ${myorder.coupenAmount}',
                          style: TextStyle(color: kblack, fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: lgreen2,
                thickness: 4,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Method",
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "₹  ${myorder.totalPrice}",
                    style: TextStyle(
                        color: kgreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              myorder.status == 'Active'
                  ? Center(
                      child: Image.asset(
                      'assets/images/icorderconfirm.webp',
                      height: 50,
                    ))
                  : myorder.status == 'Completed'
                      ? Center(
                          child: Image.asset(
                          'assets/images/completed.webp',
                          height: 50,
                        ))
                      : myorder.status == 'Confirm'
                          ? Center(
                              child: Image.asset(
                              'assets/images/pending.webp',
                              height: 50,
                            ))
                          : myorder.status == 'Cancel'
                              ? Center(
                                  child: Image.asset(
                                  'assets/images/cancel.webp',
                                  height: 50,
                                ))
                              : myorder.status == 'Cancel'
                                  ? Center(
                                      child: Image.asset(
                                      'assets/images/cancel.webp',
                                      height: 50,
                                    ))
                                  : Center(
                                      child: Image.asset(
                                      'assets/images/icassignorder.webp',
                                      height: 50,
                                    )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Order Status -${myorder.status}",
                      style: TextStyle(
                          color: kblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Feedback rating",
                    style: TextStyle(
                        color: kblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: kgreen,
                      size: 5,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Feedback :- ${myorder.status}",
                style: TextStyle(
                    color: kblack, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Material(
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Give Feedback",
                      style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              myorder.status == 'Cancel'
                  ? Text("")
                  : myorder.status == 'Active'
                      ? Text('')
                      : OrderTracking(
                          trackinglink: myorder.trackLink,
                          trackingId: myorder.trackCode,
                        ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: kgreen,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Product',
                    style: TextStyle(
                      color: kgreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: kgreen,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Prodactivity(),
              SizedBox(height: 20),
              ProdactivityList(orderId: myorder.orderId,),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTracking extends StatelessWidget {
  OrderTracking({super.key, this.trackingId, this.trackinglink});
  final trackingId;
  final trackinglink;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 5,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Order Tracking",
                style: TextStyle(
                    color: kblack, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Container(
                  height: 30,
                  width: double.infinity - 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: lgreen),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trackingId,
                          style: TextStyle(color: kblack, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Util.tostMassage('Tracking Id Copied');
                            Clipboard.setData(
                                new ClipboardData(text: trackingId));
                            key.currentState!;
                          },
                          child: Icon(
                            Icons.copy_outlined,
                            color: klorange,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  String url =
                      "https://play.google.com/store/apps/details?id=com.cropguru&hl";
                  if (await canLaunch(trackinglink!)) {
                    await launch(
                      trackinglink!,
                      headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                        "Content-Disposition": "inline"
                      },
                    );
                  } else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "TRACK ORDER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Prodactivity extends StatelessWidget {
  const Prodactivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          color: kgreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product",
                  style: TextStyle(
                      color: kWhite, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Quantity",
                  style: TextStyle(
                      color: kWhite, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Amount(₹)",
                  style: TextStyle(
                      color: kWhite, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProdactivityList extends StatefulWidget {
  const ProdactivityList({super.key, this.orderId});
  final orderId;

  @override
  State<ProdactivityList> createState() => _ProdactivityListState();
}

class _ProdactivityListState extends State<ProdactivityList> {
  OrderDetailsProductViewModel orderDetailsProductViewModel =
      OrderDetailsProductViewModel();
      @override
  void initState() {
    orderDetailsProductViewModel.myOrderProductListAPi(widget.orderId);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderDetailsProductViewModel>(
        create: (BuildContext context) => orderDetailsProductViewModel,
        child: Consumer<OrderDetailsProductViewModel>(builder: (context, value, _) {
          switch (value.myOrderDetailsProductList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.myOrderDetailsProductList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    itemCount: value.myOrderDetailsProductList.data!.DATA!.length,
                    itemBuilder: (context, index) {
                      dynamic item = value.myOrderDetailsProductList.data!.DATA![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/bottle.png',
                                  height: 20,
                                ),
                                Text(
                                 value.myOrderDetailsProductList.data!.DATA![index]!.PRODUCT_NAME.toString(),
                                  style: TextStyle(
                                      color: kgrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                            value.myOrderDetailsProductList.data!.DATA![index]!.QTY.toString(),
                              style: TextStyle(
                                  color: kgrey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "₹ ${value.myOrderDetailsProductList.data!.DATA![index]!.PRICE.toString()}",
                              style: TextStyle(
                                  color: kgrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
          }
        }));
  }
}
