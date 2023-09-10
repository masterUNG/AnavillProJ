// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharetraveyard/models/associate_model.dart';

import 'package:sharetraveyard/models/check_associate_model.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: AppConstant().borderCurveBox(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: 'AssociateID : '),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: checkAssociateModel.associateId),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: 'Name : '),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: checkAssociateModel.mapProfile['uname']),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: 'Lastname : '),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                WidgetText(text: checkAssociateModel.mapProfile['ulastname']),
              ],
            ),
          
            WidgetButtom(
              label: 'confirm Data',
              pressFunc: () async {
                AsscociateModel asscociateModel = AsscociateModel(
                    name : checkAssociateModel.mapProfile['uname'],
                    lastname : checkAssociateModel.mapProfile['ulastname'],
                    docIdSiteCode : checkAssociateModel.docIdSiteCode,
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
      ),
    );
  }
}
