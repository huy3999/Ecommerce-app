import 'package:doan_cnpm/login_screen/Screens/Welcome/welcome_screen.dart';
import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/shipping_model.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doan_cnpm/tools/app_theme.dart';
import 'package:intl/intl.dart';

class ShippingPage extends StatefulWidget {
  ShippingPage({Key key}) : super(key: key);
  @override
  _ShippingPage createState() => _ShippingPage();
}

class _ShippingPage extends State<ShippingPage> {
  final oCcy = new NumberFormat("#,##0", "en_US");
  String user_id;
  ProductService productService = new ProductService();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Shipping> data;
  Widget buttons(int index) {
    if (data[index].status == 'Shipping') {
      return FlatButton(
          onPressed: () {
            var alert = AlertDialog(
              title: Text("Take this order"),
              content: Text("Do you want to take this order?"),
              actions: [
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    productService
                        .takeOrder(data[index].idOrder, user_id)
                        .then((value) {
                      setState(() {
                        data[index].status = 'isTaken';
                      });
                      Navigator.of(context).pop();
                     _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(content: Text('Order taken')));
                    });
                  },
                )
              ],
            );

            showDialog(
              context: context,
              builder: (context) {
                return alert;
              },
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.orange,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            width: AppTheme.fullWidth(context) * .2,
            child: Text(
              'Take order',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ));
    } else if (data[index].status == 'isTaken') {
      return FlatButton(
          onPressed: () {
            var alert = AlertDialog(
              title: Text("Complete delivery"),
              content: Text("Do you want to complete this order?"),
              actions: [
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    productService
                        .completeOrder(data[index].idOrder)
                        .then((value) {
                      setState(() {
                        data[index].status = 'Success';
                      });
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(content: Text('Completed')));
                    });
                  },
                )
              ],
            );

            showDialog(
              context: context,
              builder: (context) {
                return alert;
              },
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.green,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            width: AppTheme.fullWidth(context) * .15,
            child: Text(
              'Complete',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ));
    } else {
      return FlatButton(
          onPressed: () {
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.blue.shade300,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            width: AppTheme.fullWidth(context) * .15,
            child: Text(
              'Success',
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ));
    }
  }

  Widget _cartItems() {
    print("user_id: " + user_id);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: FutureBuilder<List<Shipping>>(
          future: productService.getAllShippingOrders(
              user_id), // a previously-obtained Future<String> or null
          builder:
              (BuildContext context, AsyncSnapshot<List<Shipping>> snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Status:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("${data[index].status}",
                                      style: new TextStyle(
                                          color: Colors.blue[500],
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(mainAxisSize: MainAxisSize.min, children: [
                                Row(
                                  children: [
                                    Text("Customer phone: "),
                                    Text(
                                        "${data[index].customerPhone}",
                                        style: new TextStyle(
                                            color: Colors.blue[500],
                                            fontWeight: FontWeight.w700))
                                  ],
                                ),
                              ]),
                              Row(
                                children: [
                                  Text("Total:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${oCcy.format(data[index].totalPrice)}đ",
                                      style: new TextStyle(
                                          color: Colors.red[500],
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Text(
                                  "${DateFormat("dd-MM-yyyy hh:mm").format(DateTime.parse(data[index].createAt))}",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                              buttons(index)
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
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
    getStringDataLocally(key: 'user_id').then((value) {
      setState(() {
        user_id = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: Container(),
        title: new Text("Shipping orders"),
        centerTitle: true,
        key: _scaffoldKey,
        actions: [
          new IconButton(
              icon: new Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                clearDataLocally();
                Navigator.of(context).pushReplacement(new CupertinoPageRoute(
                    builder: (BuildContext context) => new WelcomeScreen()));
              }),
        ],
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
