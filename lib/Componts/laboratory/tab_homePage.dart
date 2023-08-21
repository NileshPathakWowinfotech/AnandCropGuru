import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Colors.dart';

import '../../data/Model/soli_testing_type_model.dart';
import '../../utils/util.dart';
import 'lab_tab.dart';

class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key, required this.item});
  final Datum item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        flexibleSpace: Image(
          image: AssetImage(Util.backgroundImage),
          fit: BoxFit.cover,
        ),
        title: Text(
          'Anand Biochem R & D Center',
          style: TextStyle(
              fontSize: 17, color: kgreyy, fontWeight: FontWeight.bold),
        ),
      ),
      body: Lab_tab(
        category: item,
      ),
    );
  }
}
