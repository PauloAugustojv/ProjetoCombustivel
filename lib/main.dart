import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(), // rota de entrada da aplicação
    debugShowCheckedModeBanner: false, // romeve o símbolo Debug
  ));
}

class Home extends StatefulWidget {
//@override
  _HomeState createState() => _HomeState();
}

//classe que controla os estados da aplicação
class _HomeState extends State<Home> {
// definindo os nossso objetos
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = ''; // aqui vamos dizer o que deve ser feito

  //Variável para controlar o formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// Vamos criar a lógica da aplicação (métodos)
  void _reset() {
    //print('funcionado');
    setState(() {
      alcoolController.text = '';
      gasolinaController.text = '';
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaCombustivelIdeal() {
    setState(() {
      //não pode esquecer de colocar o setState() dentro de
      //um método que tenha ação de interatividade

      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = varAlcool / varGasolina;
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

// construtos da classe
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gasolina ou Álcool',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        // cria o botão de reset
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _reset();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
        child: Form(
          key: _formKey, // é a referência do formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // <--alargar-->
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 70,
                color: Colors.amberAccent[900],
              ),
              TextFormField(
                //campo do nosso formulário
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor do Álcool' : null,
                decoration: InputDecoration(
                  labelText: 'Valor do Alcool',
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 20.0),
              ),
              TextFormField(
                //campo do nosso formulário
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor da Gasolina' : null,
                decoration: InputDecoration(
                  labelText: 'Valor da Gasolina',
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculaCombustivelIdeal();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    fillColor: Colors.lightBlue[900],
                  ),
                ),
              ),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 30.0)),
            ],
          ),
        ),
      ),
    );
  }
}
