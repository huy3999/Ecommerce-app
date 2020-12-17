import 'package:doan_cnpm/model/category.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  final _categoriesController = new BehaviorSubject<List<CategoryModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productsService = new ProductService();

  Stream<List<CategoryModel>> get categoriesStream => _categoriesController.stream;
  Stream<bool> get loading => _loadingController.stream;

  void loadCategories() async {
    final categories = await _productsService.getAllCategory();
    _categoriesController.sink.add(categories);
  }

  // void addProductToCart(ProductModel product) async {
  //   final products = await _productsService.addToCart(product);
  //   _loadingController.sink.add(products);
  // }

  // void addProducts(ProductModel product) async {
  //   _loadingController.sink.add(true);
  //   await _productsService.addProduct(product);
  //   _loadingController.sink.add(false);
  // }

  // Future<String> uploadProductImage(PickedFile productImage) async {
  //   _loadingController.sink.add(true);
  //   final productImageUrl = await _productsService.uploadImage(productImage);
  //   _loadingController.sink.add(false);
  //   return productImageUrl;
  // }

  // void editProducts(ProductModel product) async {
  //   _loadingController.sink.add(true);
  //   await _productsService.editProduct(product);
  //   _loadingController.sink.add(false);
  // }

  // void removeProducts(String id) async {
  //   await _productsService.removeProduct(id);
  // }

  dispose() {
    _categoriesController?.close();
    _loadingController?.close();
  }
}