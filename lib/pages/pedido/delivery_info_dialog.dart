import 'package:flutter/material.dart';
import 'package:cardapio/models/pedido.dart';
import 'package:cardapio/models/product.dart';
import 'package:cardapio/pages/pedido/pedido_confirmacao_page.dart';

class DeliveryInfoDialog extends StatefulWidget {
  final List<Product> cartItems;
  final double totalPrice;

  const DeliveryInfoDialog({
    Key? key,
    required this.cartItems,
    required this.totalPrice
  }) : super(key: key);

  @override
  _DeliveryInfoDialogState createState() => _DeliveryInfoDialogState();
}

class _DeliveryInfoDialogState extends State<DeliveryInfoDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Informações de Entrega',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu endereço';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _complementoController,
                decoration: InputDecoration(
                  labelText: 'Complemento (Opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Criar objeto de pedido
                    Pedido novoPedido = Pedido(
                      id: DateTime.now().toString(), // ID único
                      nome: _nomeController.text,
                      endereco: _enderecoController.text,
                      complemento: _complementoController.text,
                      itens: widget.cartItems,
                      total: widget.totalPrice,
                      status: 'Em Andamento',
                      data: DateTime.now(),
                    );

                    // Navegar para a página de confirmação
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PedidoConfirmacaoPage(pedido: novoPedido),
                      ),
                    );
                  }
                },
                child: Text('Finalizar Compra'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}