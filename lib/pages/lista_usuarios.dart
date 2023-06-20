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
              return Column(
                children: [
                  ListTile(
                    title: Text(
                        usuarioProviderConsumer.listaUsuarios[index].email),
                    subtitle: Text(
                        usuarioProviderConsumer.listaUsuarios[index].senha),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
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
