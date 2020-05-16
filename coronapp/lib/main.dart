import 'package:coronapp/pages/HomePage.dart';
import 'package:coronapp/pages/LoginPage.dart';
import 'package:coronapp/pages/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internationalization/internationalization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Internationalization.loadConfigurations();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(CoronApp());
  });
}

class CoronApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: true,
      title: 'CoronApp',
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.purple),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => LoginPage(),
        '/HomePage': (BuildContext context) => HomePage(),
        '/SplashPage': (BuildContext context) => SplashPage()
      },
      supportedLocales: suportedLocales,
      localizationsDelegates: [
        Internationalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
//Your API key is: 96151502a3d2498399c93fcca45593c4
