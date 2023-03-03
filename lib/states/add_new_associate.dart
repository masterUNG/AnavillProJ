import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_progress.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AddNewAssociate extends StatefulWidget {
  const AddNewAssociate({super.key});

  @override
  State<AddNewAssociate> createState() => _AddNewAssociateState();
}

class _AddNewAssociateState extends State<AddNewAssociate> {
  AppController controller = Get.put(AppController());

  String? associateId, name, lastname;

  @override
  void initState() {
    super.initState();
    controller.readSiteCode();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('siteCodeModel --->${appController.siteCodeModel.length}');
          return Scaffold(
            backgroundColor: AppConstant.bgColor,
            appBar: AppBar(
              title: WidgetText(
                text: 'Add New Associate ID',
                textStyle: AppConstant().h2Style(),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetText(
                        text: 'Associate ID :',
                        textStyle: AppConstant().h2Style(),
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: WidgetForm(
                          changFunc: (p0) {
                            associateId = p0.trim();
                          },
                          margin: EdgeInsets.only(left: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetText(
                        text: 'Name :',
                        textStyle: AppConstant().h2Style(),
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: WidgetForm(
                          changFunc: (p0) {
                            name = p0.trim();
                          },
                          margin: EdgeInsets.only(left: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetText(
                        text: 'Lastname :',
                        textStyle: AppConstant().h2Style(),
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: WidgetForm(
                          changFunc: (p0) {
                            lastname = p0.trim();
                          },
                          margin: EdgeInsets.only(left: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                appController.siteCodeModel.isEmpty
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: dropdownSitecode(appController),
                          ),
                        ],
                      ),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetButtom(
                        label: 'Add New Associate ID',
                        pressFunc: () {
                          if ((associateId?.isEmpty ?? true) ||
                              (name?.isEmpty ?? true) ||
                              (lastname?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialog(
                                title: 'Have Space',
                                subTitle: 'Please Fill Every Blank');
                          } else if (appController
                              .chooseDocIdSiteCodes.isEmpty) {
                            AppDialog(context: context).normalDialog(
                                title: 'No site Code ',
                                subTitle: 'Please choose site code');
                          } else {
                            AppSvervice()
                                .readAllAssociate()
                                .then((value) async {
                              var associateIds = <String>[];
                              for (var element
                                  in appController.assosicateModels) {
                                associateIds.add(element.associateID);
                              }

                              print('associateIds ----> $associateIds');

                              if (associateIds.contains(associateId)) {
                                AppDialog(context: context).normalDialog(
                                    title: 'AssocateID',
                                    subTitle: 'Please Change associate ID');
                              } else {
                                AsscociateModel model = AsscociateModel(
                                    name: name!,
                                    lastname: lastname!,
                                    docIdSiteCode:
                                        appController.chooseDocIdSiteCodes.last,
                                    associateID: associateId!);

                                await FirebaseFirestore.instance
                                    .collection('associate')
                                    .doc(associateId)
                                    .set(model.toMap())
                                    .then((value) => Get.back());
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Container dropdownSitecode(AppController appController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: double.infinity,
      height: 50,
      decoration: AppConstant().curveBox(),
      child: appController.siteCodeModel.isEmpty
          ? const WidgetProgress()
          : Center(
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                hint: const WidgetText(text: 'Palease Choose Site Code'),
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
                onChanged: (value) async {
                  appController.chooseSiteCode.add(value!);
                  await AppSvervice()
                      .findDocIdSiteCode(content: value)
                      .then((value) {
                    String? docIdSiteCode = value;

                    print('docIdSiteCode --- > $docIdSiteCode');

                    if (docIdSiteCode != null) {
                      appController.chooseDocIdSiteCodes.add(docIdSiteCode);
                    }
                  });
                },
              ),
            ),
    );
  }
}
