import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:doan_cnpm/tools/app_theme.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  List<ProductModel> itemList;

  CheckoutPage({this.itemList});
  @override
  _CheckoutPage createState() => _CheckoutPage();
}

class _CheckoutPage extends State<CheckoutPage> {
  final oCcy = new NumberFormat("#,##0", "en_US");
  final dbHelper = DatabaseHelper.instance;
  ProductService productService = new ProductService();
  Widget _cartItems() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.itemList.length,
      itemBuilder: (context, index) {
        return Container(
            height: 120,
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
                                        image: new NetworkImage(widget
                                            .itemList[index].image[0]))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListTile(
                      title: Text(
                        widget.itemList[index].name,
                      ),
                      trailing: Text('x ${widget.itemList[index].quantity}'),
                      contentPadding: EdgeInsets.only(top: 10),
                      subtitle: new Text(
                        "${oCcy.format(widget.itemList[index].price)}đ",
                        style: new TextStyle(
                            color: Colors.red[500],
                            fontWeight: FontWeight.w700),
                      ),
                    )),
                  ],
                ),
              ],
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _price() {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '${itemCount(widget.itemList)} Items',
                    style: new TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "${oCcy.format(getPrice(widget.itemList))}đ",
                    style: new TextStyle(
                        fontSize: 18,
                        color: Colors.red[500],
                        fontWeight: FontWeight.w700),
                  ),
                ]);
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
            'Order',
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
        title: new Text("Checkout"),
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
