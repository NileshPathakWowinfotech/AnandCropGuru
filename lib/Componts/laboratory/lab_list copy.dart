import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:provider/provider.dart';

import '../../data/Model/soli_testing_type_model.dart';
import '../../data/response/status.dart';
import '../../view_model/home_view_model.dart';

class lab_List extends StatefulWidget {
  const lab_List({super.key, required this.category});
   final SoilTestingTypeListModelDATA category;

  @override
  State<lab_List> createState() => _lab_ListState();
}

class _lab_ListState extends State<lab_List> {
  HomeViewViewModel listLabView = HomeViewViewModel();
  @override
  void initState() {
    listLabView.labListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<HomeViewViewModel>(
               create: (BuildContext context) => listLabView,
               child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
                 switch (value.lablist.status!) {
                   case Status.LOADING:
                     return const Center(child: CircularProgressIndicator());
                   case Status.ERROR:
                     return Center(child: Text(value.lablist.message.toString()));
                   case Status.COMPLETED:
                     return ListView.builder(
                       itemCount: value.lablist.data!.data.length,
                       shrinkWrap: true,
                       itemBuilder: (context, index) {
                         dynamic item = value.lablist.data!.data[index];
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Material(
                             elevation: 5,
                             borderRadius: BorderRadius.circular(8),
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                       children: [
                                         Row(
                                           children: [
                                             Text(
                                               'Enquiry ID :  ',
                                               style: TextStyle(
                                                 color: kgreyy,
                                               ),
                                             ),
                                             Text(
                                               value
                                                   .lablist.data!.data[index].enquiryId
                                                   .toString(),
                                               style: TextStyle(
                                                 color: kblack,
                                               ),
                                             ),
                                           ],
                                         ),
                                         Container(
                                             alignment: Alignment.center,
                                             height: 32,
                                             width: 70,
                                             decoration: BoxDecoration(
                                               color: Colors.yellow,
                                               borderRadius: BorderRadius.circular(16),
                                             ),
                                             child: Text(
                                               'Active',
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   color: kWhite,
                                                   fontSize: 15),
                                             )),
                                       ],
                                     ),
                                     Row(
                                       children: [
                                         Text(
                                           'Amount :',
                                           style: TextStyle(
                                             color: kgreyy,
                                           ),
                                         ),
                                         SizedBox(
                                           width: 2,
                                         ),
                                         Text(
                                           '₹ ${value.lablist.data!.data[index].amount.toString()}',
                                           style: TextStyle(
                                             color: kgreen,
                                           ),
                                         ),
                                       ],
                                     ),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Row(
                                       children: [
                                         Text(
                                           'Category :',
                                           style: TextStyle(
                                             color: kgreyy,
                                           ),
                                         ),
                                         SizedBox(
                                           width: 2,
                                         ),
                                         Text(
                                           value.lablist.data!.data[index]
                                               .testingCategory
                                               .toString(),
                                           style: TextStyle(
                                             color: kgreen,
                                           ),
                                         ),
                                       ],
                                     ),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Row(
                                       children: [
                                         Text(
                                           'Remark :',
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: kblack),
                                         ),
                                         SizedBox(
                                           width: 2,
                                         ),
                                         Text(
                                           value.lablist.data!.data[index].remark
                                               .toString(),
                                           style: TextStyle(
                                             color: kgreen,
                                           ),
                                         ),
                                       ],
                                     ),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Text(
                                       'Admin Remark :  ${value.lablist.data!.data[index].adminRemark.toString()}',
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold, color: kblack),
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: [
                                         Text(
                                           value.lablist.data!.data[index].regDate
                                               .toString(),
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: kblack),
                                         ),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );
                       },
                     );
                 }
                 return Container();
               }),
             )
        
     
    );
  }
}
