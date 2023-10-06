import 'package:flutter/material.dart';

class GroupSadkaProvider with ChangeNotifier {
  int item1InitialPrice = 58500;
  int item2InitialPrice = 11500;
  int priceTotal = 58500 + 11500;
  int? item1FinalPrice;
  int item2FinalPrice = 11500;
  String item1 = "Medium Katta\n70 - 85 kg meat";
  String item2 = "Group Order      \n1001";
  TextEditingController item1Controller = TextEditingController();
  TextEditingController item2Controller = TextEditingController();

  void addItem1PriceItem2Price() {
    priceTotal = item1FinalPrice! + item2FinalPrice;
    notifyListeners();
  }

  void item1Total() {
    item1FinalPrice = item1Controller.text == ""
        ? 1 * item1InitialPrice
        : int.parse(item1Controller.text) * item1InitialPrice;
    notifyListeners();
  }

  void item2Total() {
    item2FinalPrice = item2Controller.text == ""
        ? 1 * item2InitialPrice
        : int.parse(item2Controller.text) * item2InitialPrice;
    notifyListeners();
  }
}
