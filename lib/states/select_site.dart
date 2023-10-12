// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/models/period1_model.dart';
import 'package:sharetraveyard/models/site_code_model.dart';
import 'package:sharetraveyard/states/main_home.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_progress.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class SelectSite extends StatefulWidget {
  const SelectSite({
    Key? key,
    this.assoiate,
  }) : super(key: key);

  final String? assoiate;

  @override
  State<SelectSite> createState() => _SelectSiteState();
}

class _SelectSiteState extends State<SelectSite> {
  AppController controller = Get.put(AppController());
  String? user;
  String? docIdSiteCode;

  @override
  void initState() {
    super.initState();

    AppSvervice().findCurrenAssociateLogin();

    controller.readSiteCode();
    findUserLogin().then((value) {
      controller.readPeriod(docIdSiteCode: docIdSiteCode!).then((value) {
        print(
            '##10sep periodModel ----->${controller.periodModels.last.toMap()}');
      });
    });
  }

  Future<void> findUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString('user');
    print('findUserLogin --> $user');

    await FirebaseFirestore.instance
        .collection('associate')
        .doc(user)
        .get()
        .then((value) async {
      AsscociateModel asscociateModel = AsscociateModel.fromMap(value.data()!);
      docIdSiteCode = asscociateModel.docIdSiteCode;
      print('docIdSiteCode ---> $docIdSiteCode');
      await FirebaseFirestore.instance
          .collection('sitecode')
          .doc(docIdSiteCode)
          .get()
          .then((value) {
        SiteCodeModel siteCodeModel = SiteCodeModel.fromMap(value.data()!);
        print('siteCodeModel ---->${siteCodeModel.toMap()}');
        controller.displaySiteCode.value = siteCodeModel.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgColor,
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('## pperiod --> ${appController.periodModels.length}');
            print('## Sitecode --> ${appController.siteCodeModel.length}');

            return SafeArea(
              child: appController.periodModels.isEmpty
                  ? const SizedBox()
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sitecode(),
                            appController.displaySiteCode.isEmpty
                                ? const SizedBox()
                                : WidgetText(
                                    text: appController.displaySiteCode.value,
                                    textStyle: AppConstant().h2Style(),
                                  ),
                            ListView.builder(
                              itemCount: appController.allPeriodModels.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  appController.allPeriodModels[index].status!
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            clickbuttomGoToShop(
                                                period1model: appController
                                                    .allPeriodModels[index],
                                                appController: appController),
                                            statusWidget(
                                                period1model: appController
                                                    .allPeriodModels[index]),
                                            periodWidget(
                                                period1model: appController
                                                    .allPeriodModels[index]),
                                            salseDatWidget(
                                                period1model: appController
                                                    .allPeriodModels[index]),
                                          ],
                                        )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          }),
    );
  }

  Widget salseDatWidget({required Period1Model period1model}) {
    return WidgetText(text: 'Salse Day : ${period1model.saleday}');
  }

  Widget periodWidget({required Period1Model period1model}) {
    return WidgetText(text: 'Period : ${period1model.periodsale}');
  }

  Widget statusWidget({required Period1Model period1model}) {
    return period1model.repair!
        ? const WidgetText(text: 'Repair')
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                text: 'Status : ',
                textStyle: AppConstant().h2Style(),
              ),
              period1model.status!
                  ? WidgetText(
                      text: 'Open',
                      textStyle: AppConstant().h2Style(color: Colors.green),
                    )
                  : WidgetText(
                      text: 'Off',
                      textStyle: AppConstant().h2Style(color: Colors.red),
                    ),
            ],
          );
  }

  WidgetButtom clickbuttomGoToShop({
    required Period1Model period1model,
    required AppController appController,
  }) {
    return WidgetButtom(
      label: 'Go to ${period1model.salesperiod}',
      pressFunc: () {
        if (period1model.status!) {
          //Open

          appController.periodModels.add(period1model);

          if (!period1model.repair!) {

            if (period1model.salesperiod == 'IphoneProduct') {
              appController.indexShop.value = 0;
            } else {
              appController.indexShop.value = 1;
            }

            Get.to(MainHome());
            
          } else {
            Get.snackbar('Reapair', 'Please Try Again after Repair Finish');
          }
        } else {
          //Off
          Get.snackbar('Status Off', 'Status Open can go to Shop');
        }
      },
    );
  }

  Container dropdownperiod(AppController appController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(left: 50, right: 50, top: 16, bottom: 30),
      width: double.infinity,
      height: 50,
      color: AppConstant.fieldColor,
      child: appController.periodModels.isEmpty
          ? const WidgetProgress()
          : Center(
              child: DropdownButton(
                isExpanded: true,
                value: appController.choosePeriod.isEmpty
                    ? null
                    : appController.choosePeriod.last,
                items: appController.periodModels
                    .map(
                      (element) => DropdownMenuItem(
                        child: WidgetText(text: element.saleday),
                        value: element.saleday,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  appController.choosePeriod.add(value!);
                  Get.to(MainHome());
                },
              ),
            ),
    );
  }

  Container period1() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 20),
      child: WidgetText(
        text: '!!! Click !!!',
        textStyle:
            AppConstant().appStyle(size: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  WidgetText sitecode() {
    return WidgetText(
      text: '- Welcome -',
      textStyle: AppConstant().appStyle(
        size: 48,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container dropdown(AppController appController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 20),
      width: double.infinity,
      height: 50,
      color: AppConstant.fieldColor,
      child: appController.siteCodeModel.isEmpty
          ? const WidgetProgress()
          : DropdownButton(
              isExpanded: true,
              hint: WidgetText(text: 'Please Choose Site Code'),
              value: appController.chooseSiteCode.isEmpty
                  ? null
                  : appController.chooseSiteCode.last,
              items: appController.siteCodeModel
                  .map(
                    (element) => DropdownMenuItem(
                      child: WidgetText(text: element.name),
                      value: element.name,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                appController.chooseSiteCode.add(value!);
              },
            ),
    );
  }
}
