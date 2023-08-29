
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/community.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/mart.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/widgets/ftechmvvmdemo.dart';

import 'Componts/anand_biochemr_R_&_d_center.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
   HomeScreenfirst(),
    //HomeScreen(),
    Communitty(),
    Mart(),
    MyPostApi(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
           appBar: AppBar(
        backgroundColor: kprimarygreen,
        title: InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/images/white_theam_logo.png',
            height: 40,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            width: 130,
            height: 38,
            decoration: BoxDecoration(
                color: klgreen, borderRadius: BorderRadius.circular(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                          left: 8,
                          top: 10,
                          child: Image.asset(
                            "assets/images/trophy.png",
                            color: lgreen,
                            height: 20,
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 10,
                        child: Icon(
                          Icons.notifications,
                          color: lgreen,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        bottom: 15,
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 10,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: lgreen,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
          
          resizeToAvoidBottomInset: false,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          // floatingActionButton: Container(
          //   height: 70,
          //   width: 70,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(70),
          //     color: Util.orangee,
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_comment_rounded,
                  size: 30,
                ),
                label: 'Community',
              ),

              // BottomNavigationBarItem(
              //   icon: Stack(
              //     children: [
              //       Positioned(
              //         child: Container(
              //           height: 60,
              //           width: 60,
              //           decoration: BoxDecoration(
              //             color: Util.orangee,
              //             borderRadius: BorderRadius.circular(60),
              //           ),
              //           child: Icon(Icons.access_alarm),
              //         ),
              //       ),
              //     ],
              //   ),
              //   label: '',
              // ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 5,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science_outlined,
                  size: 30,
                ),
                label: 'Lab',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Util.newHomeColor,
            onTap: _onItemTapped,
          ),
        ),
        Positioned(
          bottom: 0,
          right: MediaQuery.of(context).size.width / 2 - 40,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Image.asset('assets/images/englishmart.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
