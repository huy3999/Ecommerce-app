import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/userScreens/checkout.dart';
import 'package:flutter/cupertino.dart';
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
  Future cartFuture;
  final oCcy = new NumberFormat("#,##0", "en_US");
  final dbHelper = DatabaseHelper.instance;
  ProductService productService = new ProductService();
  Widget _cartItems() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: FutureBuilder<List<ProductModel>>(
          future: cartFuture, // a previously-obtained Future<String> or null
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              cartList = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print(cartList[0].name);
                  return Dismissible(
                      background: Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 1,
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(320.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        productService.deleteCartItem(cartList[index]);
                        print('deleted index $index');
                        //});
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Đã xóa ${snapshot.data[index].name}")));
                      },
                      child: Container(
                          //padding: EdgeInsets.only(top: 10),
                          height: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                                      image: new NetworkImage(
                                                          cartList[index]
                                                              .image[0]))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child:
                                          //    CheckboxListTile(
                                          // value: cartList[index].isChecked,
                                          // onChanged: (bool value) {
                                          //   setState(() {
                                          //     cartList[index].isChecked = value;
                                          //     print(
                                          //         "name: ${cartList[index].name} value: ${cartList[index].isChecked}");
                                          //   });
                                          // },
                                          ListTile(
                                    title: Text(
                                      cartList[index].name,
                                    ),
                                    contentPadding: EdgeInsets.only(top: 10),
                                    subtitle: new Text(
                                      "${oCcy.format(cartList[index].price)}đ",
                                      style: new TextStyle(
                                          color: Colors.red[500],
                                          fontWeight: FontWeight.w700),
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
                                          cartList[index].quantity--;
                                          if (cartList[index].quantity >= 0) {
                                            setState(() {
                                              productService.updateCartItem(
                                                  cartList[index]);
                                            });
                                          } else
                                            cartList[index].quantity = 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(cartList[index].quantity.toString()),
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
                                          cartList[index].quantity++;
                                          productService
                                              .updateCartItem(cartList[index]);
                                          //model.quantity++;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          )));
                },
              );
              //return Column(children: cartList.map((x) => _item(x)).toList());
            } else {
              print('no item');
              return Center(
                child: Text("No item"),
              );
            }
          }),
    );
  }

  @override
  void initState() {
    cartFuture = productService.getCartList();
    super.initState();
  }

  Widget _price() {
    return FutureBuilder<List<ProductModel>>(
        future: productService
            .getCartList(), // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '${itemCount(snapshot.data)} Items',
                    style: new TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "${oCcy.format(getPrice(snapshot.data))}đ",
                    style: new TextStyle(
                        fontSize: 18,
                        color: Colors.red[500],
                        fontWeight: FontWeight.w700),
                  ),
                ]);
          } else
            return Container();
        });
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
        onPressed: () {
          List<ProductModel> checkoutList = new List();
          productService.getCartList().then((value) {
            List<ProductModel> itemList = value;
            for (ProductModel item in itemList) {
              if (item.quantity > 0) {
                checkoutList.add(item);
              }
            }
            if(checkoutList.isNotEmpty){
               Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (context) => new CheckoutPage(
                              itemList: checkoutList,
                            )));
            }
          });
        },
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

  double getPrice(List<ProductModel> list) {
    double itemPrice = 0;
    if (list != null) {
      list.forEach((x) {
        itemPrice += (x.price) * x.quantity;
      });
    }
    return itemPrice;
  }

  int itemCount(List<ProductModel> list) {
    int count = 0;
    if (list != null) {
      list.forEach((x) {
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
        //margin: const EdgeInsets.only(bottom: 150),
        padding: AppTheme.padding,
        //child: SingleChildScrollView(
        //child: Column(
        //children: <Widget>[
        child: _cartItems(),

        //],
        //),
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
