// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';

import 'package:sharetraveyard/models/check_associate_model.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';
import 'package:sharetraveyard/widgets/widget_text_buttom.dart';

class DisplayCheckAssociate extends StatelessWidget {
  const DisplayCheckAssociate({
    Key? key,
    required this.checkAssociateModel,
  }) : super(key: key);

  final CheckAssociateModel checkAssociateModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              WidgetText(text: 'AssociateID :'),
              WidgetText(text: checkAssociateModel.associateId),
            ],
          ),
          Row(
            children: [
              WidgetText(text: 'Name :'),
              WidgetText(text: checkAssociateModel.mapProfile['uname']),
            ],
          ),
          Row(
            children: [
              WidgetText(text: 'lastname :'),
              WidgetText(text: checkAssociateModel.mapProfile['ulastname']),
            ],
          ),
          WidgetTextButtom(
            label: 'confirm Data',
            pressFunc: () async {
              AsscociateModel asscociateModel = AsscociateModel(
                  name: checkAssociateModel.mapProfile['uname'],
                  lastname: checkAssociateModel.mapProfile['ulastname'],
                  docIdSiteCode: checkAssociateModel.docIdSiteCode,
                  associateID: checkAssociateModel.associateId,
                  admin: 'user',
                  shopPed: false,
                  shopPhone: true);

              FirebaseFirestore.instance
                  .collection('associate')
                  .doc(checkAssociateModel.associateId)
                  .set(asscociateModel.toMap())
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('associate')
                    .doc(checkAssociateModel.associateId)
                    .collection('profile')
                    .doc()
                    .set(checkAssociateModel.mapProfile)
                    .then((value) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear().then((value) {
                     Get.back();
                  });

                 
                });
              });
            },
          )
        ],
      ),
    );
  }
}
