import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/ask_question_repository.dart';
import '../../utils/app_urls.dart';
import '../../utils/url.dart';
import '../../utils/util.dart';
import 'package:http/http.dart' as http;

class QutionAnswerViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = AskQuestionRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<QuestionAnswerModel> questionList = ApiResponse.loading();

  setlabTestingType(ApiResponse<QuestionAnswerModel> response) {
    questionList = response;

    print('  Report data $response');
    notifyListeners();
  }

  // registerapi UP API
  Future<void> qutionAnswerApi(
    dynamic data,
    BuildContext context,
  ) async {
    setLoading(true);
    setLoading(true);
    _myRepo.qutionAnswerPostApi(data).then((value) {
      setLoading(false);

      //  Navigator.popAndPushNamed(context, RoutesName.address);

      Util.tostMassage("Your Question Posted ");
      Navigator.pop(context);
      setLoading(false);
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> questionAnswerListView(userID, ploatID) async {
    Map<String, String> queryParams = {
      "USER_ID": userID.toString(),
      "TYPE": "user",
      "AGRONOMIST_ID":userID.toString(),
      "PLOT_ID": ploatID.toString(),
    };
    Uri uri = Uri.parse(AppUrls.QutionsAnsPostApi).replace(queryParameters: queryParams);
    print(uri);
    final registerdata =
        jsonEncode({"START": "0", "END": "10", "WORD": "NONE", "LANG_ID": "1"});
    setlabTestingType(ApiResponse.loading());
    _myRepo.questionAnswerListApi(uri.toString(), registerdata).then((value) {
      setlabTestingType(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setlabTestingType(ApiResponse.error(error.toString()));
    });
  }
}
