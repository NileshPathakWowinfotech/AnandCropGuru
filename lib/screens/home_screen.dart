import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:get/get.dart';

import '../Componts/MyFarms.dart';
import '../Componts/Social.dart';
import '../Componts/anand_biochemr_R_&_d_center.dart';
import '../utils/util.dart';
import '../view_model/wather_view_model.dart';
import '../widgets/upper_home_screen.dart';
import 'blogs_Screen.dart';
import 'dr_post_screen.dart';
import 'farming_videos.dart';
import 'knwg_hub.dart';
import 'kurshi_product_Screen.dart';
import 'my_post_home_screen.dart';
import 'notifications.dart';
import 'offer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            shadowColor: Theme.of(context).primaryColor,
            expandedHeight: 415,
            title: Text(
              'Anand CropGuru'
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(Notifications());
                  },
                  icon: Icon(Icons.notifications, color: Colors.white)),
              SizedBox(width: 8),
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(415),
              child: Column(
                children: [
                  UpperHomeScreen(),
                  // Container(
                  //   height: 5,
                  //   color: Colors.white,
                  // ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                // labelStyle: TextStyle(),
                indicatorWeight: 3.5,
                tabs: [
                  Tab(
                    text: 'DR. POST',
                  ),
                  Tab(
                    text: 'BLOGS',
                  ),
                  Tab(
                    text: 'FARMING\n  VIDEOS',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  DrPostScreen(),
                  BolgsScreen(),
                  FarmingVideos()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenfirst extends StatefulWidget {
  const HomeScreenfirst({super.key});

  @override
  State<HomeScreenfirst> createState() => _HomeScreenfirstState();
}

class _HomeScreenfirstState extends State<HomeScreenfirst> {
  WatherViewModel watherViewModel = WatherViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            SerachBarHomePage(),

            //   WetherForcasting(),
            Stack(
              children: <Widget>[
                // Max Size
                Container(height: 210, color: kprimarygreen),
                UpperHomeScreenCarouselSlider(),

                Positioned(
                  top: 150,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: kWhite),
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/images/wether_bannar.jpg'),
                            )),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width - 38),
                  ),
                ),
              ],
            ),

            Modules(),
            SizedBox(child: QutionsAnswrs()),
            
            SizedBox(
              height: 500,
              child: MYPostHomeScreen()),

            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class QutionsAnswrs extends StatefulWidget {
  const QutionsAnswrs({super.key});

  @override
  State<QutionsAnswrs> createState() => _QutionsAnswrsState();
}

class _QutionsAnswrsState extends State<QutionsAnswrs> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  bool _isChecked = false;
  int _selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          color: klorange,
          child: BlinkText(
            'ADD NEW PLOT',
            style: TextStyle(
                fontSize: 15.0,
                color: kprimarygreen,
                fontWeight: FontWeight.bold),
            endColor: Colors.orange,
          ),
        ),
        Center(
          child: Text(
            "प्रश्नमंजुशा",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kprimarygreen),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "आनंद अॅग्रो केअरची स्थापन केव्हा झाली ?",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: kgrey),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.center,
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                  color: kpareatgreen, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "सप्टेंबर २०१०",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: kWhite),
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.center,
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                  color: kpareatgreen, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "सप्टेंबर २०१०",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: kWhite),
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.center,
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                  color: kpareatgreen, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "सप्टेंबर २०१०",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: kWhite),
              ),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue!;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.center,
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                  color: kpareatgreen, borderRadius: BorderRadius.circular(15)),
              child: Text(
                "ऑगस्ट २००९",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: kWhite),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Modules extends StatelessWidget {
  const Modules({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimarygreen,
      child: Column(
        children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(
                      "assets/images/banner1.jpg",
                    ))),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeeByList(
                press: () {
                  Get.to(MyFarms());
                },
                image: 'assets/images/field.png',
                titile: 'My Plot',
              ),
              SeeByList(
                press: () {
                  Get.to(AnandBiochemRandDCenter());
                },
                image: 'assets/images/see_by_list_item_icons/lab.png',
                titile: 'Laboratory',
              ),
              SeeByList(
                press: () {
                  Get.to(OfferScreen());
                },
                image: 'assets/images/offer.png',
                titile: 'Offer',
              ),
              SeeByList(
                press: () {
                  Get.to(FarmingVideos());
                },
                image: 'assets/images/video_icons.png',
                titile: 'Video',
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SeeByList(
                press: () {
                  Get.to(KnwgHub());
                },
                image: 'assets/images/open-book.png',
                titile: 'KNWG HUB',
              ),
              SeeByList(
                press: () {
                  Get.to(KurshiProductSCreen());
                },
                image: 'assets/images/field.png',
                titile: 'Kurshi Product',
              ),
              SeeByList(
                press: () {
                  Get.to(BolgsScreen());
                },
                image: 'assets/images/blog.png',
                titile: 'Blog',
              ),
              SeeByList(
                press: () {
                   Get.to(Social());
                  
                },
                image: 'assets/images/see_by_list_item_icons/social.png',
                titile: 'Social media',
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class SeeByList extends StatelessWidget {
  SeeByList({super.key, this.titile, this.image, required this.press});
  final titile;
  final image;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            press();
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            height: 59,
            width: 59,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          titile,
          style: TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 12),
        )
      ],
    );
  }
}

class WetherForcasting extends StatelessWidget {
  const WetherForcasting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimarygreen,
      height: 300,
      child: Container(
        height: 200,
        child: Stack(
          children: [
            Container(
              height: 10,
              color: Colors.pink,
            ),
            Image.asset(
              "assets/images/banner1.jpg",
            )
          ],
        ),
      ),
    );
  }
}

class SerachBarHomePage extends StatelessWidget {
  const SerachBarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kprimarygreen,
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Container(
              alignment: Alignment.center,
              height: 35,
              decoration: BoxDecoration(
                  color: ksearchBackground,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: kWhite, fontWeight: FontWeight.w300),
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: kWhite,
                    )
                  ],
                ),
              )),
        ));
  }
}
