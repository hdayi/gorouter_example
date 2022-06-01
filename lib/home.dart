import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text("Home Page"),
          ),
          ElevatedButton(
            onPressed: () => context.goNamed('other'),
            child: const Text("Go to Other Page"),
          ),
        ],
      ),
    );
  }
}
