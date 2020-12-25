import 'package:doan_cnpm/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:doan_cnpm/bloc/product_bloc.dart';
export 'package:doan_cnpm/bloc/product_bloc.dart';

class Provider extends InheritedWidget {
  //final _loginBloc = new LoginBloc();
  final _productsBloc = new ProductsBloc();
  final _categoriesBloc = new CategoriesBloc();
  static Provider _instance;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  /// Key key of Widget
  /// Widget (Text, Material App, Container)
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  /// Look up on InheritedWidget tree for LoginBloc Widget
  // static LoginBloc of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  // }

  static ProductsBloc productsBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
  static CategoriesBloc categoriesBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._categoriesBloc;
  }

  // static Provider of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<Provider>();
  // }
}
