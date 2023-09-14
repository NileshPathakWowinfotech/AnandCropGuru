import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;
import '../../view_model/myplot_view_model/purchesdrop_view_model.dart';
import '../Purchase.dart';
import 'full_size_image.dart';

class AddPurchases extends StatefulWidget {
 const AddPurchases({Key? key, this.cropID, this.userID, this.plotId})
      : super(key: key);
  final cropID;
  final userID;
  final plotId;


  @override
  State<AddPurchases> createState() => _AddPurchasesState();
}

class _AddPurchasesState extends State<AddPurchases> {
  PurchesdropViewModel purchesdropViewModel = PurchesdropViewModel();
  double size = 14;
  double Fromsize = 15;
  String SelectOption = 'Select Option';
  String SelectProduct = 'Select Product';
  String Selectunit = 'Unit';
  int? catID;
  int? productId;
  int? unitId;

  final timedate_Controller = TextEditingController();
  DateTime? dateTiming;
  File? image;
  var addProduct_Controller = TextEditingController();
  var paking_Controller = TextEditingController();
  var priceController = TextEditingController();
  var qantity_Controller = TextEditingController();
  var remark_Controller = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String? salectedDatebackundDevloper;
  dynamic imageData = "";
  final _addProduct = GlobalKey<FormState>();

  Future PickImageImag(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      imageData = base64Encode(imageTemporary.readAsBytesSync());
      setState(() {});
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  void datetiming() async {
    dateTiming = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        // firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        firstDate: DateTime(2002));
    if (dateTiming == null) {
      return;
    } else {
      setState(() {
        _dateTime = dateTiming!;
        salectedDatebackundDevloper =
            "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
        timedate_Controller.text = salectedDatebackundDevloper.toString();
        print("Date $salectedDatebackundDevloper");
      });
    }
  }

  void addProduct() async {
    Map<String, dynamic> data = {
      "CAT_ID": "32",
      "USER_ID": "60640",
      "PRODUCT_ID": "",
      "PRODUCT_NAME": addProduct_Controller.text,
      "EXTRA1": "",
      "EXTRA2": "",
      "TASK": "ADD"
    };

    try {
      var response = await http.post(
          Uri.parse("http://mycropguruapiwow.cropguru.in/api/PurchaseProduct"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      print(response.body);

      var jsonResponse = json.decode(response.body);

      if (jsonResponse["ResponseCode"] == "0") {
        print("sucsess");
      } else if (jsonResponse["ResponseCode"] == "1") {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    purchesdropViewModel.categoryListView(widget.userID);
    purchesdropViewModel.productListView(33,widget.userID);
    purchesdropViewModel.productListView(33,widget.userID);
    purchesdropViewModel.purshesListView(widget.userID);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseviewmodel =
        Provider.of<PurchesdropViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(Util.backgroundImage, fit: BoxFit.cover),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kgrey,
          ),
        ),
        title: GestureDetector(
          onTapDown: (TapDownDetails details) {
            _showPopupMenu(details.globalPosition);
          },
          child: Text(
            'Add Purchase',
            style: TextStyle(
                color: kgrey, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                ///height: 200,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Category Name",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(height: 30, child: CityDrropDown()),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Product Name",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTapDown: (TapDownDetails details) {
                        _showPopupMenu(details.globalPosition);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(height: 30, child: productName()),
                      ),
                    ),
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              width: 60,
                              color: lightgreen,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Packing",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                controller: paking_Controller,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                ],
                                                // controller: _mobile,
                                                style: TextStyle(fontSize: 15),
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,
      
                                                  hintText: 'Packing',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Unit",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                              width: 80,
                                              height: 30,
                                              child: Container(
                                                  color: kWhite,
                                                  child: unitDrropDown()))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                          Container(
                            height: 60,
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 55,
                              width: 60,
                              color: lightgreen,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Quantity",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                controller: qantity_Controller,
                                                style: TextStyle(fontSize: 15),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                ],
                                                // controller: _mobile,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,
      
                                                  hintText: 'QTY',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Price(Rs.)",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 30,
                                            child: Container(
                                              color: kWhite,
                                              child: TextField(
                                                controller: priceController,
                                                style: TextStyle(fontSize: 15),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                ],
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: kgreyy,
                                                      fontSize: 13),
                                                  contentPadding: EdgeInsets.only(
                                                      top: 1,
                                                      bottom: 0,
                                                      left: 6,
                                                      right: 6),
                                                  // errorText: _mobileValidated ? null : _mobileError,
      
                                                  hintText: 'Price(Rs.)',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Util.colorPrimary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Purchase Date",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          datetiming();
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kgreyy),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 30,
                                child: TextField(
                                  enabled: false,
                                  controller: timedate_Controller,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle:
                                        TextStyle(color: kgreyy, fontSize: 13),
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 16, left: 6, right: 6),
                                    // errorText: _mobileValidated ? null : _mobileError,
      
                                    hintText: 'Enter date',
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: kgreen,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Bill Photo",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext mContext) {
                                return Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Anand Crop Guru",
                                          style: TextStyle(
                                              color: kblack,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.camera),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/c_camera.png",
                                                    height: 45,
                                                  ),
                                                  Text("Camera")
                                                ],
                                              )),
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.gallery),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/image.png",
                                                    height: 45,
                                                  ),
                                                  Text("File Manager")
                                                ],
                                              )),
                                          InkWell(
                                              onTap: () => PickImageImag(
                                                  ImageSource.gallery),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/gallery.png",
                                                    height: 45,
                                                  ),
                                                  Text("Gallery")
                                                ],
                                              )),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: kgreen,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: kWhite,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              border: Border.all(color: kgreyy),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Icon(
                            Icons.camera_alt_outlined,
                            color: kgreen,
                            size: 30,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Remark",
                        style: TextStyle(
                            color: kblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 60,
                          child: TextField(
                             controller: remark_Controller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: kgreyy, fontSize: 13),
                              contentPadding: EdgeInsets.only(
                                  top: 1, bottom: 0, left: 6, right: 6),
                              // errorText: _mobileValidated ? null : _mobileError,
      
                              hintText: 'Remark',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Util.colorPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (SelectOption == 'Select Option') {
                            Util.flushBarErrorMessage(
                                'please Select Category', context);
                          } else if (SelectProduct == ' pleaseSelect Product') {
                            Util.flushBarErrorMessage(
                                ' pleaseSelect Product', context);
                          } else if (Selectunit == 'Unit') {
                            Util.flushBarErrorMessage(
                                'please Select Unit', context);
                          } else if (paking_Controller.text.isEmpty) {
                            Util.flushBarErrorMessage(
                                'please Enter Paking Size', context);
                          } else if (qantity_Controller.text.isEmpty) {
                            Util.flushBarErrorMessage(
                                'please Enter Quantity ', context);
                          } else if (paking_Controller.text.isEmpty) {
                          } else {
                            final data = jsonEncode({
                              "CAT_ID": catID,
                              "PRODUCT_NAME": SelectProduct,
                              "USER_ID": "21013",
                              "PRODUCT_ID": productId,
                              "QUANTITY": qantity_Controller.text,
                              "UNIT_ID": unitId,
                              "PRICE": priceController.text,
                              "REMARK":remark_Controller.text,
                              "SIZE": paking_Controller.text,
                              "EXTRA1": "",
                              "EXTRA2": "",
                              "TASK": "ADD",
                              "PURCHASE_DATE": timedate_Controller.text,
                              "FP_ID": "",
                              "BILL_PHOTO": imageData
                            });
                            print(data);
                            purchesdropViewModel.addPurchase(data, context);
                             purchesdropViewModel.purshesListView(widget.userID);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(width: 1, color: kWhite),
                              color: kgreen,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    )
                  ],
                ),
              ),
            ),
         SizedBox(height: 10,),
           list()
          ],
        ),
      ),
    );
  }

  Widget CityDrropDown() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return ChangeNotifierProvider<PurchesdropViewModel>(
        create: (BuildContext context) => purchesdropViewModel,
        child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
          switch (value.categoryList.status!) {
            case Status.LOADING:
              return Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(width: 1, color: kgreyy)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(SelectOption),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              );
            case Status.ERROR:
              return Center(child: Text(value.categoryList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        SelectOption;
                        catID;
                      });
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width / 12,
                            MediaQuery.of(context).size.height / 6,
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.height / 2),
                        items: value.categoryList.data!.data.map((option) {
                          print(SelectOption = option.catName);
                          return PopupMenuItem<String>(
                            value: option.catId.toString(),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    SelectOption = option.catName;
                                    catID = option.catId;
                                    purchesdropViewModel
                                        .productListView(option.catId,widget.userID);
                                    SelectProduct = 'Select Product';
                                    Selectunit = 'Unit';
                                    Navigator.pop(context);
                                  });
                                  print(SelectOption = option.catName);
                                  // SelectOption = option.catName;
                                },
                                child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(option.catName))),
                          );
                        }).toList(),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kgreyy)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(SelectOption),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                  ));
          }
        }));
  }

  Widget unitDrropDown() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return ChangeNotifierProvider<PurchesdropViewModel>(
        create: (BuildContext context) => purchesdropViewModel,
        child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
          switch (value.unitList.status!) {
            case Status.LOADING:
              return Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(width: 1, color: kgreyy)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Selectunit),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              );
            case Status.ERROR:
              return Center(child: Text(value.unitList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Selectunit;
                        unitId;
                      });
                      print('hello world');
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width / 10,
                            MediaQuery.of(context).size.height / 3,
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.height / 5),
                        items: value.unitList.data!.data.map((option) {
                          print(Selectunit = option.ulName);
                          return PopupMenuItem<String>(
                            value: option.ulId.toString(),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Selectunit = option.ulName;
                                    unitId = option.unitId;

                                    Navigator.pop(context);
                                  });
                                  print(Selectunit = option.ulName);
                                  // SelectOption = option.catName;
                                },
                                child: Container(
                                    height: 30, child: Text(option.ulName))),
                          );
                        }).toList(),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kgreyy)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Selectunit),
                            Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                  ));
          }
        }));
  }

  Widget list(){
    return  ChangeNotifierProvider<PurchesdropViewModel>(
        create: (BuildContext context) => purchesdropViewModel,
        child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
          switch (value.purchaseList.status!) {
            case Status.LOADING:
              return Center(child:CircularProgressIndicator());
            case Status.ERROR:
              return Center(child:Text(value.purchaseList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: value.purchaseList.data!.DATA!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final imagelist =
                            value.purchaseList.data!.DATA![index]!.BILL_PHORO;
                        final purchasedate =
                            value.purchaseList.data!.DATA![index]!.PURCHASE_DATE;
                        final remark =
                            value.purchaseList.data!.DATA![index]!.REMARK; 
                            dynamic  total =  double.parse(value.purchaseList.data!.DATA![index]!.PRICE.toString()) * double.parse(value.purchaseList.data!.DATA![index]!.QUANTITY.toString());

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          child: InkWell(
                            onTap: () {
                              showDialog<void>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? 15
                                                  : 100,
                                              vertical: 15),
                                          child: new Container(
                                            decoration: BoxDecoration(
                                                color: kWhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: double.infinity,
                                                    color: pgreen,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Center(
                                                              child: Text(
                                                            "",
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          Center(
                                                              child: Text(
                                                            "Product Details",
                                                            style: TextStyle(
                                                                color: kWhite,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                  Icons.cancel,
                                                                  size: 25,
                                                                  color: kWhite,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Product Name",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextfildForms(
                                                  name: value.purchaseList.data!
                                                      .DATA![index]!.PRODUCT_NAME,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Category Name",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextfildForms(
                                                  name: value.purchaseList.data!
                                                      .DATA![index]!.CAT_NAME,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Paking",
                                                        style: TextStyle(
                                                            color: kblack,
                                                            fontSize: Fromsize),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 120),
                                                        child: Text(
                                                          "Unit",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .SIZE.toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .UNIT_NAME.toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Price(Rs)",
                                                        style: TextStyle(
                                                            color: kblue,
                                                            fontSize: Fromsize),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 100),
                                                        child: Text(
                                                          "Quantity",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!.PRICE
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pgrey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Text(
                                                                value
                                                                    .purchaseList
                                                                    .data!
                                                                    .DATA![index]!
                                                                    .QUANTITY.toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        kblack,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Purchase Date",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: pgrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: Text(
                                                              purchasedate.toString(),
                                                              style: TextStyle(
                                                                  color: kblack,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: Util
                                                                .newHomeColor,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: imagelist == ""
                                                      ? Text("")
                                                      : Text(
                                                          "Bill photo",
                                                          style: TextStyle(
                                                              color: kblack,
                                                              fontSize:
                                                                  Fromsize),
                                                        ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: imagelist == ""
                                                        ? Text("")
                                                        : Material(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.to(FullSizeImage(
                                                                    image:
                                                                        imagelist));
                                                              },
                                                              child: Material(
                                                                child: Container(
                                                                    alignment: Alignment.center,
                                                                    height: 150,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          kWhite,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child: value.purchaseList.data!.DATA![index]!.BILL_PHORO.toString() == " "
                                                                        ? Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt_sharp,
                                                                              color: lgreen,
                                                                              size: 30,
                                                                            ),
                                                                          )
                                                                        : Stack(
                                                                            children: [
                                                                              Image.network(
                                                                                fit: BoxFit.fill,
                                                                                height: 200,
                                                                                width: MediaQuery.of(context).size.width,
                                                                                value.purchaseList.data!.DATA![index]!.BILL_PHORO.toString(),
                                                                                errorBuilder: (context, error, stackTrace) {
                                                                                  return Center(
                                                                                      child: Image.asset(
                                                                                    "assets/images/noimage.png",
                                                                                    height: 200,
                                                                                  ));
                                                                                },
                                                                              ),
                                                                              Center(
                                                                                child: Icon(Icons.camera_alt, size: 28, color: kgreen),
                                                                              )
                                                                            ],
                                                                          )),
                                                              ),
                                                            ),
                                                          )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    "Remark",
                                                    style: TextStyle(
                                                        color: kblack,
                                                        fontSize: Fromsize),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: pgrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            value
                                                                        .purchaseList
                                                                        .data!
                                                                        .DATA![
                                                                            index]!
                                                                        .REMARK ==
                                                                    null
                                                                ? ""
                                                                : remark.toString(),
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      // offset: const Offset(3.0, 3.0),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      color: kgrey),
                                ],
                                color: kWhite,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Product Name -",
                                              style: TextStyle(
                                                  color: kgrey, fontSize: size),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              value.purchaseList.data!
                                                  .DATA![index]!.PRODUCT_NAME.toString(),
                                              style: TextStyle(
                                                  color: kblack,
                                                  fontSize: size),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt_rounded,
                                          size: 30,
                                          color: kgreen,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Packing -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.SIZE.toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Unit -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.UNIT_NAME.toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Quantity -",
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                value.purchaseList.data!
                                                    .DATA![index]!.QUANTITY
                                                    .toString(),
                                                style: TextStyle(
                                                    color: kgrey,
                                                    fontSize: size),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Price(Rs) -",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                          "${value.purchaseList.data!
                                                    .DATA![index]!.PRICE
                                                    .toString()} x ${value.purchaseList.data!
                                                    .DATA![index]!.QUANTITY
                                                    .toString()} ",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                          "Total ₹",
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                        Text(
                                           total.toString(),
                                          style: TextStyle(
                                              color: kblack, fontSize: size),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Available Stock - ",
                                          style: TextStyle(
                                              color: kgreen, fontSize: size),
                                        ),
                                        Text(
                                          value.purchaseList.data!.DATA![index]!
                                              .AVL_STOCK.toString()
                                              .toString(),
                                          style: TextStyle(
                                              color: kgreen, fontSize: size),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Remark - ",
                                                style: TextStyle(
                                                    color: kblack,
                                                    fontSize: size),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  value.purchaseList.data!
                                                              .DATA![index]!.REMARK ==
                                                          null
                                                      ? ""
                                                      : value.purchaseList.data!
                                                          .DATA![index]!.REMARK
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: kgrey, fontSize: size),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor:kgreen,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: kWhite,
                                              size: 17,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      )
                      );
          }
          return Container();
        }),
      );
  }

  Widget productName() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return ChangeNotifierProvider<PurchesdropViewModel>(
        create: (BuildContext context) => purchesdropViewModel,
        child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
          switch (value.productList.status!) {
            case Status.LOADING:
              return Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(width: 1, color: kgreyy)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(SelectProduct),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              );
            case Status.ERROR:
              return Center(child: Text(value.productList.message.toString()));
            case Status.COMPLETED:
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Util.backgroundImage))),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        SelectProduct;
                      });
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width / 12,
                            MediaQuery.of(context).size.height / 6,
                            MediaQuery.of(context).size.width / 3,
                            MediaQuery.of(context).size.height / 2),
                        items: value.productList.data!.data.map((option) {
                          return PopupMenuItem<String>(
                            value: option.productId.toString(),
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    SelectProduct =
                                        option.productName.toString();
                                        productId =option.productId;
                                        
                                    purchesdropViewModel
                                        .unitListView(option.productId,widget.userID);
                                    Selectunit = 'Unit';
                                    Navigator.pop(context);
                                  });
                                  // print(  SelectOption = option.catName);
                                  // SelectOption = option.catName;
                                },
                                child: Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    child: option.productName == null
                                        ? SizedBox()
                                        : Text(option.productName.toString()))),
                          );
                        }).toList(),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgreyy)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(SelectProduct),
                                Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
          }
        }));
  }

  _showPopupMenu(Offset offset) async {
    double right = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(right, top, 5, 0),
      items: [
        PopupMenuItem(
          value: 3,
          child: InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.red,
                            child: Material(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 54,
                                    color: kgreen,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                              child: Text(
                                            "",
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Center(
                                              child: Text(
                                            "Add New Product",
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  size: 25,
                                                  color: kWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "Product Name",
                                      style: TextStyle(
                                          color: kblack,
                                          fontSize: Fromsize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: Form(
                                        key: _addProduct,
                                        child: TextFormField(
                                          controller: addProduct_Controller,
                                          decoration: InputDecoration(
                                            // errorText: _mobileValidated ? null : _mobileError,
                                            contentPadding: EdgeInsets.only(
                                                top: 1,
                                                bottom: 0,
                                                left: 6,
                                                right: 6),
                                            hintText: 'Product Name',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Util.colorPrimary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "Please enter Product Name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("hello ");
                                      if (_addProduct.currentState!
                                          .validate()) {
                                        addProduct();

                                        // _addProduct.userRegistration(questtionansController.text,imageData.toString());
                                      } else {}
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: kgreen,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: Text(
                                        "Send",
                                        style: TextStyle(
                                            color: kWhite,
                                            fontSize: Fromsize,
                                            fontWeight: FontWeight.bold),
                                      )
                                          //
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text("Add Product")),
        ),
      ],
      elevation: 8.0,
    );
  }
}
