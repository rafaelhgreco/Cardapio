import 'package:flutter/material.dart';
import 'package:animations/animations.dart'; // Importação do pacote de animações
import '../widgets/custom_button.dart';
import 'cart_page.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToCartPage(BuildContext context) async {
    _controller.forward();
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CartPage(),
        transitionsBuilder: (_, animation, __, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: __,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
      ),
    );
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lanchonete da Beth',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 500, // Aumentado para acomodar a logo
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Adiciona espaço para a logo
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 200, // Altura da logo
                width: 200, // Largura da logo
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo.png'), // Caminho da logo
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              // Texto de boas-vindas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Bem-vindo ao nosso Cardápio Digital!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              OpenContainer(
                transitionType: ContainerTransitionType.fade,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                closedBuilder: (context, action) => CustomButton(
                  text: 'Ver Cardápio',
                  onPressed: action,
                ),
                openBuilder: (context, action) => MenuPage(),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Carrinho',
                onPressed: () => _navigateToCartPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
