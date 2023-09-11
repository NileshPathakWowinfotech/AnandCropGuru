import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Demo/cutomDropDown.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/diary_view_model.dart';

class AddDiaryFrom extends StatefulWidget {
  const AddDiaryFrom({super.key, required this.item});
  final PlotModel item;

  @override
  State<AddDiaryFrom> createState() => _AddDiaryFromState();
}

class _AddDiaryFromState extends State<AddDiaryFrom> {
  TextEditingController questtionansController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  dynamic imageData = "";
  File? image;
  int selectedValue = 1; // Default selected value

  void handleRadioValueChange(int? value) {
    setState(() {
      selectedValue = value!;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final addDiaryViewModel = Provider.of<DiaryDetailsViewModel>(context);
    DateTime selectedDate = context.watch<SelectedDateProvider>().selectedDate;
   
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: kWhite,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: kgrey,
              )),
          title: Text(
            'Diary',
            style: TextStyle(
                color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kblack),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                activeColor: kdarkblue,
                                groupValue: selectedValue,
                                onChanged: handleRadioValueChange,
                              ),
                              Text(
                                'Spray',
                                style: TextStyle(color: kblack, fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                activeColor: kdarkblue,
                                groupValue: selectedValue,
                                onChanged: handleRadioValueChange,
                              ),
                              Text(
                                'Fertilizer',
                                style: TextStyle(color: kblack, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title:",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 43,
                          child: TextFormField(
                            controller: titleController,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: 'Title',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Text(
                          "Date:",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (newDate != null) {
                              context
                                  .read<SelectedDateProvider>()
                                  .updateSelectedDate(newDate);
                            }
                          },
                          child: Container(
                              height: 43,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                          SizedBox(height: 8,),
                        Text(
                          " Enter Question :",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: questtionansController,
                          maxLines: 5,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: 'Enter Question',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      
                        Text(
                          "Select Image :",
                          style: TextStyle(
                              color: kblack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                context: context,
                                builder: (BuildContext mContext) {
                                  return Container(
                                    height: 140,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => PickImageImag(
                                              ImageSource.gallery),
                                          child: Image.asset(
                                            "assets/images/gallary.png",
                                            height: 90,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              PickImageImag(ImageSource.camera),
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            height: 45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kgrey),
                            ),
                            child: Center(
                              child: image != null
                                  ? Image.file(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      image!,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.asset(
                                      width: 40,
                                      height: 40,
                                      "assets/images/camera.png",
                                      color: kgreen,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  if(titleController.text.isEmpty){
                    Util.flushBarErrorMessage("please Enter Title", context);
                  }else if(questtionansController.text.isEmpty){ 
                      Util.flushBarErrorMessage("please Enter Question", context);

                  }else {
                    addDiaryViewModel.addDiaryDetails(context,titleController.text,questtionansController.text,widget.item.userId,widget.item.plotId,imageData.toString(),widget.item.cropId);
                  }
                 
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: lgreen,
                  ),
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
