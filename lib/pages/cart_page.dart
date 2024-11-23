import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Simulando itens no carrinho (posteriormente, isso virá de um gerenciador de estado)
  List<CartItem> cartItems = [];

  double get totalCart {
    return cartItems.fold(0, (sum, item) => sum + item.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
              child: Text(
                'Seu carrinho está vazio',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItemCard(
                  cartItem: cartItems[index],
                  onIncrease: () {
                    setState(() {
                      cartItems[index].quantity++;
                    });
                  },
                  onDecrease: () {
                    setState(() {
                      if (cartItems[index].quantity > 1) {
                        cartItems[index].quantity--;
                      } else {
                        cartItems.removeAt(index);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: R\$ ${totalCart.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                    // Implementar finalização do pedido
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pedido finalizado com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Finalizar Pedido'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}