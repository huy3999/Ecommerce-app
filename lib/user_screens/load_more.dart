import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/user_screens/item_details.dart';
import 'my_cart.dart';
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
          return Center(child: CircularProgressIndicator());}
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