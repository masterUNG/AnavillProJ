import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PictureModel {
  final String pic;
  PictureModel({
    required this.pic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pic': pic,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      pic: (map['pic'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) => PictureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
