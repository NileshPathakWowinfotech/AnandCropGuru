import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:get/get.dart';

import '../../data/Model/soli_testing_type_model.dart';
import '../add_anand_bichem_r_d_center.dart';
import 'lab_list.dart';

class Lab_tab extends StatelessWidget {
  Lab_tab({super.key, required this.category});
  final SoilTestingTypeListModelDATA category;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            
            automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: kWhite,
              bottom: new PreferredSize(
                preferredSize: new Size(0.0, 0.0),
                child: new Container(
                  child: TabBar(
                    indicatorColor: kgreen,
                    indicatorWeight: 3,
                    unselectedLabelColor: Colors.red,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add Lab Enquiry",
                          style: TextStyle(
                            color: kblack,
                            fontSize: 16, 
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      Text(
                        "Lab List",
                       style: TextStyle(
                            color: kblack,
                            fontSize: 16, 
                            fontWeight: FontWeight.w700
                          ),
                      )
                    ],
                  ),
                ),
              )),
          body: Container(
              child: TabBarView(
            children: [
              AddAnandBichemRDCenter(
                category: category,
              ),
              lab_List(category: category,)
            ],
          )),
        ));
  }
}
