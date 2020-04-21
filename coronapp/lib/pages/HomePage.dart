import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:coronapp/models/user.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexTab = 0;

  List newsData;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("http://www.mocky.io/v2/5e9e2d0034000060b56eebf6"),
      headers: {"Accept": "application/json"},
    );
    this.setState(() {
      newsData = jsonDecode(response.body);
    });
    return "OK";
  }

  Widget _getBody() {
    switch (_indexTab) {
      case 0:
        return ListView.builder(
            itemCount: newsData == null ? 0 : newsData.length,
            itemBuilder: (BuildContext context, int index) {
              var data = newsData[index];
              return Card(
                child: Text("${data["title"]} - ${data["body"]}"),
              );
            });
        break;
      case 1:
        return Container(
          height: 200,
          color: Theme.of(context).accentColor,
        );
        break;
      case 2:
        return Container(
          height: 200,
          color: Colors.green,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
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
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility,
              color: Colors.white,
            ),
            title: Text(
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            title: Text(
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
