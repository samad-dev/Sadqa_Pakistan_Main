class Order {
  final int id;
  final String date;
  final String amount;
  final String payment_method;
  final String payment_status;
  final String order_status;
  // final String meta_data;
  final List meta_data;

  const Order({
    required this.id,
    required this.date,
    required this.amount,
    required this.payment_method,
    required this.payment_status,
    required this.order_status,
    required this.meta_data,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date_created'],
      amount: json['total'],
      payment_method: json['payment_method_title'],
      payment_status: json['date_created'], 
      order_status: json['status'],
      meta_data: json['meta_data'],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"]  = this.id;
    data["date"]  = this.date;
    data["amount"]  = this.amount;
    data["payment_method"]  = this.payment_method;
    data["payment_status"]  = this.payment_status;
    data["order_status"]  = this.order_status;
    data["meta_data"]  = this.meta_data;

    return data;

  }
}


