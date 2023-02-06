import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AsscociateModel {
  final String name;
  final String lastname;
  final String docIdSiteCode;

  AsscociateModel({
    required this.name,
    required this.lastname,
    required this.docIdSiteCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastname': lastname,
      'docIdSiteCode': docIdSiteCode,
    };
  }

  factory AsscociateModel.fromMap(Map<String, dynamic> map) {
    return AsscociateModel(
      name: (map['name'] ?? '') as String,
      lastname: (map['lastname'] ?? '') as String,
      docIdSiteCode: (map['docIdSiteCode'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AsscociateModel.fromJson(String source) =>
      AsscociateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
