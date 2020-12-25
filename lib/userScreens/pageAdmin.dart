import 'package:doan_cnpm/bloc/category_bloc.dart';
import 'package:doan_cnpm/bloc/product_bloc.dart';
import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/loginScreen/Screens/Welcome/welcome_screen.dart';
import 'package:doan_cnpm/model/category.dart';
import 'package:doan_cnpm/model/product.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/userScreens/loadMore.dart';
import 'package:doan_cnpm/userScreens/profile.dart';
import 'package:doan_cnpm/userScreens/shipping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'aboutUs.dart';
import 'orders.dart';
import 'favorites.dart';
import 'history.dart';
import 'itemdetails.dart';
import 'messages.dart';
import 'my_cart.dart';
import 'notifications.dart';

class PageAdmin extends StatefulWidget {
  @override
  _PageAdminState createState() => _PageAdminState();
}

class _PageAdminState extends State<PageAdmin> {
  BuildContext context;
  String acctName = "";
  String acctEmail = "";
  String acctPhotoURL = "";
  bool isLoggedIn;
  ProductService productService = new ProductService();
  final oCcy = new NumberFormat("#,##0", "en_US");
final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  // AppMethods appMethods = new FirebaseMethods();

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  Future getCurrentUser() async {
    acctName == null ? acctName = "Guest User" : acctName;
    acctEmail == null ? acctEmail = "guestUser@email.com" : acctEmail;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //this.context = context;
    //final productsBloc = Provider.productsBloc(context);
    final categoriesBloc = Provider.categoriesBloc(context);
    //final productsBloc = Provider.of(context).productsBloc;
    categoriesBloc.loadCategories();
    return new Scaffold(
      appBar: new AppBar(
        title: GestureDetector(
          child: new Text("E-commerce"),
        ),
        centerTitle: true,
        key: _scaffoldKey,
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
              // new CircleAvatar(
              //   radius: 8.0,
              //   backgroundColor: Colors.red,
              //   child: new Text(
              //     "0",
              //     style: new TextStyle(color: Colors.white, fontSize: 12.0),
              //   ),
              // )
            ],
          )
        ],
      ),
      body: _showCategoryList(categoriesBloc),
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
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(acctName),
              accountEmail: new Text(acctEmail),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Icon(Icons.person),
              ),
            ),
            // new ListTile(
            //   leading: new CircleAvatar(
            //     child: new Icon(
            //       Icons.notifications,
            //       color: Colors.white,
            //       size: 20.0,
            //     ),
            //   ),
            //   title: new Text("Order Notifications"),
            // ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: new Text("Orders"),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new OrderPage()));
                // Navigator.of(context).push(new CupertinoPageRoute(
                //     builder: (BuildContext context) => new OrderPage()));
              },
            ),
            // new Divider(),
            // new ListTile(
            //   leading: new CircleAvatar(
            //     child: new Icon(
            //       Icons.person,
            //       color: Colors.white,
            //       size: 20.0,
            //     ),
            //   ),
            //   title: new Text("Profile Settings"),
            //   onTap: () {
            //     Navigator.of(context).push(new CupertinoPageRoute(
            //         builder: (BuildContext context) => new GirliesProfile()));
            //   },
            // ),
            // new ListTile(
            //   leading: new CircleAvatar(
            //     child: new Icon(
            //       Icons.home,
            //       color: Colors.white,
            //       size: 20.0,
            //     ),
            //   ),
            //   title: new Text("Delivery Address"),
            //   onTap: () {
            //     Navigator.of(context).push(new CupertinoPageRoute(
            //         builder: (BuildContext context) =>
            //             new GirliesFavorities()));
            //   },
            // ),
            // new Divider(),
            // new ListTile(
            //   trailing: new CircleAvatar(
            //     child: new Icon(
            //       Icons.help,
            //       color: Colors.white,
            //       size: 20.0,
            //     ),
            //   ),
            //   title: new Text("About Us"),
            //   onTap: () {
            //     Navigator.of(context).push(new CupertinoPageRoute(
            //         builder: (BuildContext context) => new GirliesAboutUs()));
            //   },
            //   //
            // ),
            new ListTile(
              trailing: GestureDetector(
                onTap: () {
                  // _scaffoldKey.currentState.showSnackBar(
                  //     SnackBar(content: Text("Logging out...")));
                  clearDataLocally();
                  Navigator.of(context).pushReplacement(new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        new WelcomeScreen()));
                },
                child: new CircleAvatar(
                  child: new Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              title: new Text("Logout"),
              //onTap: checkIfLoggedIn,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showItemData(String id) {
    return FutureBuilder(
        future: productService.getProductsByCategory(id),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else
            return Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (context) => new ItemDetail(
                                  itemId: snapshot.data[index].id,
                                  itemImage: snapshot.data[index].image,
                                  itemName: snapshot.data[index].name,
                                  itemPrice: snapshot.data[index].price,
                                  itemDescription:
                                      snapshot.data[index].description,
                                )));
                      },
                      //children: <Widget>[
                      child: new Card(
                        child: Stack(
                          alignment: FractionalOffset.topLeft,
                          children: <Widget>[
                            // snapshot.data[index].image[0] == null
                            //     ? Center(child: CircularProgressIndicator())
                            //     :
                            new Stack(
                              alignment: FractionalOffset.bottomCenter,
                              children: <Widget>[
                                new Container(
                                  width: 200,
                                  height: 321,
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: new NetworkImage(
                                              snapshot.data[index].image[0]))),
                                ),
                                new Container(
                                  height: 55.0,
                                  width: 200,
                                  color: Colors.black,
                                  child: new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
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
                                            snapshot.data[index].price != null
                                                ? Text(
                                                    "${oCcy.format(snapshot.data[index].price)}đ" ??
                                                        'Liên hệ',
                                                    style: new TextStyle(
                                                        color: Colors.red[500],
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : Text('Liên hệ',
                                                    style: new TextStyle(
                                                        color: Colors.red[500],
                                                        fontWeight:
                                                            FontWeight.w700))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Container(
                                  height: 30.0,
                                  width: 60.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topRight: new Radius.circular(5.0),
                                        bottomRight: new Radius.circular(5.0),
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
                                        style:
                                            new TextStyle(color: Colors.white),
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
                      //],
                    );
                  }),
            );
        });
  }

  Widget _showCategoryList(CategoriesBloc categoriesBloc) {
    return StreamBuilder(
        stream: categoriesBloc.categoriesStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else
            return new Center(
              child: new Column(
                children: <Widget>[
                  new Flexible(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        child: Stack(
                            alignment: FractionalOffset.topLeft,
                            children: <Widget>[
                              new Container(
                                height: 321.0,
                                color: Colors.black.withAlpha(100),
                                child: new Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: new Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              new CupertinoPageRoute(
                                                  builder: (context) =>
                                                      new LoadMorePage(
                                                        id: snapshot
                                                            .data[index].Id,
                                                      )));
                                        },
                                        child: Text(
                                          "${snapshot.data[index].name}",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                      //Sub ListView
                                      _showItemData(snapshot.data[index].Id),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      );
                    },
                  ))
                ],
              ),
            );
        });
  }
}
