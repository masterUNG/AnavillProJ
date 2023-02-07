import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/states/authen_mobile.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';

var getPage = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const AuthenMobile(),
  ),
  GetPage(
    name: '/select',
    page: () => const SelectSite(),
  ),
];
String firstState = '/authen';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    print('##8feb urer ---> $user');

    if (user != null) {
      firstState = 'select';
    }

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: getPage,
      initialRoute: firstState,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
            backgroundColor: AppConstant.bgColor,
            elevation: 0,
            foregroundColor: AppConstant.dark),
      ),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
