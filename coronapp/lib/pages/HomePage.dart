import 'dart:convert';
import 'package:coronapp/models/news.dart';
import 'package:coronapp/utils/date_utils.dart';
import 'package:coronapp/widgets/NewsItem.dart';
import 'package:coronapp/widgets/imagecheckbox.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:coronapp/models/user.dart';
import 'package:coronapp/models/symptom.dart';

class HomePage extends StatefulWidget {
  final User user;
  static final from = DateUtils.dateToString(DateTime.now());
  static final to = DateUtils.dateToString(DateTime.now());
  String newsUrl =
      'http://newsapi.org/v2/everything?q=coronavirus&language=pt&from=$from&to=$to&apiKey=96151502a3d2498399c93fcca45593c4';

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexTab = 0;

  var newsData;
  List articles;
  List<News> news;
  bool _check = false;
  List<Symptom> symptoms;
  Map<Symptom, bool> selectedSymptoms = new Map();
  var refreshNews = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    refreshNews.currentState.show();

    var response = await http.get(
      Uri.encodeFull(widget.newsUrl),
      headers: {"Accept": "application/json"},
    );

    var symptomsAsset = await DefaultAssetBundle.of(context)
        .loadString("assets/data/symptoms.json");
    var symptomsList = json.decode(symptomsAsset) as List;

    this.setState(() {
      newsData = jsonDecode(response.body);
      articles = newsData["articles"] as List;
      news = articles.map<News>((json) => News.fromJson(json)).toList();
      symptoms =
          symptomsList.map<Symptom>((json) => Symptom.fromJson(json)).toList();
    });

    return "OK";
  }

  void onSelectedSymptom(String description, bool value) {
    int index = symptoms.indexWhere((sym) => sym.name == description);
    selectedSymptoms.update(symptoms[index], (vlr) => value,
        ifAbsent: () => value);
  }

  Widget _getBody() {
    switch (_indexTab) {
      case 0:
        return RefreshIndicator(
          key: refreshNews,
          child: ListView.builder(
              itemCount: news == null ? 0 : news.length,
              itemBuilder: (BuildContext context, int index) {
                News notice = news[index];
                return NewsItem(notice);
              }),
          onRefresh: getData,
        );
        break;
      case 1:
        return Column(
          children: <Widget>[
            Text(
              "Marque o que você está sentindo",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: symptoms == null ? 0 : symptoms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ImageCheckBox(
                      value: _check,
                      onChanged: (bool val) {
                        setState(() {
                          _check = val;
                        });
                      },
                      onSelectedSymptom: onSelectedSymptom,
                      checkDescription: "${symptoms[index].name}",
                    );
                  }),
            ),
            RaisedButton(
              onPressed: () {
                int result = 0;
                String descricao = "";

                for (var item in selectedSymptoms.entries) {
                  if(item.value) {
                    result+=item.key.weight;
                  }
                }

                if(result < 30) {
                  descricao = "Pouca chance de ter corona!";
                } else if(result < 60) {
                  descricao = "Chance média de ter corona!";
                } else {
                  descricao = "Grande chance de ter corona!";
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('RESULTADO DO TESTE'),
                      content: Text(descricao),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    );
                  },
                );
              },
              child: Text("Testar"),
            )
          ],
        );
        break;
      case 2:
        return Container(
          height: 200,
          color: Colors.green,
        );
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notícias do dia"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundImage: MemoryImage(base64.decode(widget.user.photo)),
              ),
              accountName: Text(widget.user.name.toUpperCase()),
              accountEmail: Text(widget.user.email),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Item de menu 1'),
              subtitle: Text('Subtítulo 1'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('Clicou no menu 1');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Item de menu 1'),
              subtitle: Text('Subtítulo 1'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('Clicou no menu 2');
              },
            ),
          ],
        ),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _indexTab,
        onTap: (int idx) => setState(() {
          _indexTab = idx;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            title: Text(
              'Notícias',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility,
              color: Colors.white,
            ),
            title: Text(
              'Teste Rápido',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            title: Text(
              'Sobre',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
