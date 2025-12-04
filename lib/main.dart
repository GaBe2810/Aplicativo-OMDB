import 'package:flutter/material.dart';
import 'telas/pagina_pesquisa.dart';

void main() {
  runApp(const FilmeApp());
}

class FilmeApp extends StatelessWidget {
  const FilmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BuscaPagina(),
    );
  }
}
