import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About Us"),
        centerTitle: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Image.asset('assets/images/anh1.jpg'),
            ),
            Expanded(
              child: Image.asset('assets/images/anh2.jpg'),
            ),
            Expanded(
              child: Image.asset('assets/images/anh3.jpg'),
            ),
            Expanded(
                child: Image.asset('assets/images/anh4.jpg'),
            ),
            Expanded(
              child: Image.asset('assets/images/anh5.jpg'),
            ),
          ],
        ),
      ),

    );
  }
}
