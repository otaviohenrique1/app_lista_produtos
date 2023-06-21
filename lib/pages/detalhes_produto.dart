import 'package:app_lista_produtos/components/aviso_dialog.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/pages/editar_produto.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
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

    String formataValorMonetario(double valor) {
      return "R\$ ${valor.toStringAsFixed(2).replaceAll(".", ",")}";
    }

    String formataQuantidadeUnidade(double quantidade, String unidade) {
      return "${quantidade.toString()} $unidade";
    }

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
                    descricao: formataQuantidadeUnidade(
                        produto.quantidade, produto.unidade),
                  ),
                  _Item(
                    titulo: "Preço:",
                    descricao: formataValorMonetario(produto.preco),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarProduto(
                              id: produto.id,
                            ),
                          ),
                        );
                      },
                      label: "Editar",
                      fontColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  Botao(
                    onPressed: () {
                      avisoDialog(
                        context: context,
                        mensagem: "Deseja remover a tarefa?",
                        onPressedCancel: () => Navigator.pop(context),
                        onPressedConfirm: () {
                          Navigator.pop(context, 'OK');
                          produtoProviderConsumer.remover(produto.id);
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ListaProdutos()));
                        },
                      );
                    },
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
