import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameController {
  final pedra = "assets/images/pedra.png";
  final papel = 'assets/images/papel.png';
  final tesoura = 'assets/images/tesoura.png';

  final pedraZombie = "assets/images/pedraZombie.png";
  final papelZombie = "assets/images/papelZombie.png";
  final tesouraZombie = "assets/images/tesouraZombie.png";

  var playerJogada = 0;
  var zombieJogada = 0;

  Random random = new Random(10);

  var scorePlayer = 0;
  var scoreBot = 0;

  FToast fToast;

  var imagePlayer = 'assets/images/imagePlayer.png';
  var imageBot = 'assets/images/imageZombie.png';

  jogar(String jogada) {
    if (jogada == papel) {
      playerJogada = 2;
    } else if (jogada == pedra) {
      playerJogada = 1;
    } else {
      playerJogada = 3;
    }

    imagePlayer = jogada;
    imageBot = jogadaBot();
  }

  showToast(String message, IconData icon, Color color) {
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
        scorePlayer += 1;
    } else {
      message = "PERDEU!";
      icon = Icons.cancel;
      color = Colors.brown;
        scoreBot += 1;
    }
    showToast(message, icon, color);
  }

  String jogadaBot() {
    int index = random.nextInt(3);

    switch (index) {
      case 1:
        zombieJogada = 2;
        return papelZombie;
        break;
      case 2:
        zombieJogada = 3;
        return tesouraZombie;
        break;
      default:
        zombieJogada = 1;
        return pedraZombie;
    }
  }
}
