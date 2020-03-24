import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Calculadora());

class Calculadora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeCalculadora(),
    );
  }
}

class HomeCalculadora extends StatefulWidget {
  @override
  _HomeCalculadoraState createState() => _HomeCalculadoraState();
}

class _HomeCalculadoraState extends State<HomeCalculadora> {
  int _operacao = -1;
  int _resultado = -1;

  //controladores dos inputs
  final _numeroControllerUm = TextEditingController();
  final _numeroControllerDois = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void calcularSoma() {
    int valueTextFieldUm = int.tryParse(_numeroControllerUm.text);
    int valueTextFieldDois = int.tryParse(_numeroControllerDois.text);

    if (_operacao == 0) {
      _resultado = valueTextFieldUm + valueTextFieldDois;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Calculadora'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Digitar o primeiro número',
                prefixIcon: Icon(Icons.looks_one),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: _numeroControllerUm,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Digitar o segundo número',
                prefixIcon: Icon(Icons.looks_two),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: _numeroControllerDois,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Somar'),
                Radio(
                  value: 0,
                  groupValue: _operacao,
                  onChanged: (int value) {
                    setState(() {
                      _operacao = value;
                    });
                  },
                ),
              ],
            ),
            Divider(),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Colors.deepOrange[200],
                  child: Text('Calcular Dialog'),
                  onPressed: () {
                    calcularSoma();

                    showDialog(
                      context: _scaffoldKey.currentState.context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Resultado'),
                          content: Text('$_resultado'),
                        );
                      },
                    );
                  },
                ),
                RaisedButton(
                  color: Colors.deepOrange[200],
                  child: Text('Calcular Snack'),
                  onPressed: () {
                    calcularSoma();

                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('$_resultado'),
                        backgroundColor: Colors.deepOrange[200],
                      ),
                    );
                  },
                ),
              ],
              alignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
