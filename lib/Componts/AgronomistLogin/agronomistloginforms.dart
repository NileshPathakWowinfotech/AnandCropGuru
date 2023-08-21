


import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componts/AgronomistLogin/todays_work.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import 'myPlot.dart';

class AgronmistLoginForms extends StatefulWidget {
   AgronmistLoginForms({Key? key}) : super(key: key);

  @override
  State<AgronmistLoginForms> createState() => _AgronmistLoginFormsState();
}

class _AgronmistLoginFormsState extends State<AgronmistLoginForms> {
  bool chek = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
         title: Text("Agronomist Login",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){

              },
                child: Image.asset("assets/images/logout.png", height: 40,width: 30,color: kWhite,)),
          ),
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: (){
                    setState(() {
                      chek = !chek;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:chek == true ? Colors.red : kgreen
                    ),
                    child: Text(chek == true ?"Check Out": "Check In",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,),)
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Personal information :",style:TextStyle(color: kgreen,fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(height: 15,),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround

                        ,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            CircleAvatar(
                              radius: 25,
                            )

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name :",
                                    style: TextStyle(
                                      color: kgrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "  Wow infotech Tester",
                                    style: TextStyle(
                                        color: kgreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3,),
                              SizedBox(
                                  width:MediaQuery.of(context).size.width-100,
                                  child: Container(height: 0,color: kgreyy,)),
                              SizedBox(height: 3,),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                      "Mobile no :",
                                      style: TextStyle(
                                        color: kgreyy,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      " + 91 9403415664",
                                      style: TextStyle(
                                          color: kgreyy,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),



                            ],
                          ),

                        ],
                      ),
                      Positioned(
                        top: 20,
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              color: kgreen,
                              borderRadius: BorderRadius.circular(50)

                          ),
                          child:Text("Update",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 13,  color: Colors.white,)) ,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              FuncnalityUesCropGuru()
            ],
          ),
        ),
      ),
    );
  }
}

class FuncnalityUesCropGuru extends StatelessWidget {
  const FuncnalityUesCropGuru({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(MYploat());
          },
          child: Selectingbuttton(
            image2:"assets/images/cropimage.png" , text2: "My plot",
            text: "Emergency Call ", image: "assets/images/call.png",),
        ),
        SizedBox(height: 10,),
        InkWell(
          onTap: (){
              Get.to(TodaysWork());
          },
          child: Selectingbuttton(
            image2:"assets/images/pepolegroup.jpg" , text2: "My Farmers List",
            text: "Today's Work ", image: "assets/images/todaywork.jpg",),
        ),
        SizedBox(height: 10,),
        Selectingbuttton(
          image2:"assets/images/survey.png" , text2: "Survey",
          text: "Leave", image: "assets/images/leve.jpg",),
        SizedBox(height: 8,),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            height: 150,
            width: 150,

            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: kWhite ,
                  child:Image.asset("assets/images/account.jpg",height: 70,),
                ),
                SizedBox(height: 6,),
                Text(
                  "Account",
                  style: TextStyle(
                      color: kblack,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}



class Selectingbuttton extends StatelessWidget {
  const Selectingbuttton({Key? key, this.image, this.text, this.text2, this.image2}) : super(key: key);
  final image;
  final text;
  final text2;
  final image2;


  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              elevation: 10,
         borderRadius: BorderRadius.circular(5),
              child: Container(
                alignment: Alignment.center,
                height: 150,
                width: 160,

                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: kWhite ,
                      child:Image.asset(image,height: 70,),
                    ),
                    SizedBox(height: 6,),
                    Text(
                    text,
                      style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                alignment: Alignment.center,
                height: 150,
                width: 160,

                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: kWhite ,
                      child:ClipRRect(
                          borderRadius:BorderRadius.circular(5),child: Image.asset(image2,height: 70,)),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      text2,
                      style: TextStyle(
                          color: kblack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

