import 'package:doan_cnpm/bloc/provider.dart';
import 'package:doan_cnpm/loginScreen/Screens/Login/login_screen.dart';
import 'package:doan_cnpm/loginScreen/Screens/Welcome/welcome_screen.dart';
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
         home: new WelcomeScreen(),
    ));
  }
}
