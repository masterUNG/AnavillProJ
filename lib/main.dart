import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/state_web/authen_mobile_web.dart';
import 'package:sharetraveyard/state_web/select_site_web.dart';
import 'package:sharetraveyard/states/authen_mobile.dart';
import 'package:sharetraveyard/states/authen_web.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sharetraveyard/utility/app_controller.dart';

var getPage = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const AuthenMobile(),
  ),
  GetPage(
    name: '/select',
    page: () => const SelectSite(),
  ),
  GetPage(
    name: '/web',
    // page: () => const Authenweb(),
    page: () => const AuthenMobileWeb(),
  ),
];
String firstState = '/authen';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    //web status
    await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: 'AIzaSyAA4R_ZAM6GG5znhfkVQOS2t9r5BeftQ5w',
                appId: '1:1091008560141:web:a39077037f94249a07e944',
                messagingSenderId: '1091008560141',
                storageBucket: 'ditproject-52990.appspot.com',
                projectId: 'ditproject-52990'))
        .then((value) async {
      await GetStorage.init().then((value) {
        firstState = '/web';
        runApp(const MyApp());
      });
    });
  } else {
    //modile status
    await Firebase.initializeApp().then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var user = preferences.getString('user');
      print('##22oct urer ---> $user');

      // preferences.clear();

      if (user != null) {
        firstState = '/select';
      }

      runApp(MyApp());
    });
  }
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
