import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_form.dart';
import 'package:sharetraveyard/widgets/widget_icon_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

// ignore: use_key_in_widget_constructors
class ProfileBody extends StatefulWidget {
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String? docIdAssociate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppSvervice().findProfileUserLogin();
    findUser();
  }

  Future<void> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    docIdAssociate = preferences.getString('user');
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(
              'profileModel ----- > ${appController.profileAssocicateModels.length}');
          return ListView(
            children: [
              appController.profileAssocicateModels.isEmpty
                  ? const SizedBox()
                  : displayProfile(
                      asscociateModel:
                          appController.profileAssocicateModels.last)
            ],
          );
        });
  }

  Widget displayProfile({required AsscociateModel asscociateModel}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: AppConstant().borderCurveBox(),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 30)),
          const WidgetText(text: 'User Login'),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                  text: 'Assosicate ID : ${asscociateModel.associateID}'),
              WidgetIconButtom(
                iconData: Icons.edit,
                pressFunc: () {
                  TextEditingController textEditingController =
                      TextEditingController();
                  textEditingController.text = asscociateModel.associateID;

                  bool change = false;

                  AppDialog(context: context).normalDialog(
                      title: 'Edit Assosicate ID',
                      subTitle: 'Please Edit  Assosicate ID',
                      contenWidget: WidgetForm(
                        changFunc: (p0) {
                          change = true;
                        },
                        textEditingController: textEditingController,
                      ),
                      actionWidget: WidgetButtom(
                        label: 'Edit',
                        pressFunc: () async {
                          if (change) {
                            Map<String, dynamic> map = asscociateModel.toMap();
                            print('##28june map before -----> $map');

                            map['associateID'] = textEditingController.text;

                            print('##28june map after -----> $map');

                            FirebaseFirestore.instance
                                .collection('associate')
                                .doc(docIdAssociate)
                                .update(map)
                                .then((value) {
                              AppSvervice().findProfileUserLogin();
                              Get.back();
                            });
                          } else {
                            Get.back();
                          }
                        },
                      ));
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(text: 'UserName : ${asscociateModel.name}'),
              WidgetIconButtom(
                iconData: Icons.edit,
                pressFunc: () {
                  TextEditingController textEditingController =
                      TextEditingController();
                  textEditingController.text = asscociateModel.name;

                  bool change = false;

                  AppDialog(context: context).normalDialog(
                      title: 'Edit UserName',
                      subTitle: 'Please Edit  UserName',
                      contenWidget: WidgetForm(
                        changFunc: (p0) {
                          change = true;
                        },
                        textEditingController: textEditingController,
                      ),
                      actionWidget: WidgetButtom(
                        label: 'Edit',
                        pressFunc: () async {
                          if (change) {
                            Map<String, dynamic> map = asscociateModel.toMap();
                            print('##28june map before -----> $map');

                            map['name'] = textEditingController.text;

                            print('##28june map after -----> $map');

                            FirebaseFirestore.instance
                                .collection('associate')
                                .doc(docIdAssociate)
                                .update(map)
                                .then((value) {
                              AppSvervice().findProfileUserLogin();
                              Get.back();
                            });
                          } else {
                            Get.back();
                          }
                        },
                      ));
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(text: 'LastName :${asscociateModel.lastname}'),
              WidgetIconButtom(
                iconData: Icons.edit,
                pressFunc: () {
                  TextEditingController textEditingController =
                      TextEditingController();
                  textEditingController.text = asscociateModel.lastname;

                  bool change = false;

                  AppDialog(context: context).normalDialog(
                      title: 'Edit LastName',
                      subTitle: 'Please Edit LastName',
                      contenWidget: WidgetForm(
                        changFunc: (p0) {
                          change = true;
                        },
                        textEditingController: textEditingController,
                      ),
                      actionWidget: WidgetButtom(
                        label: 'Edit',
                        pressFunc: () async {
                          if (change) {
                            Map<String, dynamic> map = asscociateModel.toMap();
                            print('##28june map before -----> $map');

                            map['lastname'] = textEditingController.text;

                            print('##28june map after -----> $map');

                            FirebaseFirestore.instance
                                .collection('associate')
                                .doc(docIdAssociate)
                                .update(map)
                                .then((value) {
                              AppSvervice().findProfileUserLogin();
                              Get.back();
                            });
                          } else {
                            Get.back();
                          }
                        },
                      ));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
