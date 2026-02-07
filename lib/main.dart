import 'package:flutter/material.dart';
import 'package:mini_shop/cart_screen.dart';
import 'package:mini_shop/home_screen.dart' show HomeScreen;
import 'package:mini_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
