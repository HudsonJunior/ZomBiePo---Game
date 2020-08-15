import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("assets/images/background.jpg").image,
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            TextField(
              decoration: InputDecoration(
                 labelText: "Seu nome aqui",
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder()),
              controller: _textEditingController,
              //textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
