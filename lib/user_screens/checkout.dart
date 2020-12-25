import 'package:doan_cnpm/model/db_helper.dart';
import 'package:doan_cnpm/model/order.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/model/user_info.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/user_screens/orders.dart';
import 'package:flutter/cupertino.dart';
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
  String phoneNumber;
  TextEditingController _controller = TextEditingController();
  ProductService productService = new ProductService();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _cartItems() {
    if (widget.itemList != null) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          return Container(
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
                                          widget.itemList[index].image[0]))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListTile(
                      title: Text(widget.itemList[index].name,
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Text('${widget.itemList[index].quantity}',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          )),
                      contentPadding: EdgeInsets.only(top: 10),
                      subtitle: new Text(
                        "${oCcy.format(widget.itemList[index].price)}đ",
                        style: new TextStyle(
                            color: Colors.red[500],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ));
        },
      );
    } else {
      return Container();
    }
  }

  void _handleSubmission(String text) {
    phoneNumber = text;
    print("phone: " + phoneNumber);
    writeDataLocally(key: "phone", value: phoneNumber);
    Navigator.pop(context);
  }

  Widget phoneInput() {
    return FutureBuilder(
      future: getStringDataLocally(key: "phone"),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return FlatButton(
                onPressed: () {
                  _controller.text = "";
                  var alert = AlertDialog(
                    title: Text("Enter your phone number"),
                    content: TextField(
                      style: TextStyle(decoration: TextDecoration.none),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLengthEnforced: false,
                      autofocus: false,
                      enabled: true,
                      onSubmitted: _handleSubmission,
                      controller: _controller,
                      decoration: new InputDecoration(
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: new UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(40, 40, 40, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(40, 40, 40, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(40, 40, 40, 1.0),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: new Icon(
                          Icons.phone,
                          size: 18.0,
                        ),
                      ),
                    ),
                    actions: [
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          _handleSubmission(_controller.text);
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: AppTheme.fullWidth(context) * .3,
                  child: Text(
                    'Add phone number',
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ));
          } else {
            phoneNumber = snapshot.data;
            return Container(
              height: 60,
              child: Row(
                children: [
                  Text('Phone number: ',
                      style: new TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  Text(phoneNumber,
                      style: new TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                      onPressed: () {
                        _controller.text = phoneNumber;
                        var alert = AlertDialog(
                          title: Text("Enter your phone number"),
                          content: TextField(
                            style: TextStyle(decoration: TextDecoration.none),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            maxLengthEnforced: false,
                            autofocus: false,
                            enabled: true,
                            onSubmitted: _handleSubmission,
                            controller: _controller,
                            decoration: new InputDecoration(
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: new UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(40, 40, 40, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(40, 40, 40, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(40, 40, 40, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: new Icon(
                                Icons.phone,
                                size: 18.0,
                              ),
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                _handleSubmission(_controller.text);
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.blue,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: 30,
                        height: 40,
                        child: Text(
                          'Edit',
                          style: new TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ))
                ],
              ),
            );
          }
        }
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
        onPressed: () {
          print("number: " + phoneNumber.toString());
          if (phoneNumber.toString() != 'null') {
            String token;
            UserInfo userInfo;
            getStringDataLocally(key: "user").then((value) {
              token = value;
              print("token: " + token);
              productService.getUserInfo(token).then((value) {
                userInfo = value;
                print("uid: " + userInfo.sId);
                List<Items> items = new List();
                for (var item in widget.itemList) {
                  items.add(
                      new Items(idProduct: item.id, quantity: item.quantity));
                }
                Order order = new Order(
                    customerPhone: phoneNumber.toString(),
                    idUser: userInfo.sId,
                    items: items,
                    totalPrice: getPrice(widget.itemList));
                productService.submitOrder(order).then((value) {
                  if (value) {
                    for (var item in widget.itemList) {
                      productService.deleteCartItem(item);
                    }
                    Navigator.of(context).pushReplacement(
                        new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                new OrderPage()));
                  } else {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Order fail, please try again")));
                  }
                });
              });
            });
          } else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Order fail, please enter phone number")));
          }
        },
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

  int getPrice(List<ProductModel> list) {
    int itemPrice = 0;
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
      key: _scaffoldKey,
      body: Container(
        //margin: const EdgeInsets.only(bottom: 150),
        padding: AppTheme.padding,
        //child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //child: _cartItems(),
            phoneInput(),
            Divider(
              thickness: 1,
              height: 10,
            ),
            _cartItems(),
          ],
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
