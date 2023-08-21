

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../add_purchase.dart';
import 'add_purchase.dart';
import 'expenses.dart';
import 'income.dart';

class Diary extends StatefulWidget {
   Diary({Key? key, this.userId, this.plotID, this.cropID}) : super(key: key);
   final userId;
   final plotID;
   final cropID;

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with SingleTickerProviderStateMixin  {
  late  TabController _tabController;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
              flexibleSpace: Image( 
                image: AssetImage(Util.backgroundImage),
                fit: BoxFit.cover,
              ),
              leading: InkWell(
                    onTap: ()=>  Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: kgrey,
                    ),
                  ),
              title: Text('New Schedule',
                style: TextStyle(color: kgrey, fontSize: 20,fontWeight: FontWeight.bold),
      
              ),
              actions: [
                Icon(Icons.add,size: 28,),
                InkWell(
                  onTap: (){
                    Get.to(AddPurchases());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Add Purchase',
                      style: TextStyle(color: kgrey, fontSize: 18,fontWeight: FontWeight.bold),
      
                    ),
                  ),
                ),
                SizedBox(width: 8,)
              ],
            ),
      ),
      
      body: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,

                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                  ),
                ]
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: lgreen,

              labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              indicatorWeight: 5.5,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Expenses',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Income',
                ),
              ],
            ),
          ),
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Expenses(userID: widget.userId,cropID: widget.cropID,plotId: widget.plotID,),


                // second tab bar view widget
                Income(userId: widget.userId,cropID: widget.cropID, plotID: widget.plotID,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
