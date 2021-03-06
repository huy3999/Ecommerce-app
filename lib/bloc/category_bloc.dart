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
  dispose() {
    _categoriesController?.close();
    _loadingController?.close();
  }
}