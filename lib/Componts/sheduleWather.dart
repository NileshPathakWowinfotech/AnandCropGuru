import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_html/flutter_html.dart';

import '../data/Model/weather_shedule_model.dart';

class WatherScheduleDetails extends StatefulWidget {
  const WatherScheduleDetails({super.key, required this.item});
  final SceduleWatherModel item;

  @override
  State<WatherScheduleDetails> createState() => _WatherScheduleDetailsState();
}

class _WatherScheduleDetailsState extends State<WatherScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kgrey,
          ),
        ),
        flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              widget.item.title,
                              style: TextStyle(
                                  color: kgreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              widget.item.regDate,
                              style: TextStyle(
                                  color: kgrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "फवारणी :-",
                                  style: TextStyle(color: kgrey, fontSize: 13),
                                ),
                              ),
                              Expanded(
                                  child: Html(
                                data: widget.item.description,
                              ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "खते :-",
                                  style: TextStyle(color: kgrey, fontSize: 13),
                                ),
                              ),
                              Expanded(child: Html(data: widget.item.spray))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "मासागतीचे खते,",
                                  style: TextStyle(color: kgrey, fontSize: 13),
                                ),
                              ),
                              Expanded(child: Html(data: widget.item.spray))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                            ' या दिसापासून:- ${ widget.item.fromDay.toString()}',
                              style: TextStyle(color: kgrey, fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                               'या दिवसापर्यंत:- ${ widget.item.toDay.toString()}',
                              style: TextStyle(color: kgrey, fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container( 
                            height: 150,
                            decoration: BoxDecoration(
                               image: DecorationImage( 
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.item.sImage.toString())
                               )
                            ),
                          ),
                          
                          Html(data: widget.item.mashagaticheKame),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
