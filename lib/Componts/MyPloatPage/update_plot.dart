import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Demo/cutomDropDown.dart';
import '../../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';
import '../../view_model/myplot_view_model/update_plot_view_model.dart';

class UpdatePloat extends StatefulWidget {
  const UpdatePloat({super.key, required this.item});
  final PlotModel item;

  @override
  State<UpdatePloat> createState() => _UpdatePloatState();
}

class _UpdatePloatState extends State<UpdatePloat> {
  var dateController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  DateTime? dateTiming;
  String? selectDate;
  String? salectedDatebackundDevloper;
  final timedate_Controller = TextEditingController();
  final totalarea_Controller = TextEditingController();

  void datetiming() async {
    dateTiming = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        // firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        firstDate: DateTime(2002));
    if (dateTiming == null) {
      return;
    } else {
      setState(() {
        _dateTime = dateTiming!;
        salectedDatebackundDevloper =
            "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
        timedate_Controller.text = salectedDatebackundDevloper.toString();
        print("Date $salectedDatebackundDevloper");
      });
    }
  }

  List<String> items = <String>[
    'Select Report Type',
    'Leaf',
    'Soil',
    'Water',
    'Other'
  ];

  String dropdownvalue = 'Select Report Type';
  @override
  Widget build(BuildContext context) {
    final updatePlotViewMode = Provider.of<UpadtePlotViewModel>(context);
    DateTime selectedDate = context.watch<SelectedDateProvider>().selectedDate;
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
            'Update Plot',
            style: TextStyle(
                color: kgrey, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Ploat No",
                style: TextStyle(
                    color: kblack, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "plantation / sowing / pruning type :",
                style: TextStyle(
                    color: kgreen, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    iconSize: 34,
                    value: dropdownvalue,
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue ?? '';
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                " Select plantation / sowing / pruning date :",
                style: TextStyle(
                    color: kgreen, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            InkWell(
              onTap: () async {
                //   datetiming();
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                selectDate =
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                if (newDate != null) {
                  context
                      .read<SelectedDateProvider>()
                      .updateSelectedDate(newDate);
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: kgreyy),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_month,
                      color: kgreen,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                " Total Area :",
                style: TextStyle(
                    color: kgreen, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: totalarea_Controller,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: kgreyy, fontSize: 13),

                  // errorText: _mobileValidated ? null : _mobileError,

                  hintText: '',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Util.colorPrimary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                final data = jsonEncode({
                  "USER_ID": widget.item.userId,
                  "PLOT_ID": widget.item.plotId,
                  "AGRONOMIST_ID": widget.item.userId,
                  "PRUNING_DATE": selectDate,
                  "CHATANI_TYPE": dropdownvalue,
                  "TOTAL_AREA": timedate_Controller.text,
                  "EXTRA": "",
                  "CAT_ID": "",
                  "EXTRA1": "2",
                });
               

                updatePlotViewMode.updatePlotApi(
                  data,
                  context,
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: kWhite, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
