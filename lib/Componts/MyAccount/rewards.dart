


import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class Rewards extends StatelessWidget {
  const Rewards({Key? key}) : super(key: key);

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
          "Rewards",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
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
           
           
         
            Image.asset("assets/images/social.jpg"),
            SizedBox(height: 50,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Container(
               alignment: Alignment.center,
               height: 48,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 color: lgery,
               ),
               child: Text(
                 "Wallet Amount = Rs.0",
                 style: TextStyle(
                     color: kblack,
                     fontSize: 15,
                     fontWeight: FontWeight.bold),
               ),
      
             ),
           ),
            SizedBox(height: 25,),
            Divider(thickness: 1,) ,
            SizedBox(height: 25,),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "My Rewards >>",
                    style: TextStyle(
                        color: kblack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
      
      
          ],
        ),
      ),

    );
  }
}
