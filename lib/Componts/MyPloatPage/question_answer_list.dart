

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/MyPloatPage/question_details.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model.dart';
import '../../view_model/myplot_view_model/question_answer.dart';
import 'add_your_question.dart';

class QuestionAnswer extends StatefulWidget {
   QuestionAnswer({Key? key, required this.item}) : super(key: key);
   final  PlotModel item;

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> with TickerProviderStateMixin{


    QutionAnswerViewModel qutionAnswerViewModel = QutionAnswerViewModel();

  String? msg;
  String?data ;
  late AnimationController _controller;
  @override
  void initState() {
   // questionAnswerlist(); 
    qutionAnswerViewModel.questionAnswerListView(widget.item.userId, widget.item.plotId);
    
    // _controller = AnimationController(
    //   duration: const Duration(
    //       milliseconds: 3000),
    //   vsync: this,
    // );
    // _controller.addListener(() {
    //   if (_controller.isCompleted) {
    //     _controller.reset();
    //     _controller.forward();
    //   }
    // });
    // WidgetsBinding.instance
    //     .addPostFrameCallback(
    //         (timeStamp) {
    //       Util.animatedProgressDialog(
    //           context, _controller);
    //       _controller.forward();
    //     });
    // questionAnswerlist().then((value) {
    //   _controller.reset();
    //   Navigator.pop(context);
    //   setState(() {});
    //   return value;
    // });
    

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
               image: DecorationImage( 
                image: AssetImage(Util.backgroundImage),
                fit: BoxFit.cover
               )
              ),
            ),

            
           
            leading: Builder(
              builder: (context) => IconButton(
                icon: InkWell(
                  onTap: (){
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
            title: InkWell(
              onTap: (){
                qutionAnswerViewModel.questionAnswerListView(widget.item.userId.toString(), widget.item.plotId.toString());
              },
              child: Text('Question Answer',
                style: TextStyle(color: kgrey, fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
          ),
      body:

           ChangeNotifierProvider<QutionAnswerViewModel>(
        create: (BuildContext context) => qutionAnswerViewModel,
        child: Consumer<QutionAnswerViewModel>(builder: (context, value, _) {
          switch (value.questionList.status!) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.questionList.message.toString()));
            case Status.COMPLETED:
              return Container(
                decoration: BoxDecoration( 
                   image: DecorationImage(
                    image: AssetImage(Util.backgroundImage)
                   )
                ),
                child: ListView.builder(
          shrinkWrap: true,
          itemCount: value.questionList.data!.data.length,
   // physics: NeverScrollableScrollPhysics(),
  
    itemBuilder: (context, index) {
       final listItem  =  value.questionList.data!.data[index];
      return Container(

              decoration: BoxDecoration(
               image: DecorationImage( 
                image: AssetImage(Util.backgroundImage),
                fit: BoxFit.cover
               )
              ),
            

        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: (){
              Get.to(Question_details(item: listItem,));
            },
            child: Container(
      
            decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1, 6), // changes position of shadow
            ),
            ],
      
            ),
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( value.questionList.data!.data[index].fdDescription, style: TextStyle(
                  color: kblack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
              Center(child: Image.network(
                value.questionList.data!.data[index].fdImage,height: 250,errorBuilder: (context, error,
                  stackTrace) {
                return Text("");
              },)),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( value.questionList.data!.data[index].fdDescription,style: TextStyle(
                    color: kgrey,
                    fontSize: 16,
                  )),
      
                  Container(
                    height: 35,
                    width: 90,
      
                    decoration: BoxDecoration(color:value.questionList.data!.data[index].status == "Solved"  ?kgreen : kdarkred,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(value.questionList.data!.data[index].status, style: TextStyle(
                          color: kWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                    ),),
      
                ],
              )
      
            ],
      
      
            ),
            ),
            ),
          ),
        ),
      );
    }
              ));
          }
          return Container();
        }),
      ),
    
    
      
      floatingActionButton: data == "[]" ?Text(""):Container(
        height: 70.0,
        width: 90.0,

        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.orange,
              child: Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("  Add Question",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
              )),

              onPressed: () {
                Get.to(AddYourQuestion(item: widget.item,));
              }),
        ),
      )
    
    );
  }


     
  }

