import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adicionando a imagem do produto
          _ProductImage(assetPath: product.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductName(name: product.name),
                const SizedBox(height: 8),
                _ProductDescription(description: product.description),
                const SizedBox(height: 8),
                _ProductFooter(
                  price: product.price,
                  onAddToCart: onAddToCart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String assetPath;

  const _ProductImage({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 200,
          color: Colors.grey[200],
          child: const Icon(
            Icons.broken_image,
            size: 64,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  final String name;

  const _ProductName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final String description;

  const _ProductDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        color: Colors.grey[600],
      ),
    );
  }
}

class _ProductFooter extends StatelessWidget {
  final double price;
  final VoidCallback onAddToCart;

  const _ProductFooter({
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'R\$ ${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onAddToCart,
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Adicionar'),
        ),
      ],
    );
  }
}
