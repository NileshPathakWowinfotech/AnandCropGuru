import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/CropModels/product_comment_model.dart';
import '../../data/Model/MartModels/productblog_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/product_blog_repository.dart';
import '../../repository/Mart/product_comment_repository.dart';
import '../../utils/util.dart';

class CommentProductViewViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ProductCommentRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ProductCommentModel> productLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<ProductCommentModel> response) {
    productLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> commentProduct(productId) async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "START": '0',
        "END": '10000',
        "WORD": "NONE",
        "GET_DATA": "Get_ProductFeedbackByProductId",
        "ID1": "",
        "ID2": productId.toString(),
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": ""
      });
      setlabTestingType(ApiResponse.loading());
      _myRepo.commentproductDetailsPostApi(registerdata).then((value) {
        setlabTestingType(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setlabTestingType(ApiResponse.error(error.toString()));
      });
    });
  } 

  Future<void> feedBack(
    BuildContext context,rattingmassage,reating,productId
  ) async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "UF_ID": "",
        "ORDER_ID": "",
        "PRODUCT_ID": productId,
        "USER_ID":value.userId,
        "RATING":reating,
        "RATING_MESSAGE":rattingmassage,
        "RATING_EMAIL": "",
        "TASK": "ADD",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": ""
      });
      print('register api data is $registerdata');
      setLoading(true);
      _myRepo.feedBack(registerdata).then((value) {
        print(value);
        setLoading(true);
        (false);
        Navigator.pop(context);
        Util.tostMassage("Success");
        setLoading(false);
        if (kDebugMode) {}
      }).onError((error, stackTrace) {
        setLoading(true);
        (false);
        if (kDebugMode) {
          Util.flushBarErrorMessage(error.toString(), context);
          print(error.toString());
        }
      });
    });
  }
  
}
