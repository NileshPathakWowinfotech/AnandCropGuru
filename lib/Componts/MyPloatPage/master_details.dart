import 'package:flutter/material.dart';

import '../../data/Model/MyPlotModel.dart/reportmaster_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class MasterDetails extends StatelessWidget {
  MasterDetails({Key? key,required this.item, })
      : super(key: key);
 
  final ReportMaster item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            
            
          
           flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
        
          leading:InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: kgrey,
                ),
              ),
          title: InkWell(
            onTap: () {},
            child: Text(
              'Question details',
              style: TextStyle(
                  color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(  
              image: AssetImage(Util.backgroundImage)
            )
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 5.0,
                    child: Container(
                      //  height: 420,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(2, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.regDate,
                                      style: TextStyle(
                                        color: kgreyy,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Text("Title",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(item.reportType,
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 16,
                                  )),
                              Center(
                                  child: Image.network(
                                item.reportImg,
                                height: 250,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
                              )),
                              Text("Description :",
                                  style: TextStyle(
                                      color: kblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(item.reportDesc,
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 16,
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Admin Remark-",
                                  style: TextStyle(
                                    color: kblack,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        )),
                  )),
            ],
          ),
        ));
  }
}
