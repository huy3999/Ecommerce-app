import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:doan_cnpm/adminScreens/admin_home.dart';
import 'package:doan_cnpm/tools/Store.dart';
import 'package:doan_cnpm/tools/app_data.dart';
import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/tools/app_methods.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/tools/firebase_methods.dart';
import 'package:doan_cnpm/userScreens/item_details.dart';
import 'package:doan_cnpm/userScreens/itemdetails.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'favorites.dart';
import 'messages.dart';
import 'my_cart.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'orders.dart';
import 'aboutUs.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class LoadMorePage extends StatefulWidget {
  String id;

  LoadMorePage(
      {this.id});

  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {
  BuildContext context;
  final oCcy = new NumberFormat("#,##0", "en_US");

  ProductService productService = new ProductService();


  // AppMethods appMethods = new FirebaseMethods();

  @override
  void initState() {
    // TODO: implement initState
    //getCurrentUser();
    super.initState();
  }

  // Future getCurrentUser() async {
  //   // acctName = await getStringDataLocally(key: acctFullName);
  //   // acctEmail = await getStringDataLocally(key: userEmail);
  //   // acctPhotoURL = await getStringDataLocally(key: photoURL);
  //   // isLoggedIn = await getBoolDataLocally(key: loggedIN);
  //   //print(await getStringDataLocally(key: userEmail));
  //   acctName == null ? acctName = "Guest User" : acctName;
  //   acctEmail == null ? acctEmail = "guestUser@email.com" : acctEmail;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    productsBloc.loadAllProductsByCategory(widget.id);
    return new Scaffold(
      appBar: new AppBar(
        title: GestureDetector(
          child: new Text("E-commerce"),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                    new GirliesFavorities()));
              }),
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (BuildContext context) =>
                        new GirliesMessages()));
                  }),
              new CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: new Text(
                  "2",
                  style: new TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          )
        ],
      ),
      body: _showProductList(productsBloc),
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
          new CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: new Text(
              "0",
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _showProductList(ProductsBloc productsBloc) {
    final oCcy = new NumberFormat("#,##0", "en_US");
    return FutureBuilder(
      future: productService.getAllProductsByCategory(widget.id),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();}
        else
          return new Center(
            child: new Column(
              children: <Widget>[
                new Flexible(
                    child: new GridView.builder(
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(new CupertinoPageRoute(
                                builder: (context) =>
                                new ItemDetail(
                                  itemId: snapshot.data[index].id,
                                  itemImage: snapshot.data[index].image,
                                  itemName: snapshot.data[index].name,
                                  itemPrice: snapshot.data[index].price,
                                  //itemRating: storeItems[index].itemRating,
                                  itemDescription: snapshot.data[index].description,
                                )));
                          },
                          child: new Card(
                            child: Stack(
                              alignment: FractionalOffset.topLeft,
                              children: <Widget>[
                                new Stack(
                                  alignment: FractionalOffset.bottomCenter,
                                  children: <Widget>[
                                    new Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: new NetworkImage(
                                                  snapshot.data[index].image[0]))),
                                    ),
                                    new Container(
                                      height: 55.0,
                                      color: Colors.black.withAlpha(100),
                                      child: new Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Row(
                                            //   children: [
                                            Text(
                                              "${snapshot.data[index].name}",
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            // ],),
                                            Row(
                                              children: [
                                                snapshot.data[index].price != null ?
                                                Text(
                                                  "${oCcy.format(snapshot.data[index]
                                                      .price)}đ" ?? 'Liên hệ',
                                                  style: new TextStyle(
                                                      color: Colors.red[500],
                                                      fontWeight: FontWeight
                                                          .w700),
                                                )
                                                    : Text(
                                                    'Liên hệ',
                                                    style: new TextStyle(
                                                        color: Colors.red[500],
                                                        fontWeight: FontWeight
                                                            .w700))

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    new Container(
                                      height: 30.0,
                                      width: 60.0,
                                      decoration: new BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: new BorderRadius.only(
                                            topRight: new Radius.circular(5.0),
                                            bottomRight: new Radius.circular(
                                                5.0),
                                          )),
                                      child: new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                            size: 20.0,
                                          ),
                                          new Text(
                                            "4",
                                            //"${products[index].rating}",
                                            style: new TextStyle(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    new IconButton(
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {})
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ))
              ],
            ),
          );
        },
    );
  }
}