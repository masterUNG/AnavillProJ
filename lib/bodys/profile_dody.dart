import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/models/associate_model.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

// ignore: use_key_in_widget_constructors
class ProfileBody extends StatefulWidget {
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppSvervice().findProfileUserLogin();
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
                  : displayProfile(asscociateModel: appController.profileAssocicateModels.last)
            ],
          );
        });
  }

  Column displayProfile({required AsscociateModel asscociateModel}) {
    
    return Column(
      children: [
       
        Padding(padding: EdgeInsets.only(bottom: 30)),
        WidgetText(text: 'User Login'),
        Padding(padding: EdgeInsets.only(bottom: 20)),
        WidgetText(text: 'Assosicate ID : ${asscociateModel.associateID}'),
        WidgetText(text: 'UserName : ${asscociateModel.name}'),
        WidgetText(text: 'LastName :${asscociateModel.lastname}'),
      ],
    );
  }
}
