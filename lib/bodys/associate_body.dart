import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharetraveyard/states/add_new_associate.dart';
import 'package:sharetraveyard/utility/app_constant.dart';
import 'package:sharetraveyard/utility/app_controller.dart';
import 'package:sharetraveyard/utility/app_svervice.dart';
import 'package:sharetraveyard/widgets/widget_buttom.dart';
import 'package:sharetraveyard/widgets/widget_text.dart';

class AssociateBody extends StatefulWidget {
  const AssociateBody({super.key});

  @override
  State<AssociateBody> createState() => _AssociateBodyState();
}

class _AssociateBodyState extends State<AssociateBody> {
  @override
  void initState() {
    super.initState();
    AppSvervice().readAllAssociate();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print(
                'AssociateModel --> ${appController.assosicateModels.length}');
            return appController.assosicateModels.isEmpty
                ? const SizedBox()
                : SizedBox(
                    width: boxConstraints.maxWidth,
                    height: boxConstraints.maxHeight,
                    child: Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: appController.assosicateModels.length,
                          itemBuilder: (context, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText(
                                    text: appController
                                        .assosicateModels[index].associateID,
                                    textStyle: AppConstant().h2Style(),
                                  ),
                                  WidgetText(
                                      text:
                                          '${appController.assosicateModels[index].name} ${appController.assosicateModels[index].lastname}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 32,
                          right: 32,
                          child: WidgetButtom(
                            label: 'Add Associate ID',
                            pressFunc: () {
                              Get.to(const AddNewAssociate())!.then(
                                  (value) => AppSvervice().readAllAssociate());
                            },
                          ),
                        )
                      ],
                    ),
                  );
          });
    });
  }
}
