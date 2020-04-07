import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexTab = 0;

  Widget _getBody() {
    switch (_indexTab) {
      case 0:
        return Container(
          height: 200,
          color: Theme.of(context).primaryColor,
        );
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
                backgroundImage: AssetImage('assets/images/bitmoji.png'),
              ),
              accountName: Text('CoronaApp'),
              accountEmail: Text('coronapp@mail.com'),
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
