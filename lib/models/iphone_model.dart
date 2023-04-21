// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IphoneModel {
  // ignore: non_constant_identifier_names
  final String model;
  final String cover;
  final int price;
  final int stock;
  final String serialID;
  final String capacity;
  final String grade;
  final bool? salseFinish;
  final bool? reserve;
  IphoneModel({
    // ignore: non_constant_identifier_names
    required this.model,
    required this.cover,
    required this.price,
    required this.stock,
    required this.serialID,
    required this.capacity,
    required this.grade,
    this.salseFinish,
    this.reserve,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'cover': cover,
      'price': price,
      'stock': stock,
      'serialID': serialID,
      'capacity': capacity,
      'grade': grade,
      'salseFinish': salseFinish,
      'reserve': reserve,
    };
  }

  factory IphoneModel.fromMap(Map<String, dynamic> map) {
    return IphoneModel(
      model: (map['model'] ?? '') as String,
      cover: (map['cover'] ?? '') as String,
      price: (map['price'] ?? 0) as int,
      stock: (map['stock'] ?? 0) as int,
      serialID: (map['serialID'] ?? '') as String,
      capacity: (map['capacity'] ?? '') as String,
      grade: (map['grade'] ?? '') as String,
      salseFinish: map['salseFinish'] ?? false,
      reserve: map['reserve']  ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory IphoneModel.fromJson(String source) =>
      IphoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
