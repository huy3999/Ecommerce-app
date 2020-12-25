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
      body: new Center(
          child: Row(
            children: [
              Image.asset('assets/images/anh1.png', width: 200, height: 100,),
              Image.asset('assets/images/anh2.png', width: 50, height: 50,),

            ],
          ),
        ),

    );
  }
}
