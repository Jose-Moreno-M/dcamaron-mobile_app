import 'dart:convert';

import 'package:d_camaron/src/models/product.dart';
import 'package:d_camaron/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String? id;
  String? idClient;
  String? status;
  int? timestamp;
  List<Product>? products = [];
  User? client;

  Order({
    this.id,
    this.idClient,
    this.status,
    this.timestamp,
    this.products,
    this.client
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    idClient: json["id_client"],
    status: json["status"],
    products: json["products"] != null
        ? List<Product>.from(json["products"].map((model) => model is Product
          ? model
          : Product.fromJson(model)))
        : [],
    timestamp: json["timestamp"],
    client: json["client"] is String
        ? userFromJson(json["client"])
        : json["client"] is User
          ? json["client"]
          : User.fromJson(json["client"] ?? {})
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "status": status,
    "products": products,
    "timestamp": timestamp,
    "client": client
  };

  static List<Order> fromJsonList(List<dynamic> jsonList){
    List<Order> toList = [];

    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
    });
    return toList;
  }
}
