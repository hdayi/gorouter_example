import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () => context.goNamed('detail', params: {'id': '5'}),
            child: const Text("other Page")),
      ),
    );
  }
}
