import 'dart:core';
import 'dart:math';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:soundpool/soundpool.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ad_manager.dart';

class GamePage extends StatefulWidget {
  final String namePlayer;

  GamePage(this.namePlayer);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _pedra = "assets/images/pedra.png";
  final _papel = 'assets/images/papel.png';
  final _tesoura = 'assets/images/tesoura.png';

  final _pedraZombie = "assets/images/pedraZombie.png";
  final _papelZombie = "assets/images/papelZombie.png";
  final _tesouraZombie = "assets/images/tesouraZombie.png";

  var playerJogada = 0;
  var zombieJogada = 0;

  Random random = new Random(10);

  var imagePlayer = 'assets/images/imagePlayer.png';
  var imageBot = 'assets/images/imageZombie.png';

  BannerAd _bannerAd;

  var scorePlayer = 0;
  var scoreBot = 0;

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);

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
                        child: Text(scorePlayer.toString(),
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
                            'Zumbis',
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
                        child: Text(scoreBot.toString(),
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
                    child: Image.asset(imagePlayer,
                        width: 110, height: 110, alignment: Alignment.center),
                    decoration: BoxDecoration(),
                  ),
                  Container(
                    child: Image.asset('assets/images/vs.png',
                        width: 110, height: 110, alignment: Alignment.center),
                  ),
                  Container(
                      child: Image.asset(
                    imageBot,
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
                      _gestureImage(_pedra),
                      _gestureImage(_papel),
                      _gestureImage(_tesoura)
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
        _jogar(image);
        verificaJogada();
      },
      child: Image.asset(image),
    );
  }

  _jogar(String jogada) {
    setState(() {
      if (jogada == _papel) {
        playerJogada = 2;
      } else if (jogada == _pedra) {
        playerJogada = 1;
      } else {
        playerJogada = 3;
      }

      imagePlayer = jogada;
      imageBot = jogadaBot();
    });
  }

  _showToast(String message, IconData icon, Color color) {
    fToast.removeQueuedCustomToasts();
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 10.0,
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void verificaJogada() {
    Color color = Colors.brown;
    IconData icon = Icons.check_circle;
    String message = "";
    if (playerJogada == zombieJogada) {
      message = "EMPATE!";
      color = Colors.brown;
      icon = Icons.error;
    } else if ((playerJogada == 2 && zombieJogada == 1) ||
        (playerJogada == 3 && zombieJogada == 2) ||
        (playerJogada == 1 && zombieJogada == 3)) {
      message = "GANHOU!";
      setState(() {
        scorePlayer += 1;
      });
    } else {
      message = "PERDEU!";
      icon = Icons.cancel;
      color = Colors.brown;
      setState(() {
        scoreBot += 1;
      });
    }
    _showToast(message, icon, color);
  }

  String jogadaBot() {
    int index = random.nextInt(3);

    switch (index) {
      case 1:
        zombieJogada = 2;
        return _papelZombie;
        break;
      case 2:
        zombieJogada = 3;
        return _tesouraZombie;
        break;
      default:
        zombieJogada = 1;
        return _pedraZombie;
    }
  }
}
