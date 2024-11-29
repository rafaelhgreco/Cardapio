import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_card.dart';
import 'package:cardapio/pages/pedido/delivery_info_dialog.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Limpar carrinho'),
                content: const Text('Deseja remover todos os itens do carrinho?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('NÃO'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).clearCart();
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('SIM'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.delete_outline),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items[index];
                    return CartItemCard(
                      cartItem: cartItem,
                      onIncrease: () => cart.increaseQuantity(cartItem.product.id),
                      onDecrease: () => cart.decreaseQuantity(cartItem.product.id),
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
                      'Total: R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () {
                        // Converter CartItem para Product
                        List<Product> cartProducts = cart.items
                            .map((cartItem) => cartItem.product)
                            .toList();

                        showDialog(
                          context: context,
                          builder: (context) => DeliveryInfoDialog(
                            cartItems: cartProducts,
                            totalPrice: cart.totalAmount,
                          ),
                        );
                      },
                      child: const Text('Finalizar Pedido'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}