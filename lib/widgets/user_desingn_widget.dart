import 'package:flutter/material.dart';
import 'package:sharetraveyard/models/associate_model.dart';

class UserDesingnWidget extends StatefulWidget {
  AsscociateModel? model;
  BuildContext? context;

  UserDesingnWidget({
this.model,
this.context,
  });

  @override
  State<UserDesingnWidget> createState() => _UserDesingnWidgetState();
}

class _UserDesingnWidgetState extends State<UserDesingnWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
