import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api/bulk_order_api.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/MyAccount.dart/bulik_order_view_model.dart';

class BulkOrder extends StatefulWidget {
  // BulkOrder({Key? key, this.category, this.amount, this.imageurl, this.videourl}) : super(key: key);

  @override
  State<BulkOrder> createState() => _BulkOrderState();
}

class _BulkOrderState extends State<BulkOrder> with TickerProviderStateMixin {
  String? url;

  TextEditingController shopNameController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addresssController = TextEditingController();
  TextEditingController pannumberController = TextEditingController();
  TextEditingController gstnumberController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  List<String> items = <String>[
    'Select Report Type',
    'Dealership',
    'Distributorship',
    'FPO',
    'Other'
  ];

  String dropdownvalue = 'Select Report Type';

  dynamic imageData = "";

  late AnimationController _controller;

  final anandcenter = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final blukOrderViewModel = Provider.of<BlukOrderViewModel>(context);

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
          "Bulk Order",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(  
                image: DecorationImage( 
                  image: AssetImage(Util.backgroundImage),
                  fit: BoxFit.cover                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                    key: anandcenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Bulk Order Type",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                                //color: kblack,
                                border: Border.all(color: kgrey),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("Select Report Type"),
                                  isExpanded: true,
                                  iconSize: 34,
                                  value: dropdownvalue,
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue ?? '';
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Shop Name / Company Name :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: shopNameController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'Shop Name / Company Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Shop Name / Company Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mobile no",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                            controller: mobilenumberController,
                            onChanged: (value) {},
                            style: TextStyle(fontSize: 13),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
                              hintText: 'mobile no',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  //  color: Util.colorPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "";
                              } else if (value.length < 10) {
                                return '';
                              } else if (!RegExp(
                                      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                  .hasMatch(value)) {
                                return "Please Enter a Valid Phone Number";
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pin Code ",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: pincodeController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                          // maxLength: 10,
                          // controller: _mobile,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            //   errorText: _mobileValidated ? null : _mobileError,
                            //  suffixIcon: Icon(Icons.call),
                            hintText: 'pin code',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Address :",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: addresssController,
                          maxLines: 5,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pan No.",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: pannumberController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'Pan No.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                //  color: Util.colorPrimary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "GST No.",
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: gstnumberController,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            hintText: 'GST No.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                         
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (dropdownvalue == "Select Report Type") {
                Util.flushBarErrorMessage("Select Report Type", context);
              } else if (shopNameController.text.isEmpty) {
                Util.flushBarErrorMessage("Enter Shop Name", context);
              } else if (mobilenumberController.text.isEmpty) {
                Util.flushBarErrorMessage("Enter Mobile Number ", context);
              } else if (pincodeController.text.isEmpty) {
                Util.flushBarErrorMessage("Enter Pin Code Number", context);
              } else if (pannumberController.text.isEmpty) {
                Util.flushBarErrorMessage("Enter Pan Number  ", context);
              } else if (gstnumberController.text.isEmpty) {
                Util.flushBarErrorMessage("Enter Gst Number  ", context);
              } else if(addresssController.text.isEmpty){
                Util.flushBarErrorMessage("Enter Address", context);
              } else {
                blukOrderViewModel.bulkOrderApi(
                    context,
                    mobilenumberController.text,
                    dropdownvalue,
                    shopNameController.text,
                    addresssController.text,
                    pincodeController.text,
                    pannumberController.text,
                    gstnumberController.text);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: kgreen,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
