import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/Model/MyPlotModel.dart/faq_sub_Model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class RepositoryOfKnowledge extends StatelessWidget {
  RepositoryOfKnowledge({
    Key? key,
    required this.submodel,
  }) : super(key: key);
  final FaqSubModel submodel;

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
          ),
        ),
        title: InkWell(
          onTap: () {},
          child: Text(
            'Repository Of Knowledge',
            style: TextStyle(
                color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                submodel.qName,
                maxLines: 3,
                style: TextStyle(
                    color: kgreen,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.network(
                submodel.qImg,
                height: 310,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Html(data: submodel.qAnswer),
            ),
          ],
        ),
      ),
    );
  }
}
