import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/utils/Colors.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:flutter_application_1/view_model/home_view_model.dart';
import 'package:flutter_application_1/view_model/myplot_view_model/crop_list_view_model.dart';
import 'package:flutter_application_1/view_model/myplot_view_model/diary_view_model.dart';
import 'package:flutter_application_1/view_model/myplot_view_model/question_answer.dart';
import 'package:flutter_application_1/view_model/myplot_view_model/reportmaster_view_model.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Componts/LocalString.dart';
import 'Demo/cutomDropDown.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewViewModel()),
        ChangeNotifierProvider(create: (_) => QutionAnswerViewModel()),
        ChangeNotifierProvider(create: (_) => ReportMasterViewModel()),
        ChangeNotifierProvider(create: (_) => DiaryDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => SelectedDateProvider()),
        ChangeNotifierProvider(create: (_) => CropAddListViewModel()),
        
        
      ],
      child: GetMaterialApp(
        translations: Messages(),
        locale: Locale('en,US'),
        debugShowCheckedModeBanner: false,
        title: 'Dr Crop Guru',
        theme: ThemeData(
         // useMaterial3: true,
          primarySwatch: Util.colorCustomPrimary,
          appBarTheme: AppBarTheme(
            color: Util.newHomeColor,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kprimarygreen,
            ),
          ),
        ),
        home: const SplashScreen(),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
