import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class NotiBoddy extends StatefulWidget {
  const NotiBoddy({super.key});

  @override
  State<NotiBoddy> createState() => _NotiBoddyState();
}

class _NotiBoddyState extends State<NotiBoddy> {
  AppController controller = Get.put(AppController());

  String? nameCollection;

  @override
  void initState() {
    super.initState();
    findMyOrder();

    switch (controller.displaySiteCode.value) {
      case 'PCH-KhonKaen':
        nameCollection = 'product1';
        break;
      case 'PCH-Sriracha':
        nameCollection = 'product2';
        break;
      case 'PCH-Bangkok':
        nameCollection = 'product3';
        break;
      case 'PCH-Hanoi':
        nameCollection = 'product4';
        break;
      default:
    }
  }

  Future<void> findMyOrder() async {
    if (controller.notiIphoneModels.isNotEmpty) {
      controller.notiIphoneModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? docIdAssociate = preferences.getString('user');

    await FirebaseFirestore.instance
        .collection('order')
        .where('docIdAssociate', isEqualTo: docIdAssociate)
        .get()
        .then((value) async {
      if (controller.orderModels.isNotEmpty) {
        controller.orderModels.clear();
      }
      for (var element in value.docs) {
        OderModel model = OderModel.fromMap(element.data());
        controller.orderModels.add(model);
        IphoneModel iphoneModel = await AppSvervice()
            .findphotodp1ModelWhareDocId(
                docIdPhoto1: model.docPhotopd1,
                collectionProduct: nameCollection!);
        controller.notiIphoneModels.add(iphoneModel);
        
      }
    });
  }

  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('##notiIphone ----->${appController.notiIphoneModels.length}');
          return (appController.orderModels.isEmpty)
              ? const SizedBox()
              : ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetText(
                          text: "Status Sales",
                          textStyle: AppConstant().h1Style(),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: appController.notiIphoneModels.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WidgetText(text: 'Sales'),
                          WidgetText(
                              text:
                                  appController.notiIphoneModels[index].model),
                          WidgetText(
                              text: appController
                                  .notiIphoneModels[index].serialID),
                        ],
                      ),
                    ),
                  ],
                );
        });
  }
}
