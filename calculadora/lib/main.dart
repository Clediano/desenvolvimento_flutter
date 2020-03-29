import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './operadores.dart';

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
  Operador _operacao = Operador.SOMAR;
  double _resultado = -1;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //controladores dos inputs
  final _numeroControllerUm = TextEditingController();
  final _numeroControllerDois = TextEditingController();

  void calcular() {
    double valueTextFieldUm = double.tryParse(_numeroControllerUm.text);
    double valueTextFieldDois = double.tryParse(_numeroControllerDois.text);

    validarValores(valueTextFieldUm, valueTextFieldDois);

    double resultadoOperacaoExecutada = 0.0;

    switch (_operacao) {
      case Operador.SOMAR:
        resultadoOperacaoExecutada = (valueTextFieldUm + valueTextFieldDois);
        break;
      case Operador.MULTIPLICAR:
        resultadoOperacaoExecutada = (valueTextFieldUm * valueTextFieldDois);
        break;
      case Operador.DIVIDIR:
        resultadoOperacaoExecutada = (valueTextFieldUm / valueTextFieldDois);
        break;
      case Operador.SUBTRAIR:
        resultadoOperacaoExecutada = (valueTextFieldUm - valueTextFieldDois);
        break;
      default:
    }
    setState(() {
      _resultado = resultadoOperacaoExecutada;
    });
  }

  validarValores(double valorUm, double valorDois) {
    if (valorUm == null && valorDois == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Valores inválidos ou não informados. Verifique!'),
          backgroundColor: Colors.red,
        ),
      );
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
        body: ListView(
          children: <Widget>[
            Padding(
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
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
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
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    controller: _numeroControllerDois,
                  ),
                  Divider(),
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Somar'),
                        leading: Radio(
                          value: Operador.SOMAR,
                          groupValue: _operacao,
                          onChanged: (Operador value) {
                            setState(() {
                              _operacao = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Dividir'),
                        leading: Radio(
                          value: Operador.DIVIDIR,
                          groupValue: _operacao,
                          onChanged: (Operador value) {
                            setState(() {
                              _operacao = value;
                            });
                          },
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Multiplicar'),
                            leading: Radio(
                              value: Operador.MULTIPLICAR,
                              groupValue: _operacao,
                              onChanged: (Operador value) {
                                setState(() {
                                  _operacao = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Subtrair'),
                            leading: Radio(
                              value: Operador.SUBTRAIR,
                              groupValue: _operacao,
                              onChanged: (Operador value) {
                                setState(() {
                                  _operacao = value;
                                });
                              },
                            ),
                          ),
                        ],
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
                          calcular();
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
                          calcular();
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
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.deepOrange[200],
                        child: Text('Calcular Dialog'),
                        onPressed: () {
                          calcular();
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
                      IconButton(
                        color: Colors.deepOrange[200],
                        icon: Icon(Icons.done),
                        tooltip: "AYUSDGYUASD",
                        onPressed: () {
                          calcular();
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
                  Image.asset('images/bitmoji.png')
                ],
              ),
            ),
          ],
        ));
  }
}
