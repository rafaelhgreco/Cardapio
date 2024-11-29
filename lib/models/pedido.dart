import '../models/product.dart'; // Importe o modelo de Product se necessário

class Pedido {
  final String id;
  final String nome;
  final String endereco;
  final String complemento;
  final List<Product> itens;
  final double total;
  final String status;
  final DateTime data;

  Pedido({
    required this.id,
    required this.nome,
    required this.endereco,
    this.complemento = '', // Torna o complemento opcional
    required this.itens,
    required this.total,
    required this.status,
    required this.data,
  });
}