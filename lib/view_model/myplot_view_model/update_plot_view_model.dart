
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../repository/myplot/update_repository.dart';
import '../../utils/util.dart';




class UpadtePlotViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = UpdatePlotRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  // registerapi UP API
  Future<void> updatePlotApi(
    dynamic data,
    BuildContext context,
  ) async {
    setLoading(true);
    setLoading(true);
    _myRepo.totalApi(data).then((value) {
      setLoading(false);
      //Navigator.popAndPushNamed(context, RoutesName.address);
      Util.tostMassage("Sucsess ");
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
}