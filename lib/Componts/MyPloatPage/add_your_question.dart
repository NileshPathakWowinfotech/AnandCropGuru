import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/question_answer.dart';

class AddYourQuestion extends StatefulWidget {
  const AddYourQuestion({
    Key? key,
    required this.item,
  }) : super(key: key);
  final PlotModel item;

  @override
  State<AddYourQuestion> createState() => _AddYourQuestionState();
}

class _AddYourQuestionState extends State<AddYourQuestion> {
  TextEditingController questtionansController = TextEditingController();
  dynamic imageData = "";
  File? image;

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
    final qutionAnswerViewMode = Provider.of<QutionAnswerViewModel>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
                child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                 image: DecorationImage( 
                  image: AssetImage(Util.backgroundImage ),
                  fit: BoxFit.cover
                 )
                ),
              ),
              
              elevation: 0,
              backgroundColor: Colors.green,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: kgrey,
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              title: Text(
                'Add you Question ',
                style: TextStyle(
                    color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ))),
        body: Container( 
          decoration: BoxDecoration( 
            image: DecorationImage( 
              image: AssetImage(Util.backgroundImage)
            )
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Question :",
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
                                        onTap: () =>
                                            PickImageImag(ImageSource.gallery),
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
                                    height: MediaQuery.of(context).size.height,
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
                Spacer(),
                InkWell(
                  onTap: () {
                    if (questtionansController.text.isEmpty) {
                      Util.flushBarErrorMessage('Enter Your Questions', context);
                      // Navigator.pop(context);
                    } else {
                      final data = jsonEncode({
                        "USER_ID": widget.item.userId,
                        "PLOT_ID": widget.item.plotId,
                        "QUESTION_ID": "1",
                        "AGRONOMIST_ID": '0',
                        "QUESTION": questtionansController.text,
                        "QUESTION_ANSWER": '',
                        "QUESTION_CAT": "1",
                        "LOCATION":
                            "Rachita Constructions Bldg, Next to HDFC Bank, Thatte Nagar, Off College Road, Thatte Nagar, Nashik, Maharashtra 422005, India",
                        "LATITUDE": "20.0087082",
                        "LONGITUDE": "73.7639191",
                        "ANS_IMAGE": imageData.toString(),
                      });
                      print(data);
                       qutionAnswerViewMode.qutionAnswerApi(data, context);
                       
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color:  lgreen,
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
            ),
          ),
        ));
  }
}
