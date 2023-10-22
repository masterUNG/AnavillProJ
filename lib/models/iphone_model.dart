// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  final Timestamp? timestamp;
  final String? associate;
  final bool? buy;
  final String? associateBuy;
  final String? owner;
  final bool? finish;

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
    this.timestamp,
    this.associate,
    this.buy,
    this.associateBuy,
    this.owner,
     this.finish,
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
      'timestamp': timestamp,
      'associate': associate,
      'buy': buy,
      'associateBuy': associateBuy,
      'owner': owner,
      'finish': finish,
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
      reserve: map['reserve'] ?? false,
      timestamp: map['timestamp'] ?? Timestamp(0, 0),
      associate: map['associate'] ?? '',
      buy: (map['buy'] ?? false) as bool,
      associateBuy: (map['associateBuy'] ?? '') as String,
      owner: (map['owner'] ?? '') as String,
      finish: (map['finish'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory IphoneModel.fromJson(String source) =>
      IphoneModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
