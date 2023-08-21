import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
class TodaysWork extends StatelessWidget {
  const TodaysWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kgreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Today's Work",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,  color: Colors.white,)),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              child: InkWell(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                Text("RajText",
                                    style: TextStyle(fontSize: 25, color: kgreen,fontWeight: FontWeight.bold)),
                                SizedBox(width: 7,),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Mobile no :",
                                    style: TextStyle(fontSize: 15, color: kblack)),
                                SizedBox(width: 5,),
                                Text("945484548",
                                    style: TextStyle(fontSize: 15, color: kgreen)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("City Name :",
                                    style: TextStyle(fontSize: 15, color: kblack)),
                                SizedBox(width: 5,),
                                Text("Dhule",
                                    style: TextStyle(fontSize: 15, color: kgreen)),
                              ],
                            ),


                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 38,
                              width: 130,
                              decoration: BoxDecoration(
                                color: kgreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text("Added Demo",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,  color: Colors.white,)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
