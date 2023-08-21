

 import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class AskQuestionRepository{ 
 BaseApiServices  _apiServices = NetworkApiService();  

   //POST API
   Future<dynamic> qutionAnswerPostApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.QutionsAnsPostApi, data);
     return response;
    }catch(e){
      throw e;
    }

  } 
 

  //GET API
  Future<QuestionAnswerModel> questionAnswerListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 
     return response = QuestionAnswerModel.fromJson(response);
    }catch(e){
      throw e;
    }

 

}
}