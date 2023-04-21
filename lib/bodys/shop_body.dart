// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/states/detail_product.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  final debouncer = Debouncer(milliScecond: 500);
  AppController controller = Get.put(AppController());

  var searchIphoneModels = <IphoneModel>[];
  String nameCollection = 'product2';

  @override
  void initState() {
    super.initState();

    switch (controller.displaySiteCode.value) {
      case 'PCH-Sriracha':
       //user: sriracha password :sc123456
        nameCollection = 'product1';
        break;
      case 'PCH-PackChong':
      //user: packchong password :pc123456
        nameCollection = 'product2';
        break;
      case 'PCH-Bangkok':
       //user: bangkok password : bk123456
        nameCollection = 'product3';
        break;
      default:
    }
    print('##mar8 nameCollection---->${nameCollection}');

    AppSvervice().readPhotoPD1(nameCollection: nameCollection).then((value) {
      for (var element in controller.iphoneModels) {
        searchIphoneModels.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                "##7feb searchIphoneModels ----> ${appController.searchIphoneModels.length}");
            return appController.iphoneModels.isEmpty
                ? const SizedBox()
                : ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: WidgetForm(
                              changFunc: (p0) {
                                debouncer.run(() {
                                  if (searchIphoneModels.isNotEmpty) {
                                    searchIphoneModels.clear();
                                    for (var element
                                        in appController.iphoneModels) {
                                      searchIphoneModels.add(element);
                                    }
                                  } else {
                                    for (var element
                                        in appController.iphoneModels) {
                                      searchIphoneModels.add(element);
                                    }
                                  }

                                  searchIphoneModels = searchIphoneModels
                                      .where((element) => element.serialID
                                          .toLowerCase()
                                          .contains(p0.toLowerCase()))
                                      .toList();

                                  setState(() {});
                                });
                              },
                              sufixWidget: const Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: searchIphoneModels.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          //mainAxisExtent: 4,
                          //crossAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection(nameCollection)
                                .where('serialID',
                                    isEqualTo:
                                        searchIphoneModels[index].serialID)
                                .get()
                                .then((value) {
                              for (var element in value.docs) {
                                String docIdPhotopd1 = element.id;

                                if (!(searchIphoneModels[index].salseFinish!)) {
                                  Get.to(DetailProduct(
                                    
                                    iphoneModel: searchIphoneModels[index],
                                    docIdPhotoPd1: docIdPhotopd1, collectionProduct: nameCollection,
                                  ));
                                }
                              }
                            });
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                WidgetImageNetwork(
                                    urlImage: searchIphoneModels[index].cover),
                                WidgetText(
                                    text: searchIphoneModels[index].serialID),
                                searchIphoneModels[index].salseFinish!
                                    ? WidgetText(
                                        text: 'SaleOut !!',
                                        textStyle: AppConstant()
                                            .h3Style(color: Colors.red),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}

class Debouncer {
  final int milliScecond;
  Timer? timer;
  VoidCallback? voidCallback;
  Debouncer({
    required this.milliScecond,
    this.timer,
    this.voidCallback,
  });

  run(VoidCallback voidCallback) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(Duration(milliseconds: milliScecond), voidCallback);
  }
}
