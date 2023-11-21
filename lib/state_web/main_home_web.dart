// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/bodys/shop_body.dart';
import 'package:sharetraveyard/bodys/shop_ped_body.dart';
import 'package:sharetraveyard/state_web/authen_mobile_web.dart';
import 'package:sharetraveyard/state_web/noti_body_web.dart';
import 'package:sharetraveyard/state_web/profile_dody_web.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class MainHomeWeb extends StatefulWidget {
  @override
  State<MainHomeWeb> createState() => _MainHomeWebState();

  final bool statusRoude;

  const MainHomeWeb({
    super.key,
    required this.statusRoude,
  });
}

class _MainHomeWebState extends State<MainHomeWeb> {
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
    super.initState();

    if (controller.currentAssociateLogin.last.shopPhone!) {
      shops.add(ShopBody(
        statusRoude: widget.statusRoude,
      ));
    }

    if (controller.currentAssociateLogin.last.shopPed!) {
      shops.add(const ShopPedBody());
    } else {}

    pageController = PageController(initialPage: controller.indexShop.value);

    mainShop = PageView(
      controller: pageController,
      children: shops,
    );

    // bodys.add(mainShop!);
    // bodys.add(const NotiBoddy());
    // bodys.add(ProfileBody());

    bodys.add(mainShop!);
    bodys.add(const NotiBoddyWeb());
    bodys.add(ProfileBodyWeb());

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
          print(
              '##8nov currentAss --> ${appController.currentAssociateLogin.length}');
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
                    Get.offAll(const AuthenMobileWeb());
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
