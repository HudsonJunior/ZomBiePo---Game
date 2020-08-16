import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ad_manager.dart';
import 'GamePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  BannerAd _bannerAd;


  @override
  void initState() {
    super.initState();

    _initAdMob().then((value) {
      _bannerAd = BannerAd(
        adUnitId: AdManager.bannerAdUnitId,
        size: AdSize.banner,
      );

      // TODO: Load a Banner Ad
      _loadBannerAd();
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image
                    .asset("assets/images/background.jpg")
                    .image,
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
                    return value.length == 0 ? "Digite um nome válido!" : null;
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
                        builder: (context) => GamePage(nome.toUpperCase()),
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
  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  Future<void> _initAdMob() {
    // TODO: Initialize AdMob SDK
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }
}
