import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/models/order_model.dart';
import 'package:sharetraveyard/states/desplay_order_detail.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
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
      case 'PCH-BK':
        nameCollection = 'producttest';
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
        .orderBy('timestamp')
        // .where('docIdAssociate', isEqualTo: docIdAssociate)
        .get()
        .then((value) async {
      if (controller.orderModels.isNotEmpty) {
        controller.orderModels.clear();
        controller.nameModel.clear();
        controller.nameSerialID.clear();
        controller.docIOrder.clear();
      }
      for (var element in value.docs) {
        OderModel model = OderModel.fromMap(element.data());
        if (model.docIdAssociate == docIdAssociate) {
          controller.orderModels.add(model);

          if (model.docPhotopd1.isNotEmpty) {
            //for mobile
            IphoneModel iphoneModel = await AppSvervice()
                .findphotodp1ModelWhareDocId(
                    docIdPhoto1: model.docPhotopd1,
                    collectionProduct: nameCollection!);

            print('##2nov iphoneModel ----> ${iphoneModel.toMap()}');

            controller.nameModel.add('${iphoneModel.model}[mobile]');
            controller.nameSerialID.add(iphoneModel.serialID);
            controller.docIOrder.add(element.id);
          } else {
            //for ped
            controller.nameModel.add('${model.mapPed!['model']}[Ped]');
            controller.nameSerialID.add(model.mapPed!['pedID']);
            controller.docIOrder.add(element.id);
          }
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('##2nov orderModel ----->${appController.orderModels.length}');

          return ((appController.nameModel.isEmpty) ||
                  (appController.nameSerialID.isEmpty))
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
                      reverse: true,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: appController.nameModel.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.to(DisplayOrderDetail(
                            nameProdcut: appController.nameModel[index],
                            orderModel: appController.orderModels[index],
                          ));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: const WidgetText(text: 'Sales')),
                                Expanded(
                                    flex: 3,
                                    child: WidgetText(
                                        text: appController.nameModel[index])),
                                Expanded(
                                    child: WidgetText(
                                        text:
                                            appController.nameSerialID[index])),
                                Expanded(
                                  child: WidgetIconButtom(
                                    iconData: Icons.delete_forever,
                                    pressFunc: () async {
                                      print(
                                          'delete at ${controller.docIOrder[index]}');

                                      FirebaseFirestore.instance
                                          .collection('order')
                                          .doc(controller.docIOrder[index])
                                          .delete()
                                          .then((value) {
                                        findMyOrder();
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
