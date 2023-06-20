import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:app_lista_produtos/pages/login.dart';
import 'package:app_lista_produtos/pages/novo_produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProdutoProvider()),
        ChangeNotifierProvider(create: (context) => UsuarioProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: const ListaProdutos(),
    );
  }
}
