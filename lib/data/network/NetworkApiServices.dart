import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../app_excaption.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout( const Duration(seconds: 10));
          responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
 // POST API MODEL
  @override
  Future getPostResponse(String url,dynamic data)async {
   dynamic responseJson;
    try {
     Response response = await post(
      Uri.parse(url),
      body: data,
      headers:  <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
      
      ).timeout(Duration(seconds: 10));


      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  } 


   @override
  Future fetchPostResponse(String url,dynamic data)async {
   dynamic responseJson;
    try {
     Response response = await post(
      Uri.parse(url),
      body: data,
     headers: {'Content-Type': 'application/json'},
      
      ).timeout(Duration(seconds: 10));


      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            "Error accourded while communicating with server" +
                'with status code' +
                response.statusCode.toString());
    }
  } 


}
