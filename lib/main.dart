import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/loginScreen/Screens/Login/login_screen.dart';
import 'package:doan_cnpm/loginScreen/Screens/Welcome/welcome_screen.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/userScreens/pageAdmin.dart';
import 'package:flutter/material.dart';
import 'loginScreen/constants.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
          title: 'ECA',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
      ),
         home: FutureBuilder( 
          future: getStringDataLocally(key: "user"),
          // wait for the future to resolve and render the appropriate
          // widget for HomePage or LoginPage
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return (snapshot.data == null) ? WelcomeScreen() : PageAdmin();
            } else {
              return Container(color: Colors.white);
            }
          },
        ),
    ));
  }
}
