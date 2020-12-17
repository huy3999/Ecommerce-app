import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:doan_cnpm/tools/app_theme.dart';
import 'package:intl/intl.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);
  @override
  _ShoppingCartPage createState() => _ShoppingCartPage();
}

class _ShoppingCartPage extends State<ShoppingCartPage> {
  List<ProductModel> cartList;
  final oCcy = new NumberFormat("#,##0", "en_US");
  final dbHelper = DatabaseHelper.instance;
  ProductService productService = new ProductService();
  Widget _cartItems() {
    return FutureBuilder<List<ProductModel>>(
        future: productService
            .getCartList(), // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            cartList = snapshot.data;
            print('cartlist');
            print(cartList[0].id);
            return Column(children: cartList.map((x) => _item(x)).toList());
          } else {
            print('no item');
            return Center(
              child: Text("No item"),
            );
          }
        });
  }
  // Widget _cartItems() {
  //   return Column(children: cartList.map((x) => _item(x)).toList());
  // }

  Widget _item(ProductModel model) {
    return Container(
        //padding: EdgeInsets.only(top: 10),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: new BoxDecoration(
                                image: new DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: new NetworkImage(model.image[0]))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: CheckboxListTile(
                  value: model.isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      model.isChecked = value;
                      print("name: ${model.name} value: ${model.isChecked}");
                    });
                  },
                  title: Text(
                    model.name,
                  ),
                  contentPadding: EdgeInsets.only(top: 10),
                  subtitle: new Text(
                    "${oCcy.format(model.price)}đ",
                    style: new TextStyle(
                        color: Colors.red[500], fontWeight: FontWeight.w700),
                  ),
                )),
              ],
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircleAvatar(
                  radius: 12,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        //model.quantity--;
                        if (model.quantity-- > 0) {
                          setState(() {
                            productService.updateCartItem(model);
                            //model.quantity = 0;
                          });
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(model.quantity.toString()),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 12,
                  child: new IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        model.quantity++;
                        productService.updateCartItem(model);
                        //model.quantity++;
                      });
                    },
                  ),
                ),
              ],
            ))
          ],
        ));
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          '${itemCount()} Items',
          style: new TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 100,
        ),
        Text(
          "${oCcy.format(getPrice())}đ",
          style: new TextStyle(
              fontSize: 18,
              color: Colors.red[500],
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.orange,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          width: AppTheme.fullWidth(context) * .7,
          child: Text(
            'Next',
            style:
                new TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ));
  }

  double getPrice() {
    double itemPrice = 0;
    if (cartList != null) {
      cartList.forEach((x) {
        itemPrice += (x.price) * x.quantity;
      });
    }
    return itemPrice;
  }

  int itemCount() {
    int count = 0;
    if (cartList != null) {
      cartList.forEach((x) {
        count += x.quantity;
      });
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Cart"),
        centerTitle: false,
      ),
      body: Container(
        padding: AppTheme.padding,
        child: SingleChildScrollView(
          //child: Column(
          //children: <Widget>[
          child: _cartItems(),

          //],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        child: Column(children: <Widget>[
          Divider(
            thickness: 1,
            height: 10,
          ),
          _price(),
          SizedBox(height: 30),
          _submitButton(context),
        ]),
      ),
    );
  }
}
