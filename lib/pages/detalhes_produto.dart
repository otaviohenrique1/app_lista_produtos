import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetalhesProduto extends StatefulWidget {
  const DetalhesProduto({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DetalhesProduto> createState() => _DetalhesProdutoState();
}

class _DetalhesProdutoState extends State<DetalhesProduto> {
  @override
  Widget build(BuildContext context) {
    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);

    produtoProvider.buscarPorId(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo produto"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
          child: Consumer<ProdutoProvider>(
            builder: (context, produtoProviderConsumer, child) {
              ProdutoModel produto = produtoProviderConsumer.produto;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Item(titulo: "ID:", descricao: produto.id),
                  _Item(titulo: "Nome:", descricao: produto.nome),
                  _Item(
                    titulo: "Quantidade:",
                    descricao:
                        "${produto.quantidade.toString()} ${produto.unidade}",
                  ),
                  _Item(
                    titulo: "Preço:",
                    descricao:
                        "R\$ ${produto.preco.toStringAsFixed(2).replaceAll(".", ",")}",
                  ),
                  _Item(titulo: "Descrição:", descricao: produto.descricao),
                  _Item(titulo: "Categoria:", descricao: produto.categoria),
                  _Item(titulo: "Ativo:", descricao: produto.ativo),
                  _Item(
                    titulo: "Data e criação:",
                    descricao: produto.dataCriacao,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                    child: Botao(
                      onPressed: () {},
                      label: "Editar",
                      fontColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Botao(
                    onPressed: () {},
                    label: "Remover",
                    fontColor: Colors.white,
                    backgroundColor: Colors.red,
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

class _Item extends StatelessWidget {
  const _Item({
    // ignore: unused_element
    super.key,
    required this.titulo,
    required this.descricao,
  });

  final String titulo;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            descricao,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const Divider()
      ],
    );
  }
}
