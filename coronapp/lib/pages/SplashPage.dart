import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void navegarTelaLogin() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

  iniciarSplash() async {
    var _duracao = new Duration(seconds: 3);

    return new Timer(_duracao, navegarTelaLogin);
  }

  @override
  void initState() {
    super.initState();
    iniciarSplash();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Container(
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Image.asset('assets/images/splash.png')],
      ),
    );
  }
}
