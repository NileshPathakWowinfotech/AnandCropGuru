

import '../../data/Model/CropModels/video_list_model.dart';
import '../../data/Model/CropModels/video_playlist_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class VideoRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<VideoListModel> VideoListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 

    
        
       print("vedio  Api ${uri}");
     print("vedio Api ${data}");
     return response = VideoListModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 

   Future<VideoPlayListModel> VideoPlayListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 

    
     print("vedio playApi ${uri}");
     print("vedio play Api ${data}");
     return response = VideoPlayListModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 

 }