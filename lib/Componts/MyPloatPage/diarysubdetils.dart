



import 'package:flutter/material.dart';

import '../../data/Model/MyPlotModel.dart/diarydetailslistmodel.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class DiarySubDetails extends StatelessWidget {
  const DiarySubDetails({super.key, required this.item});
 final  DiaryModel item;

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
              )),
          title: Text(
            'Diary Detils',
            style: TextStyle(
                color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
       body: Column( 
        children: [ 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(7),
              child: Container( 
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7) 
                ),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Row(
                      children: [
                       Text('Title :',style: TextStyle(color: kgrey,fontSize: 17, fontWeight: FontWeight.bold),),
                       Text(item.udTitle,style: TextStyle(color: lgreen,fontSize: 17, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Divider(thickness: 1,color: kblack,),
                      Row(
                      children: [
                       Text('Date :',style: TextStyle(color: kgrey,fontSize: 17, fontWeight: FontWeight.bold),),
                       Text(item.regDate,style: TextStyle(color: lgreen,fontSize: 17, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 12,),
                      Text(item.udDesc,style: TextStyle(color: kblack,fontSize: 17),),
                  ],
                ),
              ),
            ),
          )
        ],
       ),
    );
  }
}