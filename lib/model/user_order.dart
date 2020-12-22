class UserOrders {
  String status;
  String sId;
  int totalPrice;
  String customerPhone;
  String idUser;
  String createAt;
  List<OrderItem> orderItem;

  UserOrders(
      {this.status,
      this.sId,
      this.totalPrice,
      this.customerPhone,
      this.idUser,
      this.createAt,
      this.orderItem});

  UserOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    totalPrice = json['totalPrice'];
    customerPhone = json['customer_phone'];
    idUser = json['id_user'];
    createAt = json['create_at'];
    if (json['orderItem'] != null) {
      orderItem = new List<OrderItem>();
      json['orderItem'].forEach((v) {
        orderItem.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['totalPrice'] = this.totalPrice;
    data['customer_phone'] = this.customerPhone;
    data['id_user'] = this.idUser;
    data['create_at'] = this.createAt;
    if (this.orderItem != null) {
      data['orderItem'] = this.orderItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  int quantity;
  String sId;
  String idProduct;
  String idOrder;
  int price;
  String createAt;
  String productName;

  OrderItem(
      {this.quantity,
      this.sId,
      this.idProduct,
      this.idOrder,
      this.price,
      this.createAt,
      this.productName});

  OrderItem.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    sId = json['_id'];
    idProduct = json['id_product'];
    idOrder = json['id_order'];
    price = json['price'];
    createAt = json['create_at'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['id_product'] = this.idProduct;
    data['id_order'] = this.idOrder;
    data['price'] = this.price;
    data['create_at'] = this.createAt;
    data['product_name'] = this.productName;
    return data;
  }
}