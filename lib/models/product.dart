class Product {
  final int id;
  final String name;
  final String short_description;
  final String description;
  final String price;
  final List image;

  const Product({
    required this.id,
    required this.name,
    required this.short_description,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      short_description: json['short_description'],
      price: json['price'],
      image: json['images'],
      description: json['description'],
    );
  }
}


class C_Product {
  final int id;
  final int quantity;


  const C_Product({
    required this.id,
    required this.quantity,

  });

  factory C_Product.fromJson(Map<String, dynamic> json) {
    return C_Product(
      id: json['id'],
      quantity: json['quantity'],

    );
  }
}