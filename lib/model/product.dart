import 'dart:convert';

// ProductModel productModelFromJson(String jsonAsString) =>
//     ProductModel.fromJson(json.decode(jsonAsString));
// String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.id_category,
      this.image,
      this.description,
      this.create_at});

  String id;
  String name;
  int price;
  int quantity;
  String id_category;
  List<String> image;
  String description;
  String create_at;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["_id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      id_category: json["id_category"],
      image: json["image"].cast<String>(),
      description: json["description"],
      create_at: json["create_at"]);

  // factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
  //     json["_id"] as String,
  //     json["name"]as String,
  //     json["price"] as int,
  //     json["quantity"] as int,
  //     json["id_category"] as int,
  //     json["image"]as String,
  //     json["description"]as String,
  //     json["create_at"]as String);
// factory ProductModel.fromMap(Map<String, dynamic> json) {
//       return ProductModel(
//       json["_id"],
//       json["name"],
//       int.parse(json["price"]),
//       int.parse(json["quantity"]),
//       int.parse(json["id_category"]),
//       json["image"],
//       json["description"],
//       json["create_at"]
//       );

  //}
  Map<String, dynamic> toJson() => {
        //"id"        : id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "id_category": id_category,
        "image": image,
        "description": description,
        "create_at": create_at
      };
}

class Brand {
  String brand_id;
  String brand_name;

  Brand({this.brand_id, this.brand_name});

  Brand.fromJson(Map<String, dynamic> json) {
    brand_id = json['_id'];
    brand_name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.brand_id;
    data['name'] = this.brand_name;
    return data;
  }
}
