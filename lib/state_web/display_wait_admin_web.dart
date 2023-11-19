// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sharetraveyard/models/check_associate_model.dart';
import 'package:sharetraveyard/states/authen_mobile.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_dialog.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class DisplayWaitAdminWeb extends StatefulWidget {
  const DisplayWaitAdminWeb({
    Key? key,
    required this.docIdAssociate,
  }) : super(key: key);

  final String docIdAssociate;

  @override
  State<DisplayWaitAdminWeb> createState() => _DisplayWaitAdminWebState();
}

class _DisplayWaitAdminWebState extends State<DisplayWaitAdminWeb> {
  bool? resultAdmin;

  @override
  void initState() {
    super.initState();
    findData();
  }

  void findData() async {
    String docId = GetStorage().read('docIdCheckAssociate');
    print('##8nov นี่คือค่า docId ของ web ---> $docId');

    FirebaseFirestore.instance
        .collection('checkassociate')
        .doc(docId)
        .get()
        .then((value) {
      CheckAssociateModel checkAssociateModel =
          CheckAssociateModel.fromMap(value.data()!);
      resultAdmin = checkAssociateModel.resultAdmin;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetText(
              text: resultAdmin ?? true ? 'Wait Admin Check' : 'Admin Cancel',
              textStyle: AppConstant().h1Style(),
            ),
            WidgetButtom(
              label: 'Clear',
              pressFunc: () {
                AppDialog(context: context).normalDialog(
                    title: 'clear และ สมัครใหม่',
                    subTitle: 'ยืนยัน clear และสมัครใหม่',
                    action2Widget: WidgetButtom(
                      label: 'ยืนยัน',
                      pressFunc: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        String? docId =
                            preferences.getString('docIdCheckAssociate');
                        FirebaseFirestore.instance
                            .collection('checkassociate')
                            .doc(docId)
                            .delete()
                            .then((value) {
                          preferences.clear().then((value) {
                            Get.offAll(const AuthenMobile());
                          });
                        });
                      },
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
