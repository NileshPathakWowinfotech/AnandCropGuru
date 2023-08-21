// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../Demo/Ploat.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
import 'MyPlot.dart';
import 'Purchase.dart';

class MyFarms extends StatefulWidget {
  @override
  _MyFarmsState createState() => _MyFarmsState();
}

class _MyFarmsState extends State<MyFarms> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation,

      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
        backgroundColor: kWhite,
        title: Text(
          "My Plot",
          style: TextStyle(
            color: kgrey,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: kgrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        children: [
          // give the tab bar a height [can change hheight to preferred height]
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
               boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 0.0,
              ),
            ]),
            child: Material(
              elevation: 10,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: kgreen,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                indicatorWeight: 5.5,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'My Plot',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Purchase',
                  ),
                ],
              ),
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Ploat(),

                // second tab bar view widget
                Purchase(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
