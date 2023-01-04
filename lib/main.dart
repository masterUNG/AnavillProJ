
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/main_home.dart';
import 'package:sharetraveyard/states/select_round.dart';
import 'package:sharetraveyard/states/select_site.dart';
import 'package:sharetraveyard/utility/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SelectRound(),
      //home: SelectSite(0),
      //home: AuthenMobile(),
      //home: MainHome(0),
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
