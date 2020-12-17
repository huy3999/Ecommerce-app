import 'dart:convert';
import 'package:doan_cnpm/model/category.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/preferences/user_preferences.dart';
import 'dart:io';

class ProductService {
  final String _baseUrl = 'http://dacnpm-test.herokuapp.com';
  //final _prefs = new UserPreferences();

  Future<List<ProductModel>> getAllProducts() async {
    final url = '$_baseUrl/products/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<ProductModel> products = new List<ProductModel>();
      Iterable l = json.decode(response.body);
      products = l.map((i) => ProductModel.fromJson(i)).toList();
      //print(products);
      //print(products[0].name);
      return products;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<List<CategoryModel>> getAllCategory() async {
    final url = '$_baseUrl/categories/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<CategoryModel> categories = new List<CategoryModel>();
      Iterable l = json.decode(response.body);
      categories = l.map((i) => CategoryModel.fromJson(i)).toList();
      //print(products);
      //print(products[0].name);
      return categories;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String id) async {
    final url = '$_baseUrl/products?id_category=$id&&limit=7';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<ProductModel> products = new List<ProductModel>();
      Iterable l = json.decode(response.body);
      //print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'+response.body);
      products = l.map((i) => ProductModel.fromJson(i)).toList();
      //print('products----------------------------------------------');
      //print('xxx'+products[0].name);
      return products;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<bool> addToCart(ProductModel product) async {
    List<ProductModel> cartList = await getListDataLocally(key: 'cartList');
    if (cartList == null) cartList = new List<ProductModel>();
    cartList.add(product);
    print(cartList[0]);
    var map = ProductModel.encodeProducts(cartList);
    //print("add to cart"+map);
    writeDataLocally(key: 'cartList', value: map);
    return true;
  }

  // List<ProductModel> parseProducts(String responseBody) {
  //   //  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   //  return parsed.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
  //   final parsed = json.decode(responseBody);
  //   return parsed
  //       .map<ProductModel>((json) => ProductModel.fromJson(json))
  //       .toList();
  // }

  // Future<bool> addProduct(ProductModel product) async {
  //   final url = '$_baseUrl/products.json?auth=${_prefs.token}';

  //   final resp = await http.post(url, body: productModelToJson(product));
  //   return true;
  // }

  // Future<bool> editProduct(ProductModel product) async {
  //   /// TODO extract to constant files
  //   final url = '$_baseUrl/products/${product.id}.json?auth=${_prefs.token}';

  //   final resp = await http.put(url, body: productModelToJson(product));
  //   final decodedData = json.decode(resp.body);
  //   print(decodedData);

  //   return true;
  // }

  // Future<int> removeProduct(String id) async {
  //   final url = '$_baseUrl/products/$id.json?auth=${_prefs.token}';
  //   final resp = await http.delete(url);

  //   return 1;
  // }

  // Future<String> uploadImage(PickedFile image) async {
  //   ///TODO Extract url for constants file
  //   final url = Uri.parse(
  //       'https://api.cloudinary.com/v1_1/dsk6auln9/image/upload?upload_preset=hj2ad9ki');
  //   final mimeType = mime(image.path).split('/');

  //   /// image/jpg,png
  //   final imageUploadRequest = http.MultipartRequest('POST', url);

  //   final file = await http.MultipartFile.fromPath('file', image.path,
  //       contentType: MediaType(mimeType[0], mimeType[1]));

  //   imageUploadRequest.files.add(file);

  //   /// Iterate and send many files just adding:
  //   ///imageUploadRequest.files.add(file1);
  //   ///imageUploadRequest.files.add(file2);
  //   final streamResponse = await imageUploadRequest.send();
  //   final resp = await http.Response.fromStream(streamResponse);

  //   if (resp.statusCode != 200 && resp.statusCode != 201) {
  //     print('Not worked correctly');
  //     print(resp.body);
  //     return null;
  //   }

  //   final respData = json.decode(resp.body);
  //   print(respData);
  //   return respData['secure_url'];
  // }
}
