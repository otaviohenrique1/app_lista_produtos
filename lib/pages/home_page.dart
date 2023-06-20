import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListaProdutos()),
                );
              },
              fontColor: Colors.white,
              label: "Lista",
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {},
              fontColor: Colors.white,
              label: "Busca",
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {},
              fontColor: Colors.white,
              label: "Perfil",
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {},
              fontColor: Colors.white,
              label: "Sair",
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}
