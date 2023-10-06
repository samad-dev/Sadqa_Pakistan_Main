class Cart_Check {
  int product_id;
  int quantity;
  Cart_Check(this.product_id, this.quantity);
  Map toJson() => {
    'product_id': product_id,
    'quantity': quantity,
  };
}