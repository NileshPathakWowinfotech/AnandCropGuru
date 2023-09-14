// product list api error :- Dropdown 3 time click error product list
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Api/add_expence_post_api.dart';
import '../../Api/expense_api.dart';
import '../../Demo/cutomDropDown.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/Diary/Expense_view_model.dart';
import '../../view_model/myplot_view_model/purchesdrop_view_model.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key, this.cropID, this.userID, this.plotId})
      : super(key: key);
  final cropID;
  final userID;
  final plotId;

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> with TickerProviderStateMixin {
  ExpansesViewModel expansesViewModel = ExpansesViewModel();
  PurchesdropViewModel purchesdropViewModel = PurchesdropViewModel();
  bool isOpen = false;
  String SelectOption = ' ';
  int? _value2;
  bool isVisible = true;
  String cropNameGlobal = '';
  String cropId = "";
  double size = 14;
  double Fromsize = 15;
  dynamic selectDate = '';
  dynamic? quantity;
  double? totalExpance;

  String SelectCategory = 'Select Category';
  String SelectProduct = 'Select Product';
  String Selectunit = 'Unit';
  int? catID;
  int? productId;
  int? unitId;

  final timedate_Controller = TextEditingController();
  var jsonResponse;
  DateTime? dateTiming;
  File? image;
  var addProduct_Controller = TextEditingController();
  var quantity_Controller = TextEditingController();
  var remak_controller = TextEditingController();
  var price_controller = TextEditingController();

  var packing_controller = TextEditingController();
  var dateController = TextEditingController();
  var from_date_Controller = TextEditingController();
  var to_date_Controller = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String? salectedDatebackundDevloper;
  dynamic imageData = "";
  final _addProduct = GlobalKey<FormState>();
  final _expenses = GlobalKey<FormState>();

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
      "CAT_ID": _value2,
      "USER_ID": widget.userID,
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
  bool isLoaded = false;

  void initState() {
    expansesViewModel.categoryListDropDownList(widget.userID);
    expansesViewModel.productListDropDownList(widget.userID, cropId);
     
    // TODO: implement initState
    super.initState();
  }
 @override
  void dispose() {
   
     
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<ExpansesViewModel>(context, listen: true);

    DateTime selectedDate = context.watch<SelectedDateProvider>().selectedDate;
    return Scaffold(
      body: Form(
        key: _expenses,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                             expansesViewModel.categoryListDropDownList(widget.userID);
                               expansesViewModel.productListDropDownList(widget.userID, cropId);
                             isVisible = !isVisible;
                          });
                          
                        },
                        child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                              border: Border.all(width: 3, color: kbordergrey),
                              borderRadius: BorderRadius.circular(5),
                              color: kWhite),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    print('hello');
                                  },
                                  child: Text(
                                    "Add Expense",
                                    style: TextStyle(
                                        color: kblack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Icon(
                                  Icons.add_circle,
                                  color: kgreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Visibility(
                    visible: isVisible,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          ///height: 200,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                              SizedBox(height: 30, child: catName()),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: InkWell(
                                  onTap: () {},
                                  child:
                                      SizedBox(height: 30, child: productName()),
                                ),
                              ),
                              SizedBox(height: 7),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SelectCategory == 'Others'
                                    ? Text("kkdk")
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 55,
                                              width: 60,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Unit",
                                                            style: TextStyle(
                                                                color: kblack,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                                height: 30,
                                                                child: InkWell(
                                                                  onTap: () {},
                                                                  child: Container(
                                                                      color:
                                                                          kWhite,
                                                                      child:
                                                                          unitDrropDown()),
                                                                )),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Quantity",
                                                                style: TextStyle(
                                                                    color: kblack,
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Count(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 30,
                                                              child: Container(
                                                                color: kWhite,
                                                                child: TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  inputFormatters: [
                                                                    LengthLimitingTextInputFormatter(
                                                                        6),
                                                                  ],
                                                                  controller:
                                                                      quantity_Controller,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        color:
                                                                            kgreyy,
                                                                        fontSize:
                                                                            13),
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            top:
                                                                                1,
                                                                            bottom:
                                                                                0,
                                                                            left:
                                                                                6,
                                                                            right:
                                                                                6),
                                                                    // errorText: _mobileValidated ? null : _mobileError,
                    
                                                                    hintText:
                                                                        'Quantity',
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Util
                                                                            .colorPrimary,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(2),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () async {
                                    //   datetiming();
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    selectDate =
                                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                                    if (newDate != null) {
                                      context
                                          .read<SelectedDateProvider>()
                                          .updateSelectedDate(newDate);
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: kgreyy),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: 120,
                                            height: 30,
                                            child: Padding(
                                              padding: const EdgeInsets.all(7.0),
                                              child: Text(
                                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                                  style: TextStyle(fontSize: 14)),
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
                                height: 15,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    height: 70,
                                    child: TextField(
                                      controller: remak_controller,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: kgreyy, fontSize: 13),
                    
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
                                    if (SelectCategory == 'Select Category') {
                                      Util.flushBarErrorMessage(
                                          'please Select Category', context);
                                    } else if (SelectProduct ==
                                        ' Select Product') {
                                      Util.flushBarErrorMessage(
                                          ' please Select Product', context);
                                    } else if (Selectunit == 'Unit') {
                                      Util.flushBarErrorMessage(
                                          'please Select Unit', context);
                                    } else if (quantity_Controller.text.isEmpty) {
                                      Util.flushBarErrorMessage(
                                          'please Enter Quantity ', context);
                                    } else if (int.parse(
                                            quantity_Controller.text) >=
                                        quantity) {
                                      Util.flushBarErrorMessage(
                                          'Please enter less quantity', context);
                                    } else {
                                      final data = jsonEncode({
                                        "CAT_ID": catID,
                                        "PRODUCT_ID": productId,
                                        "USER_ID": "60640",
                                        "QUANTITY": quantity_Controller.text,
                                        "UNIT_ID": unitId,
                                        "PRICE": "",
                                        "REMARK": remak_controller.text,
                                        "SIZE": "",
                                        "TASK": "ADD",
                                        "EXTRA1": "",
                                        "EXTRA2": "",
                                        "EXPENCE_DATE": selectDate,
                                        "EXPENCE_TIME": "",
                                        "PLOT_ID": widget.plotId,
                                        "EXP_ID": "",
                                        "WATER": "",
                                        "NO_OF_DAYS": ""
                                      });
                    
                                      authViewMode
                                          .addExpencepost(data, context)
                                          .then((value) {
                                                                     clearAll();
                                        if (kDebugMode) {
                                          
                                        }
                                        return value;
                                      });
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        border:
                                            Border.all(width: 1, color: kWhite),
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
                    ),
                   
                   
                   
                   
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: GreenA100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From Date",
                                            style: TextStyle(
                                                color: kblack, fontSize: 15),
                                          ),
                                          SizedBox(height: 6),
                                          InkWell(
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                  firstDate: DateTime(2002));
                                              if (date != null) {
                                                from_date_Controller.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(date);
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: kgreyy),
                                                color: kWhite,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    height: 30,
                                                    child: TextField(
                                                      enabled: false,
                                                      controller:
                                                          from_date_Controller,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 16,
                                                                left: 6,
                                                                right: 6),
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
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "To Date",
                                            style: TextStyle(
                                                color: kblack, fontSize: 15),
                                          ),
                                          SizedBox(height: 6),
                                          InkWell(
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now(),
                                                  firstDate: DateTime(2002));
                                              if (date != null) {
                                                to_date_Controller.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(date);
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: kgreyy),
                                                color: kWhite,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    height: 30,
                                                    child: TextField(
                                                      enabled: false,
                                                      controller:
                                                          to_date_Controller,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: kgreyy,
                                                            fontSize: 13),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 16,
                                                                left: 6,
                                                                right: 6),
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
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: InkWell(
                                          onTap: () {
                                         purchesdropViewModel.totalExpanseApi(widget.userID,widget.plotId,from_date_Controller.text, to_date_Controller.text,);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: kgreen,
                                              border: Border.all(
                                                  width: 2, color: kWhite),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 15),
                                              ),
                                            ),
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
                      ),
                    ),
                   
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text("Add Expense",
                          style: TextStyle(color: kblack, fontSize: 20)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: listdemo(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              color: kpink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Expense :-",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ₹${totalExpance == null ? '0.0':totalExpance}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget catName() {
    // final cityapi = Provider.of<CityApiProvider>(context);

    return ChangeNotifierProvider<ExpansesViewModel>(
        create: (BuildContext context) => expansesViewModel,
        child: Consumer<ExpansesViewModel>(builder: (context, value, _) {
          switch (value.categoryNameList.status!) {
            case Status.LOADING:
              return SizedBox();
            case Status.ERROR:
              return Center(
                  child: Text(value.categoryNameList.message.toString()));
            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Util.backgroundImage))),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          SelectCategory;
                        });
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              MediaQuery.of(context).size.width / 1,
                              MediaQuery.of(context).size.height / 3,
                              MediaQuery.of(context).size.width / 3,
                              MediaQuery.of(context).size.height / 15),
                          items:
                              value.categoryNameList.data!.data.map((option) {
                            return PopupMenuItem<String>(
                              value: option.catId.toString(),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      SelectCategory =
                                          option.catName.toString();
                                      catID = option.catId;

                                      expansesViewModel.productListDropDownList(
                                          widget.userID, option.catId);
                                      Selectunit = 'Unit';
                                      Navigator.pop(context);
                                    });
                                    // print(  SelectOption = option.catName);
                                    // SelectOption = option.catName;
                                  },
                                  child: Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width,
                                      child: option.catName == null
                                          ? SizedBox()
                                          : Text(option.catName.toString()))),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(SelectCategory),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
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
                      });

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

                                    purchesdropViewModel.unitCountListView(
                                        option.unitId, catID, productId,widget.userID);
                                    Navigator.pop(context);
                                  });
                                  print(' dsdff ${option.unitId}');
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

  Widget productName() {
    // final cityapi = Provider.of<CityApiProvider>(context);
    return ChangeNotifierProvider<ExpansesViewModel>(
        create: (BuildContext context) => expansesViewModel,
        child: Consumer<ExpansesViewModel>(builder: (context, value, _) {
          switch (value.productNameList.status!) {
            case Status.LOADING:
              return SizedBox();
            case Status.ERROR:
              return Center(
                  child: Text(value.productNameList.message.toString()));
            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
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
                              MediaQuery.of(context).size.width / 1,
                              MediaQuery.of(context).size.height / 3,
                              MediaQuery.of(context).size.width / 3,
                              MediaQuery.of(context).size.height / 15),
                          items: value.productNameList.data!.data.map((option) {
                            return PopupMenuItem<String>(
                              value: option.catId.toString(),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      SelectProduct =
                                          option.productName.toString();
                                      productId = option.productId;
                                      print('crop Id ${option.productId}');

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
                                          : Text(
                                              option.productName.toString()))),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(SelectProduct),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
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
                                  Center(
                                      child: InkWell(
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
                                      )),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
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

  Widget Count() {
    return SizedBox(
      height: 15,
      width: 100,
      child: ChangeNotifierProvider<PurchesdropViewModel>(
          create: (BuildContext context) => purchesdropViewModel,
          child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
            switch (value.unitcountList.status!) {
              case Status.LOADING:
                return Text('');
              case Status.ERROR:
                return Center(
                    child: Text(value.unitcountList.message.toString()));
              case Status.COMPLETED:
                return ListView(
                    scrollDirection: Axis.horizontal,
                    children: value.unitcountList.data!.data.map((option) {
                      quantity = option.quantity;
                      return Row(
                        children: [
                          Text(option.quantity.toString(),
                              style: TextStyle(color: kgrey)),
                          SizedBox(
                            width: 1,
                          ),
                          Text(Selectunit, style: TextStyle(color: kgrey)),
                        ],
                      );
                    }).toList());
            }
          })),
    );
  }

  void clearAll() {
    SelectCategory = 'Select Category';
    SelectProduct = 'Select Product';
    Selectunit = 'Unit';
    quantity_Controller.clear();
    remak_controller.clear();
  }

   Widget listdemo() { 

 return ChangeNotifierProvider<PurchesdropViewModel>(
          create: (BuildContext context) => purchesdropViewModel,
          child: Consumer<PurchesdropViewModel>(builder: (context, value, _) {
            switch (value.totalExpanseListList.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator(),);
              case Status.ERROR:
                return Center(
                    child: Text(value.totalExpanseListList.message.toString()));
              case Status.COMPLETED:
                return value.totalExpanseListList.data!.data.isEmpty?Image.asset("assets/images/no_data_faund.jpg"):
                         ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: value.totalExpanseListList.data!.data.length,
          
          itemBuilder: (context, index) {
            totalExpance = value.totalExpanseListList.data!.data[0].totalExpence;
            return Material(
                         elevation: 5,
                         borderRadius: BorderRadius.circular(8),
                         child: Container(
                           height: 95,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(3),
                               color: kWhite,
                               border: Border.all(width: 3, color: pgrey)),
                           child: Padding(
                             padding:
                                 const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     Text("Product Name",
                                         style: TextStyle(
                                           color: kgreyy,
                                           fontSize: 13,
                                         )),
                                     Text(
                                         " ${value.totalExpanseListList.data!.data[index].productName}",
                                         style: TextStyle(
                                             color: kblack,
                                             fontSize: 12,
                                             fontWeight: FontWeight.bold))
                                   ],
                                 ),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Row(
                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                         Text("Quantity:-",
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                         Text(
                                            value.totalExpanseListList.data!.data[index].quantity.toString(),
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                       ],
                                     ),
                                     SizedBox(
                                       width: 50,
                                     ),
                                     Row(
                                       children: [
                                         Text(" Unit",
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                         Text(
                                             value.totalExpanseListList.data!.data[index].unitName
                                                 .toString(),
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                       ],
                                     )
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                         Text("Category:-",
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                         Text(
                                            value.totalExpanseListList.data!.data[index].catName
                                                 .toString(),
                                             style: TextStyle(
                                               color: kgreyy,
                                               fontSize: 13,
                                             )),
                                       ],
                                     ),
                                     Icon(
                                       Icons.arrow_right_alt_sharp,
                                       size: 28,
                                       color: kgreen,
                                     )
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Text(" Remark :-",
                                         style: TextStyle(
                                           color: kblack,
                                           fontSize: 13,
                                         )),
                                     Text(value.totalExpanseListList.data!.data[index].remark.toString(),
                                         style: TextStyle(
                                           color: kgreyy,
                                           fontSize: 13,
                                         )),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ),
            );
          });
  }
            
			 }));    


}
}

