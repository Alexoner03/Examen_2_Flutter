import 'package:flutter/material.dart';

class MenuOffice extends StatefulWidget {
  MenuOffice({Key key}) : super(key: key);

  @override
  _MenuOfficeState createState() => _MenuOfficeState();
}

class _MenuOfficeState extends State<MenuOffice> {
  String _nombre = '';
  String _pedido = '';
  double _precio = 0;
  int _cantidad = 0;
  double _total = 0;
  double _descuento = 0;
  bool _enabledDElivery = false;

  TextEditingController _textTotalController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Food'),
        backgroundColor: Colors.amber[600],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
          children: <Widget>[
            Text(
                'Bienvenido por favor complete sus datos para completar su pedido',
                style: TextStyle(fontSize: 25)),
            Column(
              children: [
                _inputNombre(),
                Divider(),
                _inputPedido(),
                Divider(),
                _inputPrecio(),
                Divider(),
                _inputCantidad(),
                Divider(),
                _labelResultado(),
                Divider(),
                _switchDelivery()
              ],
            ),
            _inputTotal(),
            _btnCalcular()
          ]
      ),
    );
  }

  Widget _inputNombre() {
    return TextField(
      decoration: InputDecoration(labelText: 'Nombre'),
      onChanged: (value) {
        setState(() {
          _nombre = value;
        });
      },
    );
  }

  Widget _inputPedido() {
    return TextField(
      decoration: InputDecoration(labelText: 'Pedido'),
      onChanged: (value) {
        setState(() {
          _pedido = value;
        });
      },
    );
  }

  Widget _inputPrecio() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onChanged: (value) {
        setState(() {
          _precio = double.parse(value);
        });
      },
    );
  }

  Widget _inputCantidad() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Cantidad',
      ),
      onChanged: (value) {
        setState(() {
          _cantidad = int.parse(value);
        });
      },
    );
  }

  Widget _labelResultado() {
    return Text('Total : $_total -- Descuento : $_descuento');
  }

  Widget _switchDelivery() {
    return SwitchListTile(
      title: Text('Delivery'),
      activeColor: Colors.green,
      value: _enabledDElivery,
      onChanged: (valor) {
        setState(() {
          _enabledDElivery = valor;
        });
      },
    );
  }

  Widget _inputTotal() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: _textTotalController,
      decoration: InputDecoration(
        labelText: 'Total a Pagar',
      ),
    );
  }

  Widget _btnCalcular() {
    return FlatButton(
      child: Text('CALCULAR'),
      color: Colors.amber,
      textColor: Colors.white,
      onPressed: (){
        _calcular();
      },
    );
  }

  _calcular() {
    setState(() {
      if (_nombre != '' && _pedido != '' && _precio > 0 && _cantidad > 0) {
        _total = _precio * _cantidad;
        if (_total > 500) {
          _descuento = _total * 0.05;
        } else {
          _descuento = 0;
        }

        
        if(_enabledDElivery){
          _textTotalController.text = (_total + 20 - _descuento).toString();
        }else{
          _textTotalController.text = (_total - _descuento).toString();
        }

      } else {
        _textTotalController.text = '';
      }
    });
  }
}
