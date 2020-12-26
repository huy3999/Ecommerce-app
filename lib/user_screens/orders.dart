import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/model/user_order.dart';
import 'package:doan_cnpm/services/product_service.dart';
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
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Status:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${snapshot.data[index].status}",
                                      style: new TextStyle(
                                          color: Colors.blue[500],
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${DateFormat("dd-MM-yyyy hh:mm").format(DateTime.parse(snapshot.data[index].createAt))}",
                                      style: new TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
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
                                  SizedBox(
                                    width: 10,
                                  ),
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
                      ),
                      (snapshot.data[index].status == 'Submitted' ||
                              snapshot.data[index].status == 'Processing')
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: FlatButton(
                                onPressed: () {
                                  var alert = AlertDialog(
                                      title: Text("Cancel order"),
                                      content: Text(
                                          "Do you want to cancel this order?"),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            productService
                                                .cancelOrder(
                                                    snapshot.data[index].sId)
                                                .then((value) {
                                              if (value) {
                                                setState(() {});
                                                Navigator.of(context).pop();
                                                Scaffold.of(context)
                                                    .showSnackBar(new SnackBar(
                                                        content: Text(
                                                            'Cancel completed')));
                                              }
                                            });
                                          },
                                        )
                                      ]);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return alert;
                                    },
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.red,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(3),
                                  child: Text(
                                    'Cancel',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            )
                    ]);
                  },
                ),
              );
              //return Column(children: cartList.map((x) => _item(x)).toList());
            } else {
              print('no item');
              return Center(child: CircularProgressIndicator());
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
