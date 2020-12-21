class Order {
  int totalPrice;
  String customerPhone;
  String idUser;
  List<Items> items;

  Order({this.totalPrice, this.customerPhone, this.idUser, this.items});

  Order.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    customerPhone = json['customer_phone'];
    idUser = json['id_user'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPrice'] = this.totalPrice;
    data['customer_phone'] = this.customerPhone;
    data['id_user'] = this.idUser;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String idProduct;
  int quantity;

  Items({this.idProduct, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['quantity'] = this.quantity;
    return data;
  }
}