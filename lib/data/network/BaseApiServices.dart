

abstract class BaseApiServices{

  Future<dynamic> getResponse(String url,); 

  Future<dynamic> getPostResponse(String url,dynamic data);  
 
  Future<dynamic> fetchPostResponse(String url,dynamic data); 

  

}