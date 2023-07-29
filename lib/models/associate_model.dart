import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AsscociateModel {
  final String name;
  final String lastname;
  final String docIdSiteCode;
  final String associateID;
  final String? admin;
  final bool? shopPhone;
  final bool? shopPed;
 

 
  
  AsscociateModel({
    required this.name,
    required this.lastname,
    required this.docIdSiteCode,
    required this.associateID,
    this.admin,
    this.shopPhone,
    this.shopPed,

    
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastname': lastname,
      'docIdSiteCode': docIdSiteCode,
      'associateID': associateID,
      'admin': admin,
      'shopPhone': shopPhone,
      'shopPed': shopPed,

      
    };
  }

  factory AsscociateModel.fromMap(Map<String, dynamic> map) {
    return AsscociateModel(
       name: (map['name'] ?? '') as String,
      lastname: (map['lastname'] ?? '') as String,
      docIdSiteCode: (map['docIdSiteCode'] ?? '') as String,
      associateID: (map['associateID'] ?? '') as String,
      admin: map['admin'] ?? '',
      shopPhone: map['shopPhone'] ?? true,
      shopPed: map['shopPed'] ?? true,
    
     
    );
  }


  String toJson() => json.encode(toMap());

  factory AsscociateModel.fromJson(String source) =>
      AsscociateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
