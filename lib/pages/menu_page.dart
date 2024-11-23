import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';



class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final List<Product> products = [
    Product(
      id: '1',
      name: 'X-Burger',
      price: 25.90,
      description: 'Hambúrguer artesanal com queijo, alface e tomate',
      imageUrl: 'assets/burger.png',
    ),
    Product(
      id: '2',
      name: 'Pizza Margherita',
      price: 45.90,
      description: 'Pizza com molho de tomate, mussarela e manjericão',
      imageUrl: 'assets/pizza.png',
    ),
    Product(
      id: '3',
      name: 'Batata Frita',
      price: 15.90,
      description: 'Porção de batatas fritas crocantes',
      imageUrl: 'assets/fries.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              child: const Icon(Icons.shopping_cart),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Consumer<CartProvider>(
                builder: (context, cart, child) => cart.itemCount > 0
                    ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${cart.itemCount}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onAddToCart: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addItem(products[index]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${products[index].name} adicionado ao carrinho!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeItem(products[index].id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}