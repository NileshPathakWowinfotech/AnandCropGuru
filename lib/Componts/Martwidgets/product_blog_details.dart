import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/Model/MartModels/productblog_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class ProductBlogDetails extends StatelessWidget {
  const ProductBlogDetails({super.key, required this.blog});
  final ProductBlog blog;

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
            "Blog Details",
            style: TextStyle(color: kgrey),
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                             
                              height: 25,
                              width: 100,
                              color: lblack,
                              child: Text(blog.regDate,style: TextStyle(color: kWhite,fontSize: 15,),),
                            ),
                          ],
                        ),
                        Center(
                            child: Image.network(
                          blog.blogImage,
                          height: 300,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                'assets/images/imagenotavailable.jpg');
                          },
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          blog.blogTitle,
                          style: TextStyle(
                              color: kgreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Html(data: blog.blogDescription),  
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
