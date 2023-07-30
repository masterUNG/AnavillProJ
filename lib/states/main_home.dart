import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/bodys/noti_body.dart';
import 'package:sharetraveyard/bodys/profile_dody.dart';
import 'package:sharetraveyard/bodys/shop_body.dart';
import 'package:sharetraveyard/bodys/shop_ped_body.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Widget? mainShop;

  // var shops = <Widget>[const ShopBody(), const ShopPedBody()];
  var shops = <Widget>[];
  PageController? pageController;

  AppController controller = Get.put(AppController());

  var bodys = <Widget>[];

  var titles = <String>[
    'Shop',
    'History buy',
    'My profile',
  ];

  var iconDatas = <IconData>[
    Icons.shopping_basket,
    Icons.history,
    Icons.person_pin
  ];

  var bottomNavaItims = <BottomNavigationBarItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
      if (controller.currentAssociateLogin.last.shopPhone!) {
        shops.add(const ShopBody());
      }
      if (controller.currentAssociateLogin.last.shopPed!) {
        shops.add(const ShopPedBody());
      } else {}

      pageController = PageController(initialPage: controller.indexShop.value);

      mainShop = PageView(
        controller: pageController,
        children: shops,
      );
    

    

    bodys.add(mainShop!);
    bodys.add(const NotiBoddy());
    bodys.add(ProfileBody());

    for (var i = 0; i < titles.length; i++) {
      bottomNavaItims.add(
        BottomNavigationBarItem(
          icon: Icon(iconDatas[i]),
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
          print('## indexBody --> ${appController.indexBody}');
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: WidgetText(
                text: titles[appController.indexBody.value],
                textStyle: AppConstant().h2Style(),
              ),
              actions: [
                appController.indexBody.value != 0
                    ? const SizedBox()
                    : appController.currentAssociateLogin.isEmpty
                        ? const SizedBox()
                        : WidgetIconButtom(
                            iconData: Icons.restart_alt,
                            pressFunc: () {
                              //swit to shop ped
                              appController.indexShop.value =
                                  ((appController.indexShop.value + 1) % 2);
                              pageController!
                                  .jumpToPage(appController.indexShop.value);
                            },
                          ),
                WidgetIconButtom(
                  iconData: Icons.exit_to_app,
                  pressFunc: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear().then((value) {
                      Get.offAllNamed('/authen');
                    });
                  },
                )
              ],
            ),
            body: bodys[appController.indexBody.value],
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavaItims,
              currentIndex: appController.indexBody.value,
              onTap: (value) {
                appController.indexBody.value = value;
              },
            ),
          );
        });
  }
}
