import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/Model/MyPlotModel.dart/question_answ_model.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Question_details extends StatelessWidget {
  Question_details(
      {Key? key, required this.item})
      : super(key: key);
final Datum item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage( 
                    image: AssetImage(Util.backgroundImage),
                    fit: BoxFit.cover,
                  )
                ),
              ),

            
              leading: Builder(
                builder: (context) =>
                    IconButton(
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
                      MaterialLocalizations
                          .of(context)
                          .openAppDrawerTooltip,
                    ),
              ),
              title: InkWell(
                onTap: () {

                },
                child: Text('Question details',
                  style: TextStyle(color: kgrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        
        body: Container(
          decoration: BoxDecoration(
               image: DecorationImage( 
                image: AssetImage(Util.backgroundImage),
                fit: BoxFit.cover
               )
              ),
          child: Column(
            children: [
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
        
                  decoration: BoxDecoration(
                      color: kWhite,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(4, 4)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.fdDescription,
                              style: TextStyle(color: kblack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(item.regDate,
                              style: TextStyle(color: kgreyy,
                                  fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                         Center(child: Image.network(item.fdImage,errorBuilder: (context, error,
                             stackTrace) {
                           return Text("");
                         }))  ,
        
                        Row(
                          children: [
                            Text(item.fdAnswer == null ?item.fdAnswer : "Unsolved",
                            style: TextStyle(color: kblack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        )
    );
  }
}