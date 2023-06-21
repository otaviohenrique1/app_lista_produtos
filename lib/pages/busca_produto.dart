import 'package:flutter/material.dart';
import 'package:app_lista_produtos/pages/alteracao_senha.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class BuscaProduto extends StatefulWidget {
  const BuscaProduto({
    super.key,
  });

  @override
  State<BuscaProduto> createState() => _BuscaProdutoState();
}

class _BuscaProdutoState extends State<BuscaProduto> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _termoBuscaController = TextEditingController();

  @override
  void dispose() {
    _termoBuscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (formKey.currentState!.validate()) {
        // String termoBusca = _termoBuscaController.text;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Busca"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CampoTexto(
                        exibeLabel: false,
                        validator: validaCampoVazio,
                        keyboardType: TextInputType.number,
                        controller: _termoBuscaController,
                        hintText: "Digite o nome do produto",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: onSubmit,
                        icon: const Icon(Icons.search),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 40,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: const Text("Nome"),
                    subtitle: const Text("Quantidade"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
