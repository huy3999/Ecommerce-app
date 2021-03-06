import 'package:doan_cnpm/login_screen/Screens/Signup/signup_screen.dart';
import 'package:doan_cnpm/login_screen/components/already_have_an_account_acheck.dart';
import 'package:doan_cnpm/login_screen/components/rounded_button.dart';
import 'package:doan_cnpm/login_screen/components/rounded_input_field.dart';
import 'package:doan_cnpm/login_screen/components/rounded_password_field.dart';
import 'package:doan_cnpm/model/login_response.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/tools/app_tools.dart';
import 'package:doan_cnpm/user_screens/home_page.dart';
import 'package:doan_cnpm/user_screens/shipping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'background.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);
  ProductService productService = new ProductService();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                productService.getUserLogin(username, password).then((value) {
                  LoginResponse login = value;
                  print(login.accessToken);
                  if (login.accessToken != null) {
                    writeDataLocally(key: "user", value: login.accessToken);
                    getStringDataLocally(key: "user").then((value) {
                      productService.getUserInfo(value).then((xvalue) {
                        writeDataLocally(key: 'user_id',value: xvalue.sId);
                        if (xvalue.role == 'Shipping') {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ShippingPage();
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        }
                      });
                    });
                  } else {
                    final snackBar = SnackBar(
                        content: Text('Wrong username or password!!!'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
