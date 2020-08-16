import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    return value.length == 0
                        ? "Digite um nome válido!"
                        : null;
                  },
                  maxLength: 12,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Entre com seu nome",
                      labelStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder()),
                  controller: _textEditingController,
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  String nome = _textEditingController.text.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(nome),
                      ));
                }
              },
              color: Colors.brown,
              child: Text('JOGAR'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
