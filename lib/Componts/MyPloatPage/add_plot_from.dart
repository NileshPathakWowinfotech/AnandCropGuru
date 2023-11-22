import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/crop_list_view_model.dart';

class AddNewPlotFrom extends StatefulWidget {
  const AddNewPlotFrom({super.key});

  @override
  State<AddNewPlotFrom> createState() => _AddNewPlotFromState();
}

class _AddNewPlotFromState extends State<AddNewPlotFrom> {
  CropAddListViewModel CropViewvarityModel = CropAddListViewModel();
  List<String> items = <String>[
    'Soil type',
    'Light clay',
    'Medium red',
    'Black',
    'Medium Black',
    'Black solid',
    'Limestone',
    'Sherwat' ', Light Soil',
    'sandy soil'
  ];
  String dropdownvalue = 'Soil type';
  String _selectedGender = 'male';
  String _methoad = "k";

  @override
  void initState() {
    //  CropViewvarityModel.cropVarietyApi();
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
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add new plot (Capsicum)',
          style: TextStyle(
              color: kgrey, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Crop Variety:",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  bttomSheet();
                  CropViewvarityModel.cropVarietyApi();
                },
                child: TextField(
                  enabled: false,

                  // controller: _mobile,
                  decoration: InputDecoration(
                    isDense: true, // important line
                    contentPadding: EdgeInsets.fromLTRB(13, 13, 13, 13),
                    //errorText: _mobileValidated ? null : _mobileError,

                    hintText: 'Crop Variety',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Soil Type:",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      iconSize: 34,
                      value: dropdownvalue,
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
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
              SizedBox(
                height: 10,
              ),
              Text(
                "Is your crop pruned / planted?:",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: kblue,
                          value: 'Yes',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                            
                              _selectedGender = value!;
                            
                            });
                          },
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 15,
                              fontFamily: 'newfont'),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: kblue,
                          value: 'No',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                              print('${_selectedGender}');
                            });
                          },
                        ),
                        Text(
                          " No",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 15,
                              fontFamily: 'newfont'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
             
              Text(
                "Please select Plantation type:",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                        height: 300,
                        color: kWhite,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              color: kgreen,
                              child: Center(
                                child: Text(
                                  "Please select Plantation type",
                                  style: TextStyle(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    border: Border.all(
                                        width: 0, color: Colors.grey)),
                                child: ListTile(
                                    title: Text(
                                        "Summer Season Capcicum Plantation"))),
                            Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    border: Border.all(
                                        width: 0, color: Colors.grey)),
                                child: ListTile(
                                    title: Text(
                                        "Summer Season Capcicum Plantation"))),
                          ],
                        )),
                  );
                },
                child: TextField(
                  enabled: false,

                  onTap: () {
                    Get.bottomSheet(
                      Container(
                          height: 300,
                          color: Colors.greenAccent,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                color: kgreen,
                              ),
                            ],
                          )),
                    );
                  },
                  // controller: _mobile,
                  decoration: InputDecoration(
                    isDense: true, // important line
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    //errorText: _mobileValidated ? null : _mobileError,

                    hintText: 'Please select Plantation type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            _selectedGender == "No"?
              Text(
                "Select the Pruning / sowed/ pruning type ",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ):Text("Select the Pruning / planting date",style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              TextField(
                // controller: _mobile,
                decoration: InputDecoration(
                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Please select date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Garden method",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0, color: Colors.grey)),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: kblue,
                      value: 'vv',
                      groupValue: _methoad,
                      onChanged: (value) {
                        setState(() {
                          print(_selectedGender);
                          // _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      "Poly",
                      style: TextStyle(
                          color: kblack, fontSize: 15, fontFamily: 'newfont'),
                    ),
                     Radio<String>(
                      activeColor: kblue,
                      value: 'vv',
                      groupValue: _methoad,
                      onChanged: (value) {
                        setState(() {
                          print(_selectedGender);
                          // _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      "Shednet",
                      style: TextStyle(
                          color: kblack, fontSize: 15, fontFamily: 'newfont'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
           
            Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0, color: Colors.grey)),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: kblue,
                      value: 'vv',
                      groupValue: _methoad,
                      onChanged: (value) {
                        setState(() {
                          print(_selectedGender);
                          // _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      "Mulching",
                      style: TextStyle(
                          color: kblack, fontSize: 15, fontFamily: 'newfont'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
                Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0, color: Colors.grey)),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: kblue,
                      value: 'vv',
                      groupValue: _methoad,
                      onChanged: (value) {
                        setState(() {
                          print(_selectedGender);
                          // _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      "M",
                      style: TextStyle(
                          color: kblack, fontSize: 15, fontFamily: 'newfont'),
                    ),
                  ],
                ),
              ),
              Text(
                "Garden method",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15,),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0, color: Colors.grey)),
                child: Row(
                  children: [
                   Expanded(child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: kpareatgreen ,
                       borderRadius: BorderRadius.circular(15),
                        ),),
                   )),
                   Icon(Icons.cancel),
                   Expanded(child: Container(
                    height: 38,
                      decoration: BoxDecoration(
                        color: kpareatgreen ,
                       borderRadius: BorderRadius.circular(15),
                        ),
                  )),
                  ],
                ),
              ),
               SizedBox(height: 20,),
                Container(
                height: 45,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0, color: Colors.grey)),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: kblue,
                      value: 'vv',
                      groupValue: _methoad,
                      onChanged: (value) {
                        setState(() {
                          print(_selectedGender);
                          // _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      "Bed",
                      style: TextStyle(
                          color: kblack, fontSize: 15, fontFamily: 'newfont'),
                    ),
                  ],
                ),
              ),
               Text(
                "Choose plantation type",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                // controller: _mobile,
                decoration: InputDecoration(
                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  //errorText: _mobileValidated ? null : _mobileError,


                  hintText: 'Total Area (Acers)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            SizedBox(height: 10,),
              Text(
                "Total Area (Acers):",
                style: TextStyle(
                    color: kgreen, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                // controller: _mobile,
                decoration: InputDecoration(
                  isDense: true, // important line
                  contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  //errorText: _mobileValidated ? null : _mobileError,

                  hintText: 'Total Area (Acers)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: kgreen, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bttomSheet() {
    Get.bottomSheet(SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            color: lgreen,
            child: Center(
              child: InkWell(
                onTap: () {
                  CropViewvarityModel.cropVarietyApi();
                },
                child: Text(
                  'Crop variety :',
                  style: TextStyle(
                      color: kWhite, fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          ChangeNotifierProvider<CropAddListViewModel>(
            create: (BuildContext context) => CropViewvarityModel,
            child: Consumer<CropAddListViewModel>(builder: (context, value, _) {
              switch (value.cropVarietyList.status!) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.cropVarietyList.message.toString()));
                case Status.COMPLETED:
                  return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Util.backgroundImage))),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.cropVarietyList.data!.data.length,
                          // physics: NeverScrollableScrollPhysics(),

                          itemBuilder: (context, index) {
                            final listItem =
                                value.cropVarietyList.data!.data[index];
                            return Container(
                                // height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                color: kWhite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        value.cropVarietyList.data!.data[index]
                                            .chataniName
                                            .toString(),
                                        style: TextStyle(
                                            color: kblack,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: kblack,
                                    )
                                  ],
                                ));
                          }));
              }
              return Container();
            }),
          ),
        ],
      ),
    ));
  }
}
