import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SelectedDateProvider extends ChangeNotifier {
 late DateTime _selectedDate;

  SelectedDateProvider() {
    _selectedDate = DateTime.now();
  }

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = context.watch<SelectedDateProvider>().selectedDate;
  String dattime;
    return 
     Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Date:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                dattime = "${selectedDate.day}";
                if (newDate != null) {
                  context.read<SelectedDateProvider>().updateSelectedDate(newDate);
                }
              },
              child: Text('Select Date'),
            ),
          ],
        ),
      );
    
  }
}
