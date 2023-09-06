import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/Mart/product_comment_view_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Componts/Martwidgets/product_all_page_list.dart';
import '../Componts/Martwidgets/product_blog_details.dart';
import '../Demo/productDemo.dart';
import '../data/Model/user_model.dart';
import '../data/response/status.dart';
import '../services.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import '../view_model/CropModels/related_video_view_model.dart';
import '../view_model/Mart/product_blog_view_model.dart';
import '../view_model/user_view_model.dart';
import 'cart_screen.dart';

const double basicScreenPadding = 15;
late AnimationController _controller;
String selectedOption = 'Product Description';

class ProductDetailsScreen extends StatefulWidget {
  final pSubCatId;
  final offerId;
  final ProductdId;

  ProductDetailsScreen({
    super.key,
    this.pSubCatId,
    this.offerId,
    this.ProductdId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  bool isDataLoaded = false;
  Map<dynamic, dynamic>? productDetails;
  List<dynamic>? updatedProductDetails;
  List<dynamic>? sizeList;
  Future<UserModel> getUserData() => UserViewModel().getUser();
   String? userId;

  void getData() {
    getUserData().then((value) async {
      
      print('dddddd ${value.userId}'); 
      userId = value.userId;
      productDetails = await Services.getProductDetails(
              widget.offerId.toString(), widget.pSubCatId, value.userId)
          .then((value) {
        updatedProductDetails = value['DATA1'];
        sizeList = value['DATA2'];
        Navigator.of(context).pop();
        setState(() {
          isDataLoaded = true;
        });
        return value;
      });
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return error;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Util.animatedProgressDialog(context, _controller);
      _controller.forward();
      getData();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String htmlData = '';
    if (isDataLoaded) {
      htmlData = updatedProductDetails![0]['DESCRIPTION']
          .toString()
          .replaceAll('\n\n', '<br><br>');
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            "Product Details",
            style: TextStyle(color: kgrey),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // SizedBox(height: 15),
              isDataLoaded
                  ? Expanded(
                      child: SingleChildScrollView(
                        // padding: EdgeInsets.symmetric(horizontal: basicScreenPadding),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: basicScreenPadding),
                              child: Column(
                                children: [
                                  Container(
                                    // color: Colors.transparent,
                                    height: 190,
                                    width: 190,
                                    child: Image.network(
                                      // color: Colors.transparent,
                                      updatedProductDetails?[0]
                                          ['PRODUCT_IMAGE'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    updatedProductDetails?[0]['PRODUCT_NAME'],
                                    style: TextStyle(
                                        color: greenTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    updatedProductDetails?[0]['CHEMICAL_NAME'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 25),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Product Size Available',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      )),
                                  SizedBox(height: 25),
                                  SizeList(sizeList!, "21013", getData),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Divider(color: Colors.grey, thickness: 1),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ScrollConfiguration(
                                    behavior: ScrollBehavior()
                                        .copyWith(overscroll: false),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        OptionsItem('Product Description', () {
                                          setState(() {
                                            selectedOption =
                                                'Product Description';
                                          });
                                        }, selectedOption),
                                        OptionsItem('Related Videos', () {
                                          setState(() {
                                            selectedOption = 'Related Videos';
                                          });
                                        }, selectedOption),
                                        OptionsItem('Blogs', () {
                                          setState(() {
                                            selectedOption = 'Blogs';
                                          });
                                        }, selectedOption),
                                        OptionsItem('Ratings', () {
                                          setState(() {
                                            selectedOption = 'Ratings';
                                          });
                                        }, selectedOption),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            selectedOption == 'Product Description'
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Html(
                                      data: htmlData,
                                      // style: {
                                      //   "p": Style(
                                      //       color: Colors.grey,
                                      //       fontFamily: 'roboto'
                                      //     // fontSize: FontSize.larger,
                                      //   ),
                                      // }),
                                    ))
                                : selectedOption == 'Ratings'
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return ratingDialog(widget.ProductdId
                                                           );
                                                      });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 15, top: 15),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      color:
                                                          lightGreenTextColor),
                                                  child: Text('Add Review',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RatingAndComment(productId:widget.ProductdId ,),
                                            )
                                          ],
                                        ),
                                      )
                                    : selectedOption == "Related Videos"
                                        ? RelatedVideoList(
                                            productId: widget.ProductdId,
                                          )
                                        : Blogs(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 236,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Util.backgroundImage),
                                      fit: BoxFit.cover)),
                              child: Demoomy(),
                            )
                          ],
                        ),
                      ),
                    )
                  : Blogs(),

              InkWell(
                onTap: () {
                   getUserData().then((value) async {
                   print(value.userId.toString());
                   Get.to(CartScreen(value.userId));
                   });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  color: kgreen,
                  child: Text(
                    'Order Place',
                    style: TextStyle(color: kWhite, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class OptionsItem extends StatefulWidget {
  String title;
  Function functionOnTap;
  String selectedOption;

  OptionsItem(this.title, this.functionOnTap, this.selectedOption, {super.key});

  @override
  State<OptionsItem> createState() => _OptionsItemState();
}

class _OptionsItemState extends State<OptionsItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.title == selectedOption;
    return GestureDetector(
      onTap: () {
        widget.functionOnTap();
        // selectOption(widget.title);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0.0, 1.0),
            ),
          ],
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Colors.green,
                    Util.endColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: Text(widget.title,
            style: TextStyle(
                color: isSelected ? Colors.white : Util.newHomeColor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class SizeList extends StatefulWidget {
  List<dynamic> sizeList;
  String userId;
  Function reloadData;

  SizeList(this.sizeList, this.userId, this.reloadData);

  @override
  State<SizeList> createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  bool isExpanded = false;

  void changeExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: isExpanded == false
            ? [
                SizeListItem(
                    widget.sizeList[0], widget.userId, widget.reloadData),
                SizedBox(height: 6),
                Align(
                    alignment: Alignment.centerRight,
                    child: ShowButton(isExpanded, changeExpanded))
              ]
            : [
                ...widget.sizeList.map((product) {
                  return SizeListItem(
                      product, widget.userId, widget.reloadData);
                }).toList(),
                SizedBox(height: 6),
                Align(
                    alignment: Alignment.centerRight,
                    child: ShowButton(isExpanded, changeExpanded))
              ]);
  }
}

class ShowButton extends StatefulWidget {
  bool isExpanded;
  Function changeExpanded;

  ShowButton(this.isExpanded, this.changeExpanded);

  @override
  State<ShowButton> createState() => _ShowButtonState();
}

class _ShowButtonState extends State<ShowButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.changeExpanded();
      },
      child: Material(
        color: Colors.white,
        shape: Border(bottom: BorderSide(color: greenTextColor)),
        child: Text(widget.isExpanded ? 'Show Less' : 'Show More',
            style: TextStyle(
                color: greenTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}

class SizeListItem extends StatefulWidget {
  Map product;
  String userId;
  Function reloadData;

  SizeListItem(this.product, this.userId, this.reloadData);

  @override
  State<SizeListItem> createState() => _SizeListItemState();
}

class _SizeListItemState extends State<SizeListItem> {
  double fontSIze = 11;
  double qty = 0;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    double discountedPrice =
        widget.product['PRICE'] - widget.product['DISCOUNT'];

    if (!initialized) {
      qty = widget.product['CART_QTY'];
      initialized = true;
    }

    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: lightGrey))),
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${widget.product['SIZE']} ${widget.product['UNIT']}',
              style: TextStyle(fontSize: fontSIze)),
          // SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('MRP',
                  style: TextStyle(color: Colors.grey, fontSize: fontSIze)),
              Text(
                '₹${widget.product['PRICE']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: fontSIze),
              ),
            ],
          ),
          // SizedBox(width: 6),
          Text('Rs. $discountedPrice',
              style: TextStyle(
                  fontSize: fontSIze,
                  fontWeight: FontWeight.bold,
                  color: lightGreenTextColor)),
          qty == 0
              ? Container(
                  height: 25,
                  padding: EdgeInsets.all(0),
                  child: ElevatedButton(
                    onPressed: () {
                      qty += 1;

                      Util.animatedProgressDialog(context, _controller);
                      _controller.forward();

                      Services.addQtyToCart(
                              widget.userId, widget.product, qty, 'UPDATE')
                          .then((value) {
                        widget.reloadData();
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('ADD'),
                        SizedBox(width: 5),
                        Icon(
                          Icons.add,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        qty -= 1;

                        Util.animatedProgressDialog(context, _controller);
                        _controller.forward();

                        if (qty == 0) {
                          Services.addQtyToCart(
                                  widget.userId, widget.product, 0, 'DELETE')
                              .then((value) {
                            widget.reloadData();
                            return value;
                          });
                        } else {
                          Services.addQtyToCart(
                                  widget.userId, widget.product, qty, 'UPDATE')
                              .then((value) {
                            widget.reloadData();
                            return value;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: greenTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${qty.round()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        qty += 1;

                        Util.animatedProgressDialog(context, _controller);
                        _controller.forward();

                        Services.addQtyToCart(
                                widget.userId, widget.product, qty, 'UPDATE')
                            .then((value) {
                          widget.reloadData();
                          return value;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: greenTextColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class ratingDialog extends StatefulWidget {
  String productId;
  
  ratingDialog(this.productId,);
  @override
  State<ratingDialog> createState() => _ratingDialogState();
}

class _ratingDialogState extends State<ratingDialog>
    with TickerProviderStateMixin {
  TextEditingController feedbackTextController = TextEditingController();
  late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    double givenRating = 1;
     final commentProductViewViewModel = Provider.of<CommentProductViewViewModel>(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          // margin: MediaQuery.of(context).viewInsets,
          // height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 65,
                  color: Util.colorPrimary,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text('Give Feedback',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              Icon(Icons.close, color: Colors.white, size: 26))
                    ],
                  )),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/rateorder.jpg'),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Rating*',
                            style: TextStyle(
                                color: greenTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13))),
                    SizedBox(height: 15),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: kgreen,
                      ),
                      onRatingUpdate: (rating) {
                        givenRating = rating;
                      },
                    ),
                    SizedBox(height: 25),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Feedback :',
                            style: TextStyle(
                                color: greenTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13))),
                    SizedBox(height: 15),
                    Container(
                      // margin: MediaQuery.of(context).viewInsets,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: textFieldColor,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: TextField(
                        controller: feedbackTextController,
                        maxLines: 5,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Feedback :',
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        // if (feedbackTextController.text.trim().isEmpty) {
                        //   // print(feedbackTextController.toString().trim().isEmpty);
                        //   Fluttertoast.showToast(
                        //       msg: 'Please Enter Feedback',
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       timeInSecForIosWeb: 1,
                        //       backgroundColor: Colors.black,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0);
                        //   return;
                        // }

                        // Util.animatedProgressDialog(context, _controller);
                        // _controller.forward();
                        // Services.addReview(widget.productId, widget.userId,
                        //         givenRating, feedbackTextController.text)
                        //     .then((value) {
                        //   Navigator.of(context).pop();
                        //   Navigator.of(context).pop();
                        // });
                        if(feedbackTextController.text.isEmpty){
                          Util.flushBarErrorMessage('Please Enter FeedBack',context);
                        }else{
                         commentProductViewViewModel.feedBack(context,feedbackTextController.text,givenRating, widget.productId);
                        }
                       
                       
                      },
                      child: Container(
                        // margin: MediaQuery.of(context).viewInsets,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Util.colorPrimary),
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RelatedVideoList extends StatefulWidget {
  const RelatedVideoList({super.key, this.productId});
  final productId;

  @override
  State<RelatedVideoList> createState() => _RelatedVideoListState();
}

class _RelatedVideoListState extends State<RelatedVideoList> {
  RelatedVideoViewModel relatedVideoViewModel = RelatedVideoViewModel();

  @override
  void initState() {
    relatedVideoViewModel.relatedVideoAPi(widget.productId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RelatedVideoViewModel>(
        create: (BuildContext context) => relatedVideoViewModel,
        child: Consumer<RelatedVideoViewModel>(builder: (context, value, _) {
          switch (value.relatedVideoList.status!) {
            case Status.LOADING:
              return Text('');
            case Status.ERROR:
              return Center(
                  child: Text(value.relatedVideoList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: value.relatedVideoList.data!.data.isEmpty
                      ? Center(
                          child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/no_data_faund.jpg"))),
                        ))
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          itemCount: value.relatedVideoList.data!.data.length,
                          itemBuilder: (context, index) {
                            dynamic item =
                                value.relatedVideoList.data!.data[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [],
                                        ),
                                        Text(
                                          value.relatedVideoList.data!
                                              .data[index].videoTitle,
                                          style: TextStyle(
                                            color: kblack,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            String? url;
                                            print("hello");

                                            url =
                                                "https://www.youtube.com/watch?v=${value.relatedVideoList.data!.data[index].videoUrl.toString()}";
                                            if (await canLaunch(url!)) {
                                              await launch(
                                                url!,
                                                headers: {
                                                  "Content-Type":
                                                      "application/x-www-form-urlencoded",
                                                  "Content-Disposition":
                                                      "inline"
                                                },
                                              );
                                              print("browser url");
                                              print(url);
                                            } else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                          child: Container(
                                            height: 200,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                    'https://i.ytimg.com/vi/yEDIJODOE58/maxresdefault.jpg'),
                                                Center(
                                                    child: Image.asset(
                                                  "assets/images/play.png",
                                                  height: 40,
                                                  color: Colors.red,
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
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
        }));
  }
}

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  ProductBlogViewViewModel productBlogViewViewModel =
      ProductBlogViewViewModel();
  @override
  void initState() {
    productBlogViewViewModel.productblogaPI();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductBlogViewViewModel>(
        create: (BuildContext context) => productBlogViewViewModel,
        child: Consumer<ProductBlogViewViewModel>(builder: (context, value, _) {
          switch (value.productLists.status!) {
            case Status.LOADING:
              return Text('');
            case Status.ERROR:
              return Center(child: Text(value.productLists.message.toString()));
            case Status.COMPLETED:
              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: value.productLists.data!.data.isEmpty
                      ? Center(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/no_data_faund.jpg"))),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          itemCount: value.productLists.data!.data.length,
                          itemBuilder: (context, index) {
                            dynamic item = value.productLists.data!.data[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ProductBlogDetails(blog: item));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                              child: Text(
                                            value.productLists.data!.data[index]
                                                .blogTitle,
                                            style: TextStyle(
                                                color: kgrey,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                              child: Image.network(
                                            value.productLists.data!.data[index]
                                                .blogImage,
                                            height: 300,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/imagenotavailable.jpg');
                                            },
                                          )),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Html(
                                              data: value.productLists.data!
                                                  .data[index].blogDescription),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.share,
                                                      color: kgreen,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      value.productLists.data!
                                                          .data[index].regDate,
                                                      style: TextStyle(
                                                          color: kgrey,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: klorange,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
          }
        }));
  }
}

class RatingAndComment extends StatefulWidget {
  const RatingAndComment({
    super.key, this.productId,
  });
  final productId;

  @override
  State<RatingAndComment> createState() => _RatingAndCommentState();
}

class _RatingAndCommentState extends State<RatingAndComment> {
  CommentProductViewViewModel commentProductViewViewModel =
      CommentProductViewViewModel();
  @override
  void initState() {
    commentProductViewViewModel.commentProduct(widget.productId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentProductViewViewModel>(
        create: (BuildContext context) => commentProductViewViewModel,
        child:
            Consumer<CommentProductViewViewModel>(builder: (context, value, _) {
          switch (value.productLists.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.productLists.message.toString()));
            case Status.COMPLETED:
              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    itemCount: value.productLists.data!.data.length,
                    itemBuilder: (context, index) {
                      dynamic item = value.productLists.data!.data[index];
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Image.network(
                                      value.productLists.data!.data[index]
                                          .profilePhoto,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/profile.png",
                                      height: 200,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item = value
                                      .productLists.data!.data[index].fullName,
                                  style: TextStyle(
                                    color: kblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  value.productLists.data!.data[index].regDate
                                      .toString(),
                                  style: TextStyle(color: kgrey, fontSize: 12),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  maxLines: 3,
                                  value.productLists.data!.data[index]
                                      .ratingMessage
                                      .toString(),
                                  style: TextStyle(color: kblack, fontSize: 12),
                                ),
                                SizedBox(height: 5,),
                                  RatingBar.builder(
                                  initialRating:  value.productLists.data!.data[index].rating,
                                      
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 12,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: kgreen,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Divider(
                                      thickness: 0,
                                      color: kblack,
                                    )),
                              
                              ],
                            )
                          ]);
                    },
                  ));
          }
        }));
  }
}
