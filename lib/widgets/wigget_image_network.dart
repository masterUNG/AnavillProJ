// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sharetraveyard/widgets/widget_progress.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    Key? key,
    required this.urlImage,
    this.width,
    this.height,
  }) : super(key: key);

  final String urlImage;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      width: width,
      height: height,
      placeholder: (context, url) => const WidgetProgress(),
    );
  }
}
