// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IphoneModel {
  // ignore: non_constant_identifier_names
  final String Name;
  final String cover;
  final int price;
  final int stock;
  IphoneModel({
    // ignore: non_constant_identifier_names
    required this.Name,
    required this.cover,
    required this.price,
    required this.stock,
  });
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'cover': cover,
      'price': price,
      'stock': stock,
    };
  }

  factory IphoneModel.fromMap(Map<String, dynamic> map) {
    return IphoneModel(
      Name: (map['Name'] ?? '') as String,
      cover: (map['cover'] ?? '') as String,
      price: (map['price'] ?? 0) as int,
      stock: (map['stock'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory IphoneModel.fromJson(String source) => IphoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
