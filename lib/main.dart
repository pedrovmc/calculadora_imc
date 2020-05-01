import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _resposta = "Insira seus dados!";
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();

  void _resetar() {
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      _resposta = "Insira seus dados!";
    });
  }

  void _calcular() {
    setState(() {
      double _kg = double.parse(controllerPeso.text);
      double _m = double.parse(controllerAltura.text) / 100;
      double _imc = _kg / (_m * _m);
      if (_imc < 18.6) {
        _resposta = "Abaixo do Peso (IMC=${_imc.toStringAsPrecision(3)})";
      }else if(_imc>=18.6 && _imc< 24.9){
        _resposta = "Peso Ideal (IMC=${_imc.toStringAsPrecision(3)})";
      }else if(_imc>=24.9 && _imc< 29.9){
        _resposta = "Levemente Acima do Peso (IMC=${_imc.toStringAsPrecision(3)})";
      }else if(_imc>=29.9 && _imc< 34.9){
        _resposta = "Obesidade Grau I (IMC=${_imc.toStringAsPrecision(3)})";
      }else if(_imc>=34.9 && _imc< 39.9){
        _resposta = "Obesidade Grau II (IMC=${_imc.toStringAsPrecision(3)})";
      }else if(_imc>=40){
        _resposta = "Obesidade Grau III (IMC=${_imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetar,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10.00, right: 10.00),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.00,
                  color: Colors.orange,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.orange)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.00),
                  controller: controllerPeso,
                  validator: (valor){
                    if (valor.isEmpty){
                      return "Insira Seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.orange)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.00),
                  controller: controllerAltura,
                  validator: (valor){
                    if(valor.isEmpty){
                      return "Insira Sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.00, bottom: 10.00),
                  child: Container(
                    height: 50.00,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formkey.currentState.validate()){
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.orange,
                    ),
                  ),
                ),
                Text(
                  _resposta,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                )
              ],
            ),
          )
        ));
  }
}
