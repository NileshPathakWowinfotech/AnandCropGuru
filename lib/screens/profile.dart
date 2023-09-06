
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/select_language_screen.dart';
import 'package:flutter_application_1/screens/update_profile.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Componts/AgronomistLogin/agronomistloginforms.dart';
import '../Componts/MyAccount/Refferal_program.dart';
import '../Componts/MyAccount/about_us.dart';
import '../Componts/MyAccount/bulk_order.dart';
import '../Componts/MyAccount/contact_us.dart';
import '../Componts/MyAccount/privacy_policy.dart';
import '../Componts/MyAccount/return_policy.dart';
import '../Componts/MyAccount/rewards.dart';
import '../Componts/MyAccount/terms_&_conditions.dart';
import '../data/Model/user_model.dart';
import '../utils/Colors.dart';
import '../utils/dummy_data.dart';
import '../utils/prefs_util.dart';
import '../utils/routes/routes_name.dart';
import '../utils/util.dart';
import '../view_model/profile_view_model.dart';
import '../view_model/user_view_model.dart';
import 'my_orders_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileViewModel profileViewModel = ProfileViewModel();


  void setUser() async {
    // user = await PrefsUtil.getUserDetails();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

  setState(() {
      profileViewModel.userDetails();

    // Here you can write your code for open new view
  });

});
  
    
  }

  @override
  Widget build(BuildContext context) {
     final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration( 
          image: DecorationImage( 
            image: AssetImage(Util.backgroundImage),
            fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.black),
                        borderRadius: BorderRadius.circular(60)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(63),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                
      
                  SizedBox(height: 15),
                  Text(profileViewModel.fullName ?? 'No Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color:kblack)),
                  Text('+91${profileViewModel.mobilenumber}',
                      style: TextStyle(color: kblack)),
                 Text(
                          '${profileViewModel.districtname}, ${profileViewModel.districtname}',
                          style: TextStyle(color: Colors.white),
                        )
                  //     : Text('${user?.STATE_NAME}',
                  //         style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 35),
              profileOption(DummyData.profileOptions[0], () {
                Get.to(UpdateProfile());
              }),
              profileOption(DummyData.profileOptions[1], () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersScreen('91'),));
              }),
              profileOption(DummyData.profileOptions[2], () {
               Get.to(BulkOrder());
                
              }
              ),
              profileOption(DummyData.profileOptions[3], () {}),
              profileOption(DummyData.profileOptions[6], () {Get.to(RefrealProgram());}),
              profileOption(DummyData.profileOptions[4], () { Get.to(Rewards());}),
              profileOption(DummyData.profileOptions[5], () {
                Share.share('Dear Farmer Brothers, I am Wow Infotech Tester taking quality products with accurate guidance received on time along with expert and experienced consultants advice on how to do organic farming along with farming problems using Anand Crop Guru application.So you can download this application today and take full advantage of this application and ask your farmer friends and relatives to download the application today.\n https://play.google.com/store/apps/details?id=com.cropguru&hl', subject: 'Dear Farmer Brothers, I am Wow Infotech Tester taking quality products with accurate guidance received on time along with expert and experienced consultants advice on how to do organic farming along with farming problems using Anand Crop Guru application.So you can download this application today and take full advantage of this application and ask your farmer friends and relatives to download the application today. ',);
      
              }),
              profileOption(DummyData.profileOptions[7], ()async {
                Navigator.pop(context);
                String url;
                url =
                "https://play.google.com/store/apps/details?id=com.cropguru&hl";
                if (await canLaunch(url!)) {
                await launch(
                url!,
                headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Content-Disposition": "inline"
                },
                );
                } else
                // can't launch url, there is some error
                throw "Could not launch $url";
              }),
             // profileOption(DummyData.profileOptions[8], () {Get.to(TermsCondidtionweb());}),
             // profileOption(DummyData.profileOptions[9], () {Get.to(ReturnsPolicy());}),
             // profileOption(DummyData.profileOptions[10], () {Get.to(PrivacyPolicy());}),
              profileOption(DummyData.profileOptions[11], () {Get.to(ContactUs());}),
            //  profileOption(DummyData.profileOptions[12], () {Get.to(AbountUs());}),
              profileOption(DummyData.profileOptions[13], () {
                {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 400,
                                      width: MediaQuery.of(context).size.width,
                                      color: kblack,
      
                                      child: Material(
      
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 20,),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
      
      
                                                     Padding(
                                                       padding: const EdgeInsets.symmetric(horizontal: 10),
                                                       child: GestureDetector(
                                                         onTap: (){
                                                           Navigator.pop(context);
                                                         },
                                                         child: Icon(
                                                          Icons.cancel,
                                                          size: 30,
                                                          color: kblack,
                                                    ),
                                                       ),
                                                     ),
                                                    Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage("assets/images/Yes-Bank-logo.png",),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
      
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Center(child: Text("It is mandatory to take membership to avail some services of Anand Crop Guru,For that you can make offline payment using following bank details")),
                                                ),
                                              SizedBox(height: 12,),
                                               Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 15),
                                                 child: Column(
                                                   children: [ Row(
                                                     children: [
                                                       Text(
                                                         "Bank Name :",
                                                         style: TextStyle(
                                                           color: kgrey,
                                                           fontSize: 18,
                                                         ),
                                                       ),
                                                       SizedBox(width: 5,),
                                                       Text(
                                                         "Yes Bank Ltd.",
                                                         style: TextStyle(
                                                             color: kblack,
                                                             fontSize: 18,
                                                             fontWeight: FontWeight.bold
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                     SizedBox(height: 8,),
                                                     Row(
                                                       children: [
                                                         Text(
                                                           "Account No :",
                                                           style: TextStyle(
                                                             color: kgrey,
                                                             fontSize: 18,
                                                           ),
                                                         ),
                                                         SizedBox(width: 5,),
                                                         Text(
                                                           "104863300000860",
                                                           style: TextStyle(
                                                               color: kblack,
                                                               fontSize: 18,
                                                               fontWeight: FontWeight.bold
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(height: 8,),
                                                     Row(
                                                       children: [
                                                         Text(
                                                           "Branch          :",
                                                           style: TextStyle(
                                                             color: kgrey,
                                                             fontSize: 18,
                                                           ),
                                                         ),
                                                         SizedBox(width: 5,),
                                                         Text(
                                                           "Satpur Nashik",
                                                           style: TextStyle(
                                                               color: kblack,
                                                               fontSize: 18,
                                                               fontWeight: FontWeight.bold
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(height: 8,),
                                                     Row(
                                                       children: [
                                                         Text(
                                                           "Ifsc code      :",
                                                           style: TextStyle(
                                                             color: kgrey,
                                                             fontSize: 18,
                                                           ),
                                                         ),
                                                         SizedBox(width: 5,),
                                                         Text(
                                                           "YESB0001048",
                                                           style: TextStyle(
                                                               color: kblack,
                                                               fontSize: 18,
                                                               fontWeight: FontWeight.bold
                                                           ),
                                                         ),
                                                       ],
                                                     )
                                                   ],
                                                 ),
                                               ),
                                                SizedBox(height: 15,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(height: 45,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          border: Border.all(width: 2,color: kgreen)
                                                        ),
                                                      child: Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                            color: kblack,
                                                            fontSize: 18,
      
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
      
      
      
      
      
      
                                              ])))
                                ]));
                      });
                  // Get.to(AddYourQuestion(userID: widget.userId,cropId: widget.cropID,plotId: widget.plotID,));
                }
              }),
             
              profileOption(DummyData.profileOptions[15], () {
                 userPrefernece.remove().then((value) {
                        Navigator.pushNamed(context, RoutesName.login);});
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Anand CropGuru'),
                      content: Text('Do you want to logout ?'),
                      actions: [
                        Text('NO'),
                        Text('YES'),
                      ],
                    );
                  },
                );
                PrefsUtil.removeUser();
                Navigator.of(context)
                    .pushReplacementNamed(SelectLanguageScreen.routeName);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class profileOption extends StatelessWidget {
  Map<String, dynamic> element;
  Function function;

  profileOption(this.element, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: ListTile(
        leading: element['icon'],
        title: Text(element['title']),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
