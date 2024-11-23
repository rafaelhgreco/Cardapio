import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
    // Adicione mais produtos conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onAddToCart: () {
              // Adicionar ao carrinho (implementar posteriormente)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${products[index].name} adicionado ao carrinho!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
}