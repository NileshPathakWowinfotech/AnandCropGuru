import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/MyAccount.dart/refreal_program_view_model.dart';

class RefrealProgram extends StatefulWidget {
  const RefrealProgram({super.key});

  @override
  State<RefrealProgram> createState() => _RefrealProgramState();
}

class _RefrealProgramState extends State<RefrealProgram> {
  RefrealProgramViewModel refrealProgram = RefrealProgramViewModel();
  @override
  void initState() {
    refrealProgram.reffrealProgramListAPi();
    // TODO: implement initState
    super.initState();
  }
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
          "Bulk Order",
          style: TextStyle(
              color: kgrey, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ChangeNotifierProvider<RefrealProgramViewModel>(
        create: (BuildContext context) => refrealProgram,
        child: Consumer<RefrealProgramViewModel>(builder: (context, value, _) {
          switch (value.refrealProgramList.status!) {
            case Status.LOADING:
         return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
         return Center(child: Text(value.refrealProgramList.message.toString()));
            case Status.COMPLETED:
         return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [ 
               InkWell(
                onTap: (){
                   refrealProgram.reffrealProgramListAPi();
                },
                 child: Text(
                        "Referal Count : ${value.refrealProgramList.data!.data.length} ",
                        style: TextStyle(color: Colors.orange),
                           ),
               ),
            SizedBox(height: 5,),
            Container(
         height: 50,
         color: lgreen2,
         child: Padding(
           padding: const EdgeInsets.all(3.0),
           child: Padding(
             padding: const EdgeInsets.all(3.0),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   "Name ",
                   style: TextStyle(
                       color: kprimarygreen,
                       fontWeight: FontWeight.bold,
                       fontSize: 15),
                 ),
                 Text(
                   "No.Of Plot ",
                   style: TextStyle(
                       color: kprimarygreen,
                       fontWeight: FontWeight.bold,
                       fontSize: 15),
                 ),
                 Text(
                   "Total Order ",
                   style: TextStyle(
                       color: kprimarygreen,
                       fontWeight: FontWeight.bold,
                       fontSize: 15),
                 ),
                 Text(
                   "Lab\nEnquiry(Qty) ",
                   style: TextStyle(
                       color: kprimarygreen,
                       fontWeight: FontWeight.bold,
                       fontSize: 15),
                 ),
               ],
             ),
           ),
         ),
            ),
              Container(
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage(Util.backgroundImage))),
             child: ListView.builder(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               padding:
                   const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
               itemCount: value.refrealProgramList.data!.data!.length,
               itemBuilder: (context, index) {
                 dynamic item = value.refrealProgramList.data!.data![index];
                 return Container(
         decoration: BoxDecoration(border: Border.all(color: kgrey)),
         child: Padding(
           padding: const EdgeInsets.all(4.0),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               SizedBox(
                 width: 55,
                 child: Text(
                  value.refrealProgramList.data!.data![index].fullName,
                   
                   style: TextStyle(color: kblack, fontSize: 13,fontWeight: FontWeight.bold),
                 ),
               ),
               Text(
                 value.refrealProgramList.data!.data![index].plotCount.toString(),
                 style: TextStyle(color: kblack, fontSize: 15),
               ),
               SizedBox(width: 4,),
               Text(
                  value.refrealProgramList.data!.data![index].orderCount.toString(),
                 style: TextStyle(color: kblack, fontSize: 15),
               ),
               SizedBox(width: 4,),
               Text(
                  value.refrealProgramList.data!.data![index].labCount.toString(),
                 style: TextStyle(color: kblack, fontSize: 15),
               ),
               SizedBox(width: 4,)
             ],
           ),
         ),
            );
               },
             )
             
             )
           ],
         );
          }
        })),
      ),
    );
  }
}
