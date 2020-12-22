import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/model/user_order.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/userScreens/checkout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doan_cnpm/tools/app_theme.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);
  @override
  _OrderPage createState() => _OrderPage();
}

class _OrderPage extends State<OrderPage> {
  List<ProductModel> cartList;
  Future cartFuture;
  final oCcy = new NumberFormat("#,##0", "en_US");
  final dbHelper = DatabaseHelper.instance;
  ProductService productService = new ProductService();
  Widget _cartItems() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: FutureBuilder<List<UserOrders>>(
          future: productService
              .getAllOrders(), // a previously-obtained Future<String> or null
          builder:
              (BuildContext context, AsyncSnapshot<List<UserOrders>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Status:"),
                              SizedBox(width: 10,),
                              Text(
                                  "${snapshot.data[index].status}",
                                  style: new TextStyle(
                                      color: Colors.blue[500],
                                      fontWeight: FontWeight.w700)),
                              
                            ],
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                              children: snapshot.data[index].orderItem
                                  .map((x) => _item(x))
                                  .toList()),
                          Row(
                            children: [
                              Text("Total:"),
                              SizedBox(width: 10,),
                              Text(
                                  "${oCcy.format(snapshot.data[index].totalPrice)}đ",
                                  style: new TextStyle(
                                      color: Colors.red[500],
                                      fontWeight: FontWeight.w700)),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              //return Column(children: cartList.map((x) => _item(x)).toList());
            } else {
              print('no item');
              return Center(
                child: CircularProgressIndicator()
              );
            }
          }),
    );
  }

  Widget _item(OrderItem item) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Text(
            item.productName,
          ),
          trailing: Text('x${item.quantity}'),
          contentPadding: EdgeInsets.only(top: 10),
          subtitle: new Text(
            "${oCcy.format(item.price)}đ",
            style: new TextStyle(
                color: Colors.red[500], fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ));
  }

  @override
  void initState() {
    //cartFuture = productService.getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My orders"),
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
    );
  }
}
