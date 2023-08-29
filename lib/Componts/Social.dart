import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/AppBar.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../utils/Colors.dart';
import '../utils/util.dart';

class Social extends StatelessWidget {
  Social({Key? key}) : super(key: key);
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
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
          "Social",
          style: TextStyle(
              color: kgrey, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/social_banner.png"),
          SizedBox(
            height: 50,
          ),
          Text(
            "Contact us",
            style: TextStyle(
                color: kblack, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "खाली दिलेल्या माध्यमांतून तुम्ही आमच्याशी संपर्क करू\nशकता.",
            style: TextStyle(
              color: kblack,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Divider(
            height: 2,
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    final link = WhatsAppUnilink(
                      phoneNumber: "7219315664",
                    );
                    await launch('$link');
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/whatsapp.png",
                        height: 45,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Whatsapp",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print("hello");

                    url = "https://www.facebook.com/drcropguru";
                    if (await canLaunch(url!)) {
                      await launch(
                        url!,
                        headers: {
                          "Content-Type": "application/x-www-form-urlencoded",
                          "Content-Disposition": "inline"
                        },
                      );
                      print("browser url");
                      print(url);
                    } else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/facebook.png",
                        height: 45,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "FaceBook",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print("hello");
                    url = "www.instagram.com/drcropguru";
                    if (await canLaunch(url!)) {
                      await launch(
                        url!,
                        headers: {
                          "Content-Type": "application/x-www-form-urlencoded",
                          "Content-Disposition": "inline"
                        },
                      );
                      print("browser url");
                      print(url);
                    } else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/insta.png",
                        height: 45,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Instagram",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print("hello");

                    url = "https://www.youtube.com/drcropguru";
                    if (await canLaunch(url!)) {
                      await launch(
                        url!,
                        headers: {
                          "Content-Type": "application/x-www-form-urlencoded",
                          "Content-Disposition": "inline"
                        },
                      );
                      print("browser url");
                      print(url);
                    } else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/youtube.png",
                        height: 45,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Youtube",
                        style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
