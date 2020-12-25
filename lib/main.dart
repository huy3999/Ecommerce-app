import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/login_screen/Screens/Welcome/welcome_screen.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/user_screens/home_page.dart';
import 'package:doan_cnpm/user_screens/shipping.dart';
import 'package:flutter/material.dart';
import 'login_screen/constants.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  ProductService productService = new ProductService();
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      title: 'ECA',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: getStringDataLocally(key: "user"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return HomePage();
          } else {
            return FutureBuilder(
                future: productService.getUserInfo(snapshot.data),
                builder: (context, AsyncSnapshot info) {
                  if (info.data != null) {
                    if (info.data.role == 'Shipping') {
                      return ShippingPage();
                    } else {
                      return HomePage();
                    }
                  } else
                    return Container();
                });
          }
        },
      ),
    ));
  }
}
