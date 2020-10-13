import 'package:flutter/material.dart';
import 'package:doan_cnpm/tools/Store.dart';
import 'package:doan_cnpm/tools/app_theme.dart';
import 'package:intl/intl.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);
  @override
  _ShoppingCartPage createState() => _ShoppingCartPage();
}

class _ShoppingCartPage extends State<ShoppingCartPage> {
  Widget _cartItems() {
    return Column(children: cartList.map((x) => _item(x)).toList());
  }

  final oCcy = new NumberFormat("#,##0", "en_US");
  Widget _item(Store model) {
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
                                    image: new NetworkImage(model.itemImage))),
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
                      print(
                          "name: ${model.itemName} value: ${model.isChecked}");
                    });
                  },
                  title: Text(
                    model.itemName,
                  ),
                  contentPadding: EdgeInsets.only(top: 10),
                  subtitle: new Text(
                    "${oCcy.format(model.itemPrice)}đ",
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
                        model.quantity--;
                        if (model.quantity <= 0) {
                          setState(() {
                            model.quantity = 0;
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
    double price = 0;
    cartList.forEach((x) {
      price += (x.itemPrice) * x.quantity;
    });
    return price;
  }

  int itemCount() {
    int count = 0;
    cartList.forEach((x) {
      count += x.quantity;
    });
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
