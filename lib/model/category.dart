class CategoryModel {
  String Id;
  String name;

  CategoryModel({this.Id, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['name'] = this.name;
    return data;
  }
}