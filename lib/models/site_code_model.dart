import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SiteCodeModel {

  final String name;
  SiteCodeModel({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory SiteCodeModel.fromMap(Map<String, dynamic> map) {
    return SiteCodeModel(
      name: (map['name'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteCodeModel.fromJson(String source) => SiteCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
