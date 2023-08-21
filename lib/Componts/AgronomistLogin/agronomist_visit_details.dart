
import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class AgronomistVisitDetails extends StatelessWidget {
   AgronomistVisitDetails({Key? key, this.name, this.mobilenumber, this.ploatnamee, this.qustions, this.image, this.answer}) : super(key: key);
  final name;
  final mobilenumber;
  final ploatnamee;
  final qustions;
  final image;
  final answer;

  TextEditingController description_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
 //widget.answer = description_Controller.text;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kgreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Agronomist Visit Details",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(

                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(4, 4)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Name :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(name,
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Text("Mobile Number :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(mobilenumber,
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Text("Ploat Name :",
                                  style: TextStyle(fontSize: 14, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(ploatnamee,
                                  style: TextStyle(fontSize: 14, color: kgreen,)),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text("Q:",
                                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: kblack,)),
                              SizedBox(width: 5,),
                              Text(qustions,
                                  style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold,color: kblack,)),
                            ],
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: description_Controller,
                            maxLines: 5,
                            onChanged: (value) {
                            },
                            decoration: InputDecoration(
                              hintText: 'Search by farmer Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  //  color: Util.colorPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Description can not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15,),

                          Center(child: InkWell(
                            onTap: (){
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 14),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  height: 340,
                                                  width: MediaQuery.of(context).size.width,

                                                  child: Material(
                                                      borderRadius: BorderRadius.circular(15),
                                                      child: Stack(
                                                        alignment: Alignment.topRight,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: ClipRRect(
                                                     // borderRadius:BorderRadius.circular(20),
                                                                  child:buildImage() ),
                                                            ),
                                                            Positioned(
                                                              top: 9,
                                                              right: 9,
                                                              child: InkWell(
                                                                onTap: (){
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  color: lgrey,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Image.asset("assets/images/close.png",height: 10,width: 10,),
                                                                  ),
                                                                ),
                                                              ),
                                                            )

                                                          ])))
                                            ]));
                                  });
                            },
                            child: Image.network(image,height:200,width: MediaQuery.of(context).size.width , fit: BoxFit.fill,errorBuilder: (context, error,
                                stackTrace) {
                              return Text("");
                            }),
                          ))  ,

                          SizedBox(height: 15,),
                        ],
                      ),
                    )
                ),
              ),
            ),
            SizedBox(height: 80,),
           
            Container(
              alignment: Alignment.center,
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                color: kgreen,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text("Submit",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,  color: Colors.white,)),
            )
          ],
        ),
      ),
    );
  }
  Widget buildImage()=> InteractiveViewer(child: AspectRatio(
    aspectRatio: 1,
    child: Image.network(image,fit: BoxFit.fill,),
  ));
}
