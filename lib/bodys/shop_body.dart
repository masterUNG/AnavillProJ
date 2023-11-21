// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/iphone_model.dart';
import 'package:sharetraveyard/state_web/payment_upload_web.dart';
import 'package:sharetraveyard/states/detail_product.dart';
import 'package:sharetraveyard/states/payment_upload.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/wigget_image_network.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ShopBody extends StatefulWidget {
  const ShopBody({
    Key? key,
    required this.statusRoude,
  }) : super(key: key);

  @override
  State<ShopBody> createState() => _ShopBodyState();

  final bool statusRoude;
}

class _ShopBodyState extends State<ShopBody> {
  final debouncer = Debouncer(milliScecond: 500);
  AppController controller = Get.put(AppController());

  var searchIphoneModels = <IphoneModel>[];
  String nameCollection = 'product4';

  String? associateLogin;

  @override
  void initState() {
    super.initState();

    refreshData();

    findAssociateLogin();
  }

  Future<void> findAssociateLogin() async {
    if (kIsWeb) {
      //web
      associateLogin = controller.currentAssociateLogin.last.associateID;
      print('##21nov associateLogin at web status ---> $associateLogin');
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      associateLogin = preferences.getString('user');
    }
  }

  void refreshData() {
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
      case 'PCH-Hanoi':
        nameCollection = 'product4';
        break;
      case 'PCH-BK':
        nameCollection = 'producttest';
        break;
      default:
    }
    print('##2nov nameCollection---->${nameCollection}');

    if (searchIphoneModels.isNotEmpty) {
      searchIphoneModels.clear();
    }

    AppSvervice().readPhotoPD1(nameCollection: nameCollection).then((value) {
      int i = 0;

      for (var element in controller.iphoneModels) {
        bool reserve = element.reserve;

        //เช็คเวลา timeBuy ว่ามีใคร หมดเวลาบ้าง
        if ((element.timeBuy != Timestamp(0, 0)) && !reserve) {
          print('##2nov model ที่สั่งซื้อ ----> ${element.toMap()}');

          var diffTime = DateTime.now().difference(element.timeBuy.toDate());

          print('##2nov diffTime in minus ---> ${diffTime.inMinutes}');

          print('##2nov docId ---> ${controller.docIdPhotopd1s[i]}');

          if (diffTime.inMinutes >= 2) {
            //เกินชัวโมงแล้ว
            Map<String, dynamic> map = element.toMap();
            map['buy'] = false;
            map['timeBuy'] = Timestamp(0, 0);

            FirebaseFirestore.instance
                .collection(nameCollection)
                .doc(controller.docIdPhotopd1s[i])
                .update(map)
                .then((value) {
              print('##2nov success update');
            });
          }
        }

        if (widget.statusRoude) {
          //สำหรับเจ้าของ

          print(
              '##2nov login ---> ${controller.currentAssociateLogin.last.associateID}');
          print('##2nov shop ----> ${element.owner}');

          if (controller.currentAssociateLogin.last.associateID ==
              element.owner) {
            searchIphoneModels.add(element);
          }
        } else {
          searchIphoneModels.add(element);
        }
        i++;
      } //for
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
                      searchForm(appController),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: searchIphoneModels.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 5,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            if (!(searchIphoneModels[index].reserve ?? false)) {
                              if ((!appController
                                      .periodModels.last.statusRound!) ||
                                  (associateLogin ==
                                      searchIphoneModels[index].owner)) {
                                await FirebaseFirestore.instance
                                    .collection(nameCollection)
                                    .where('serialID',
                                        isEqualTo:
                                            searchIphoneModels[index].serialID)
                                    .get()
                                    .then((value) {
                                  for (var element in value.docs) {
                                    String docIdPhotopd1 = element.id;

                                    if (!(searchIphoneModels[index]
                                        .salseFinish!)) {
                                      if (!(searchIphoneModels[index].buy!)) {
                                        Get.to(DetailProduct(
                                          iphoneModel:
                                              searchIphoneModels[index],
                                          docIdPhotoPd1: docIdPhotopd1,
                                          collectionProduct: nameCollection,
                                        ))!
                                            .then((value) {
                                          searchIphoneModels.clear();
                                          refreshData();
                                        });
                                      } else if (appController
                                              .currentAssociateLogin
                                              .last
                                              .associateID ==
                                          searchIphoneModels[index]
                                              .associateBuy) {
                                        //เจ้าของ buy

                                        AppDialog(context: context)
                                            .normalDialog(
                                          title: 'Please Choose',
                                          subTitle: 'Upload Slip or ยกเลิก Buy',
                                          actionWidget: WidgetButtom(
                                            label: 'Upload Slip',
                                            pressFunc: () {
                                              Get.back();

                                              if (kIsWeb) {
                                                Get.to( PaymentUploadWeb(
                                                    iphoneModel:searchIphoneModels[
                                                            index],
                                                    docIdPhotoPd1:
                                                        docIdPhotopd1,
                                                    collectionProduct:
                                                        nameCollection,
                                                  ),
                                                );
                                              } else {
                                                Get.to(PaymentUpload(
                                                    iphoneModel:
                                                        searchIphoneModels[
                                                            index],
                                                    docIdPhotoPd1:
                                                        docIdPhotopd1,
                                                    collectionProduct:
                                                        nameCollection,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          action2Widget: WidgetButtom(
                                            label: 'ยกเลิก Buy',
                                            pressFunc: () async {
                                              Map<String, dynamic> map =
                                                  searchIphoneModels[index]
                                                      .toMap();

                                              print('map ก่อน ---> $map');

                                              map['buy'] = false;
                                              map['associateBun'] = '';

                                              print('map หลัง ---> $map');

                                              await AppSvervice()
                                                  .processEditProduct(
                                                      collection:
                                                          nameCollection,
                                                      docId: docIdPhotopd1,
                                                      map: map)
                                                  .then((value) {
                                                Get.back();
                                                refreshData();
                                              });
                                            },
                                          ),
                                        );
                                      } else {
                                        //Guest
                                      }
                                    }
                                  }
                                });
                              }
                            }
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                WidgetText(
                                    text:
                                        'reserve -> ${searchIphoneModels[index].reserve}'),
                                WidgetText(
                                    text:
                                        'buy -> ${searchIphoneModels[index].buy}'),
                                WidgetImageNetwork(
                                    urlImage: searchIphoneModels[index].cover),
                                WidgetText(
                                    text: searchIphoneModels[index].serialID),
                                searchIphoneModels[index].timestamp ==
                                        Timestamp(0, 0)
                                    ? const SizedBox()
                                    : searchIphoneModels[index]
                                                .timestamp!
                                                .toDate()
                                                .difference(DateTime.now())
                                                .inMinutes <
                                            //inMinutes ปรับเวลาตรงนี้ และ ตรง file detail states  line 144
                                            -1
                                        ? const SizedBox()
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow),
                                            child: const WidgetText(
                                                text: 'Reserve'),
                                          ),
                                searchIphoneModels[index].salseFinish!
                                    ? WidgetText(
                                        text: searchIphoneModels[index].finish!
                                            ? 'Finish'
                                            : 'PedinPick !!',
                                        textStyle: AppConstant().h3Style(
                                            color: (appController
                                                        .currentAssociateLogin
                                                        .last
                                                        .associateID ==
                                                    searchIphoneModels[index]
                                                        .associateBuy)
                                                ? Colors.green
                                                : Colors.red),
                                      )
                                    : const SizedBox(),
                                searchIphoneModels[index].salseFinish!
                                    ? const SizedBox()
                                    : searchIphoneModels[index].buy!
                                        ? const WidgetText(text: 'PedingPay')
                                        : const SizedBox(),
                                appController.periodModels.last.statusRound!
                                    ? associateLogin ==
                                            searchIphoneModels[index].owner
                                        ? WidgetText(
                                            text:
                                                'forUser -> ${searchIphoneModels[index].owner}')
                                        : const SizedBox()
                                    : const SizedBox(),
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

  Row searchForm(AppController appController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          child: WidgetForm(
            changFunc: (p0) {
              debouncer.run(() {
                if (searchIphoneModels.isNotEmpty) {
                  searchIphoneModels.clear();
                  for (var element in appController.iphoneModels) {
                    searchIphoneModels.add(element);
                  }
                } else {
                  for (var element in appController.iphoneModels) {
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
