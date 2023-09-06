import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/MartModels/relatedProduct_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/releted_product_repository.dart';

class RelatedProductViewViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = RelatedRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<RelatedProductModel> productLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<RelatedProductModel> response) {
    productLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> productblogaPI() async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        {
          "START": 21,
          "END": 30,
          "WORD": "NONE",
          "USER_ID": "21013",
          "LANG_ID": "3",
          "CAT_ID": "1",
          "TYPE": "Product",
          "SUBCAT_ID": "0",
          "LATITUDE": "",
          "ACCESS_TOKEN": "123456",
          "DISTRICT_ID": "482",
          "TALUKA_ID": "3887",
          "SCHEDULE_ID": "0",
          "LONGITUDE": "",
          "CROP_ID": "0",
          "PLOT_ID": "0"
        }
      });
      setlabTestingType(ApiResponse.loading());
      _myRepo.shopForYourCropPostApi(registerdata).then((value) {
        setlabTestingType(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setlabTestingType(ApiResponse.error(error.toString()));
      });
    });
  }
}
