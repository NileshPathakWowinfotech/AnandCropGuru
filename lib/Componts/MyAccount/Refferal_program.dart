import 'package:flutter/material.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';

class RefrealProgram extends StatefulWidget {
  const RefrealProgram({super.key});

  @override
  State<RefrealProgram> createState() => _RefrealProgramState();
}

class _RefrealProgramState extends State<RefrealProgram> {
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
          "Bulk Order",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              "Referal Count : 14 ",
              style: TextStyle(color: Colors.orange),
            ),
            Container(
              height: 50,
              color: lgreen2,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name ",
                      style: TextStyle(
                          color: kprimarygreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "No.Of Plot ",
                      style: TextStyle(
                          color: kprimarygreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Total Order ",
                      style: TextStyle(
                          color: kprimarygreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Lab\nEnquiry(Qty) ",
                      style: TextStyle(
                          color: kprimarygreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: kgrey)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Raj ",
                      
                      style: TextStyle(color: kblack, fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: kblack, fontSize: 15),
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: kblack, fontSize: 15),
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: kblack, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
