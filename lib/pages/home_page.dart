import 'package:app_lista_produtos/components/aviso_dialog.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/pages/busca_produto.dart';
import 'package:app_lista_produtos/pages/detalhes_produto.dart';
import 'package:app_lista_produtos/pages/detalhes_usuario.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:app_lista_produtos/pages/login.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          // Text((usuarioProvider.idUsuario.isNotEmpty)
          //     ? usuarioProvider.idUsuario
          //     : usuarioProvider.idUsuarioTeste),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BuscaProduto()),
                );
              },
              fontColor: Colors.white,
              label: "Busca",
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesUsuario(
                      id: usuarioProvider.idUsuario,
                    ),
                  ),
                );
              },
              fontColor: Colors.white,
              label: "Perfil",
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Botao(
              onPressed: () {
                avisoDialog(
                  context: context,
                  mensagem: "Deseja sair do aplicativo?",
                  onPressedCancel: () => Navigator.pop(context),
                  onPressedConfirm: () {
                    Navigator.pop(context, 'OK');
                    usuarioProvider.removeIdUsuario();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                );
              },
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
