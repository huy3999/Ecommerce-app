import 'package:doan_cnpm/login_screen/Screens/Login/login_screen.dart';
import 'package:doan_cnpm/login_screen/Screens/Signup/components/social_icon.dart';
import 'package:doan_cnpm/login_screen/components/already_have_an_account_acheck.dart';
import 'package:doan_cnpm/login_screen/components/round_name.dart';
import 'package:doan_cnpm/login_screen/components/rounded_button.dart';
import 'package:doan_cnpm/login_screen/components/rounded_input_field.dart';
import 'package:doan_cnpm/login_screen/components/rounded_password_field.dart';
import 'package:doan_cnpm/model/sign_up.dart';
import 'package:doan_cnpm/services/product_service.dart';
import 'package:doan_cnpm/user_screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'background.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  ProductService productService = new ProductService();
  bool isRegister = false;
  String yourEmail;
  String password;
  String name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedName(
              hintText: "Your Name",
              onChanged: (value) {name = value;},
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {yourEmail = value;},
            ),
            RoundedPasswordField(
              onChanged: (value) {password = value;},
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                SignUpModel signup = new SignUpModel(
                  name: name,
                  username: yourEmail,
                  password: password
                );
                productService.SignUpUser(signup).then((value) {
                  if (value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                  }else
                    {
                      final snackBar = SnackBar(content: Text('Invalid Sign Up !!!'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
