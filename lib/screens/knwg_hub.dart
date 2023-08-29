

import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/util.dart';

class KnwgHub extends StatefulWidget {
  const KnwgHub({super.key});

  @override
  State<KnwgHub> createState() => _KnwgHubState();
}

class _KnwgHubState extends State<KnwgHub> {
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
            child: Icon(Icons.arrow_back, color: kgrey)),
        title: Text(
          "Knwledge Hub",
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
               borderRadius: BorderRadius.circular(5),
              child: Container( 
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.circular(5),
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Text("Acriculature depend busnesses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                     Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: kWhite),
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/images/social_banner.pngF'),
                            )),)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}