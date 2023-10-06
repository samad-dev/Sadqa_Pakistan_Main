import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
     title: json['title'],
      quantity: json['quantity'],
      price: json['price']
    );
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"]  = this.id;
    data["title"]  = this.title;
    data["quantity"]  = this.quantity;
    data["price"]  = this.price;

    return data;

  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total = total + cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total = total + cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String id, double price, String title) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
              (existing) => CartItem(
            id: existing.id,
            price: existing.price,
            quantity: existing.quantity + 1,
            title: existing.title,
          ));

      print("$title is added to cart multiple");
    } else {
      _items.putIfAbsent(
          id,
              () => CartItem(
            id: DateTime.now().toString(),
            price: price,
            quantity: 1,
            title: title,
          ));
      print("$title is added to cart");
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  set items(Map<String, CartItem> value) {
    _items = value;
  }
}