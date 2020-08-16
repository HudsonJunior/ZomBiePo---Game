import 'dart:core';
import 'dart:math';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jokenpo_game/controller/GameController.dart';
import 'package:soundpool/soundpool.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ad_manager.dart';

class GamePage extends StatefulWidget {
  final String namePlayer;

  GamePage(this.namePlayer);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  BannerAd _bannerAd;

  final gameController = GameController();

  @override
  void initState() {
    super.initState();
    gameController.fToast = FToast(context);

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

  static Soundpool pool = Soundpool(streamType: StreamType.notification);

  Future<int> soundId =
      rootBundle.load("alex_play.mp3").then((ByteData soundData) {
    return pool.load(soundData);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("assets/images/background.jpg").image,
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 40, top: 50),
                          child: Text(
                            widget.namePlayer,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 40, top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.transparent,
                        ),
                        child: Text(gameController.scorePlayer.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 40, top: 50),
                          child: Text(
                            'ZUMBIS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 40, top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.transparent,
                        ),
                        child: Text(gameController.scoreBot.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset(gameController.imagePlayer,
                        width: 110, height: 110, alignment: Alignment.center),
                    decoration: BoxDecoration(),
                  ),
                  Container(
                    child: Image.asset('assets/images/vs.png',
                        width: 110, height: 110, alignment: Alignment.center),
                  ),
                  Container(
                      child: Image.asset(
                    gameController.imageBot,
                    width: 110,
                    height: 110,
                    alignment: Alignment.center,
                  ))
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _gestureImage(gameController.pedra),
                      _gestureImage(gameController.papel),
                      _gestureImage(gameController.tesoura)
                    ],
                  ),
                ),
              ),
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

  Widget _gestureImage(String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          gameController.jogar(image);
          gameController.verificaJogada();
        });
      },
      child: Image.asset(image),
    );
  }
}
