import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:app_lista_produtos/pages/detalhes_usuario.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({
    super.key,
  });

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  @override
  Widget build(BuildContext context) {
    UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    usuarioProvider.findAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuarios"),
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, usuarioProviderConsumer, child) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 80),
            itemCount: usuarioProviderConsumer.listaUsuarios.length,
            itemBuilder: (context, index) {
              UsuarioModel usuarioItem =
                  usuarioProviderConsumer.listaUsuarios[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(usuarioItem.email),
                    subtitle: Text(usuarioItem.senha),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesUsuario(
                            id: usuarioItem.id,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
