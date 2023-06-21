import 'package:app_lista_produtos/components/select.dart';
import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/pages/detalhes_produto.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:app_lista_produtos/utils/helpers.dart';
import 'package:app_lista_produtos/utils/listas.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';
import 'package:provider/provider.dart';

class EditarProduto extends StatefulWidget {
  const EditarProduto({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<EditarProduto> createState() => _EditarProdutoState();
}

class _EditarProdutoState extends State<EditarProduto> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  // ativo

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  String dropdownValueUnidadeQuantidade = unidadeQuantidade.first;
  String dropdownValueCategoria = categoria.first;
  bool isSelected = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);
    produtoProvider.buscarPorId(widget.id);

    ProdutoModel produto = produtoProvider.produto;

    _nomeController.text = produto.nome;
    _precoController.text = produto.preco.toString();
    _descricaoController.text = produto.descricao;
    _quantidadeController.text = produto.quantidade.toString();
    dropdownValueUnidadeQuantidade = produto.unidade;
    dropdownValueCategoria = produto.categoria;
    isSelected = (produtoProvider.produto.ativo == "Sim") ? true : false;

    onSubmit() {
      if (formKey.currentState!.validate()) {
        String id = produto.id;
        String dataCriacao = produto.dataCriacao;
        String nome = _nomeController.text;
        String preco = _precoController.text;
        String descricao = _descricaoController.text;
        String quantidade = _quantidadeController.text;
        String unidadeQuantidade = dropdownValueUnidadeQuantidade;
        String categoria = dropdownValueCategoria;
        bool ativo = isSelected;
        // String foto = "foto";
        String idUsuario = produto.idUsuario;

        produtoProvider.atualizar(
          ProdutoModel(
            id: id,
            dataCriacao: dataCriacao,
            nome: nome,
            preco: double.parse(preco),
            descricao: descricao,
            quantidade: double.parse(quantidade),
            unidade: unidadeQuantidade,
            categoria: categoria,
            ativo: (ativo) ? "Sim" : "Não",
            idUsuario: idUsuario,
          ),
          id,
        );

        Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) => DetalhesProduto(id: produto.id)),
        );
      }
    }

    void onChanged(bool? value) {
      setState(() {
        isSelected = value!;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo produto"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Nome",
                    validator: validaCampoVazio,
                    keyboardType: TextInputType.text,
                    controller: _nomeController,
                    hintText: "Digite o nome do produto",
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Preço",
                    validator: validaCampoVazio,
                    keyboardType: TextInputType.text,
                    controller: _precoController,
                    hintText: "Digite o preco do produto",
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CampoTexto(
                          exibeLabel: true,
                          label: "Quantidade",
                          validator: validaCampoVazio,
                          keyboardType: TextInputType.text,
                          controller: _quantidadeController,
                          hintText: "Digite a quantidade do produto",
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Select(
                          lista: unidadeQuantidade,
                          onChanged: (value) async {
                            setState(() {
                              dropdownValueUnidadeQuantidade = value!;
                            });
                          },
                          dropdownValue: dropdownValueUnidadeQuantidade,
                          exibeLabel: true,
                          label: "Unidade",
                          validator: (value) => validaSelect(
                            value: value,
                            primeiroValorSelect: "Selecione",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Select(
                    lista: categoria,
                    onChanged: (value) async {
                      setState(() {
                        dropdownValueCategoria = value!;
                      });
                    },
                    dropdownValue: dropdownValueCategoria,
                    exibeLabel: true,
                    label: "Categoria",
                    validator: (value) => validaSelect(
                      value: value,
                      primeiroValorSelect: "Selecione",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Descrição",
                    validator: validaCampoVazio,
                    keyboardType: TextInputType.multiline,
                    controller: _descricaoController,
                    maxLines: 2,
                    hintText: "Digite a descricao do produto",
                    obscureText: false,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: onChanged,
                    title: const Text("Ativo"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 100,
                  height: 150,
                ),
                Botao(
                  onPressed: onSubmit,
                  label: "Salvar",
                  fontColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
