import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SiteCodeModel {

  final String name;
  final String ped;

  SiteCodeModel({
    required this.name,
    required this.ped,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'ped': ped,
    };
  }

  factory SiteCodeModel.fromMap(Map<String, dynamic> map) {
    return SiteCodeModel(
      name: (map['name'] ?? '') as String,
      ped: (map['ped'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteCodeModel.fromJson(String source) => SiteCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
