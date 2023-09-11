import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class PopupMenuWidget extends StatefulWidget {
  @override
  _PopupMenuWidgetState createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  late List<String> options;

  @override
  void initState() {
    super.initState();
    fetchOptions().then((data) {
      setState(() {
        options = data;
      });
    });
  }

  Future<List<String>> fetchOptions() async {
    final response = await http.get(Uri.parse('https://api.example.com/options'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Failed to load options');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2,
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 2),
          items: options.map((String option) {
            return PopupMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        );
      },
      child: Text('Show Popup Menu'),
    );
  }
}
