import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/user_screens/checkout.dart';
import 'package:doan_cnpm/user_screens/my_cart.dart';
import 'package:doan_cnpm/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetail extends StatefulWidget {
  String itemId;
  String itemName;
  List<String> itemImage;
  String itemSubName;
  int itemPrice;
  double itemRating;
  String itemDescription;

  ItemDetail(
      {this.itemId,
      this.itemName,
      this.itemImage,
      this.itemRating,
      this.itemPrice,
      this.itemSubName,
      this.itemDescription});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  int number = 1;
  final oCcy = new NumberFormat("#,##0", "en_US");
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Item Detail"),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      key: _scaffoldKey,
      body: new Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(widget.itemImage[0]),
                    fit: BoxFit.fitHeight),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(120.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
          ),
          new Container(
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: new BorderRadius.only(
                  bottomRight: new Radius.circular(120.0),
                  bottomLeft: new Radius.circular(120.0),
                )),
          ),
          new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: 50.0,
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          widget.itemName,
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0,
                                ),
                                new SizedBox(
                                  width: 5.0,
                                ),
                                new Text(
                                  "4",
                                  style: new TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                            Row(children: [
                              widget.itemPrice != null
                                  ? Text(
                                      "${oCcy.format(widget.itemPrice)}đ",
                                      style: new TextStyle(
                                          color: Colors.red[500],
                                          fontWeight: FontWeight.w700),
                                    )
                                  : Text('Liên hệ',
                                      style: new TextStyle(
                                          color: Colors.red[500],
                                          fontWeight: FontWeight.w700))
                            ]),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    height: 150.0,
                    child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.itemImage.length,
                        itemBuilder: (context, index) {
                          return new Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Container(
                                margin:
                                    new EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 140.0,
                                width: 100.0,
                                child:
                                    new Image.network(widget.itemImage[index]),
                              ),
                              new Container(
                                margin:
                                    new EdgeInsets.only(left: 5.0, right: 5.0),
                                height: 140.0,
                                width: 100.0,
                                decoration: new BoxDecoration(
                                    color: Colors.grey.withAlpha(50)),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Description",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new ExpandableText(
                          widget.itemDescription,
                          trimLines: 5,
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                new Card(
                  child: new Container(
                    width: screenSize.width,
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text(
                          "Quantity",
                          style: new TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new CircleAvatar(
                              child: new IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    number--;
                                    if (number <= 0) {
                                      setState(() {
                                        number = 0;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                            Text(number.toString()),
                            CircleAvatar(
                              child: new IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    number++;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => new ShoppingCartPage()));
            },
            child: new Icon(Icons.shopping_cart),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (widget.itemPrice != null) {
                    productsBloc.addProductToCart(new ProductModel(
                        id: widget.itemId,
                        name: widget.itemName,
                        price: widget.itemPrice,
                        image: widget.itemImage,
                        quantity: number,
                        isChecked: false));
                  }else{
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("This product currently has no price")));
                  }
                },
                child: new Container(
                  width: (screenSize.width - 20) / 2,
                  child: new Text(
                    "ADD TO CART",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (number > 0 && widget.itemPrice != null) {
                    List<ProductModel> checkoutList = new List();
                    checkoutList.add(new ProductModel(
                        id: widget.itemId,
                        name: widget.itemName,
                        price: widget.itemPrice,
                        image: widget.itemImage,
                        quantity: number,
                        isChecked: false));
                    if (checkoutList.isNotEmpty) {
                      Navigator.of(context)
                          .push(new CupertinoPageRoute<String>(
                              builder: (context) => new CheckoutPage(
                                    itemList: checkoutList,
                                  )))
                          .then((value) => setState(() => {}));
                    }
                  } else if (number <= 0) {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Please select item quantity")));
                  } else if (widget.itemPrice == null) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("This product currently has no price")));
                  }
                },
                child: new Container(
                  width: (screenSize.width - 20) / 2,
                  child: new Text(
                    "BUY NOW",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
