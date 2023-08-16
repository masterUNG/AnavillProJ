import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PedModel {
  final String coverped;
  final String model;
  final String pedID;
  final String price;
  final String stock;
  final String associate;
  final Timestamp timestamp;
  final List<Map<String, dynamic>>? maps;

  PedModel({
    required this.coverped,
    required this.model,
    required this.pedID,
    required this.price,
    required this.stock,
    required this.associate,
    required this.timestamp,
    this.maps,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coverped': coverped,
      'model': model,
      'pedID': pedID,
      'price': price,
      'stock': stock,
      'associate': associate,
      'timestamp': timestamp,
      'maps': maps,
    };
  }

  factory PedModel.fromMap(Map<String, dynamic> map) {
    return PedModel(
      coverped: (map['coverped'] ?? '') as String,
      model: (map['model'] ?? '') as String,
      pedID: (map['pedID'] ?? '') as String,
      price: (map['price'] ?? '') as String,
      stock: (map['stock'] ?? '') as String,
      associate: (map['associate'] ?? '') as String,
     timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
     maps: List<Map<String, dynamic>>.from(map['maps'] ?? []),
    );
  }
  // coverped: (map['coverped'] ?? '') as String,
  //     model: (map['model'] ?? '') as String,
  //     pedID: (map['pedID'] ?? '') as String,
  //     price: (map['price'] ?? '') as String,
  //     stock: (map['stock'] ?? '') as String,
  //     associate: (map['associate'] ?? '') as String,
  //     timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
  //     map: List<Map<String, dynamic>>.from(map['map'] ?? []),

  String toJson() => json.encode(toMap());

  factory PedModel.fromJson(String source) =>
      PedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
