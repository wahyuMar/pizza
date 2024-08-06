import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              'assets/8.png',
              scale: 14,
            ),
            const SizedBox(width: 8),
            const Text(
              'Pizza Delivery',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){},
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: (){
              context.read<SignInBloc>().add(SignOutRequired());
            },
          ),
        ],
      ),
    );
  }
}