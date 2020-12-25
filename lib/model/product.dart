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
      this.create_at,
      this.isChecked});

  String id;
  String name;
  int price;
  int quantity;
  String id_category;
  List<String> image;
  String description;
  String create_at;
  bool isChecked;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["_id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      id_category: json["id_category"],
      image: json["image"].cast<String>(),
      description: json["description"],
      create_at: json["create_at"],
      isChecked: false);

  factory ProductModel.cartFromJson(Map<String, dynamic> json) {
    List<String> image = new List<String>();
    image.add(json["image"]);
    print('id: ${json["id"]}, img: -${image}-');
    return ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        id_category: json["id_category"],
        image: image,
        description: json["description"],
        create_at: json["create_at"],
        isChecked: false);
  }

  static Map<String, dynamic> toJson(ProductModel productModel) => {
        //"id"        : id,
        "name": productModel.name,
        "price": productModel.price,
        "quantity": productModel.quantity,
        "id_category": productModel.id_category,
        "image": productModel.image,
        "description": productModel.description,
        "create_at": productModel.create_at,
        "isChecked": productModel.isChecked
      };
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
      "id_category": id_category,
      "image": image,
      "description": description,
      "create_at": create_at,
      "isChecked": isChecked
    };
  }

  static String encodeProducts(List<ProductModel> products) => json.encode(
        products
            .map<Map<String, dynamic>>(
                (product) => ProductModel.toJson(product))
            .toList(),
      );

  static List<ProductModel> decodeProducts(String products) =>
      (json.decode(products) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromJson(item))
          .toList();
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
