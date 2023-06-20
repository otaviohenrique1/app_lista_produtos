import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/pages/novo_produto.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({
    super.key,
  });

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  @override
  Widget build(BuildContext context) {
    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de produtos"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 80),
        itemCount: produtoProvider.listaProdutos.length,
        itemBuilder: (context, index) {
          return Item(produto: produtoProvider.listaProdutos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NovoProduto()),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    super.key,
    required this.produto,
  });

  final ProdutoModel produto;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool isSelected = false;

  void onChanged(bool? value) {
    setState(() {
      isSelected = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text(
            widget.produto.nome,
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(
            "${widget.produto.quantidade.toString()} ${widget.produto.unidade}",
            style: TextStyle(
              decoration: (isSelected)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          leading: Checkbox(
            onChanged: onChanged,
            value: isSelected,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
