class Shipping {
  String status;
  String sId;
  int totalPrice;
  String customerPhone;
  String idUser;
  String createAt;
  String idShipper;
  String idOrder;

  Shipping(
      {this.status,
      this.sId,
      this.totalPrice,
      this.customerPhone,
      this.idUser,
      this.createAt,
      this.idShipper,
      this.idOrder});

  Shipping.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    totalPrice = json['totalPrice'];
    customerPhone = json['customer_phone'];
    idUser = json['id_user'];
    createAt = json['create_at'];
    idShipper = json['id_shipper'];
    idOrder = json['id_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['totalPrice'] = this.totalPrice;
    data['customer_phone'] = this.customerPhone;
    data['id_user'] = this.idUser;
    data['create_at'] = this.createAt;
    data['id_shipper'] = this.idShipper;
    data['id_order'] = this.idOrder;
    return data;
  }
}
