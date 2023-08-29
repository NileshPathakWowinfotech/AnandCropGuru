import 'package:flutter/material.dart';
import '../utils/Colors.dart';
import '../utils/util.dart';
class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);
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
         "My Post",
          style: TextStyle(
              color: kgrey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
