import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/bodys/associate_body.dart';
import 'package:sharetraveyard/bodys/order_body.dart';
import 'package:sharetraveyard/bodys/product_body.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class MainHomeWeb extends StatefulWidget {
  const MainHomeWeb({super.key});

  @override
  State<MainHomeWeb> createState() => _MainHomeWebState();
}

class _MainHomeWebState extends State<MainHomeWeb> {
  var titles = <String>[
    'AssociateID',
    'Product',
    'Order',
  ];
  var iconDatas = <IconData>[
    Icons.person,
    Icons.phone_android,
    Icons.point_of_sale_sharp,
  ];

  var bodys = <Widget>[
    const AssociateBody(),
    const ProductBody(),
    const OrderBody(),
  ];

  var bottomNavItem = <BottomNavigationBarItem>[];
  @override
  void initState() {
    // TODO: implement initState

    for (var i = 0; i < titles.length; i++) {
      bottomNavItem.add(
        BottomNavigationBarItem(
          icon: Icon(
            iconDatas[i],
          ),
          label: titles[i],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('indexbody ---> ${appController.indexBody}');
          return Scaffold(
            backgroundColor: AppConstant.bgColor,
            appBar: AppBar(
              title: WidgetText(
                text: titles[appController.indexBody.value],
                textStyle: AppConstant().h2Style(),
              ),
            ),
            body: bodys[appController.indexBody.value],
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItem,
              currentIndex: appController.indexBody.value,
              onTap: (value) {
                appController.indexBody.value = value;
              },
            ),
          );
        });
  }
}
