import 'dart:convert';

import 'package:http/http.dart' as http;

class Services2{

  static Future<Map<String, dynamic>> getBlogDetails(String blogId) async {
    try {
      var response = await http.get(Uri.parse(
          'http://mycropguruapiwow.cropguru.in/api/HomeScreenNews?BLOG_ID=$blogId&USER_ID=21013&LANG_ID=1'));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      Map<String, dynamic> blogDetails = jsonDecode(response.body)['DATA'][0];
      print(blogDetails);

      return blogDetails;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getBlogDetails2(String blogId2) async {
    try {
      var response = await http.get(Uri.parse(
          'http://mycropguruapiwow.cropguru.in/api/HomeScreenNews?BLOG_ID=$blogId2&USER_ID=21013&LANG_ID=1'));

      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }

      Map<String, dynamic> blogDetails = jsonDecode(response.body)['DATA'][0];
      print(blogDetails);

      return blogDetails;
    } catch (error) {
      rethrow;
    }
  }






}