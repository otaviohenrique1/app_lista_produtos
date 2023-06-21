import 'package:app_lista_produtos/components/aviso_dialog.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/components/item.dart';
import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:app_lista_produtos/pages/editar_produto.dart';
import 'package:app_lista_produtos/pages/editar_usuario.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:app_lista_produtos/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalhesUsuario extends StatefulWidget {
  const DetalhesUsuario({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DetalhesUsuario> createState() => _DetalhesUsuarioState();
}

class _DetalhesUsuarioState extends State<DetalhesUsuario> {
  @override
  Widget build(BuildContext context) {
    UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    usuarioProvider.findById(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do usuario"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
          child: Consumer<UsuarioProvider>(
            builder: (context, usuarioProviderConsumer, child) {
              UsuarioModel usuario = usuarioProviderConsumer.dadosUsuario;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Item(titulo: "ID:", descricao: usuario.id),
                  Item(titulo: "Nome:", descricao: usuario.nome),
                  Item(
                    titulo: "Senha:",
                    descricao: escondeSenha(usuario.senha),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Botao(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarUsuario(
                              id: usuario.id,
                            ),
                          ),
                        );
                      },
                      label: "Editar",
                      fontColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
