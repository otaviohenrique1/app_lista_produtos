import 'package:app_lista_produtos/components/select.dart';
import 'package:app_lista_produtos/models/produto_model.dart';
import 'package:app_lista_produtos/pages/lista_produtos.dart';
import 'package:app_lista_produtos/providers/produto_provider.dart';
import 'package:app_lista_produtos/utils/helpers.dart';
import 'package:app_lista_produtos/utils/listas.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';
import 'package:provider/provider.dart';

class NovoProduto extends StatefulWidget {
  const NovoProduto({
    super.key,
  });

  @override
  State<NovoProduto> createState() => _NovoProdutoState();
}

class _NovoProdutoState extends State<NovoProduto> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  // foto
  // unidade
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

  @override
  Widget build(BuildContext context) {
    ProdutoProvider produtoProvider =
        Provider.of<ProdutoProvider>(context, listen: false);

    colocaValorNoCampo() {
      _nomeController.text = "Maçã";
      _precoController.text = "10";
      _descricaoController.text = "Fruta";
      _quantidadeController.text = "1";
      dropdownValueUnidadeQuantidade = unidadeQuantidade[4];
      dropdownValueCategoria = categoria[1];
      isSelected = true;
    }

    onSubmit() {
      if (formKey.currentState!.validate()) {
        String uuid = geraUuid();
        String dataCriacao = geraDataHoraFormatada();
        String nome = _nomeController.text;
        String preco = _precoController.text;
        String descricao = _descricaoController.text;
        String quantidade = _quantidadeController.text;
        String unidadeQuantidade = dropdownValueUnidadeQuantidade;
        String categoria = dropdownValueCategoria;
        bool ativo = isSelected;
        // String foto = "foto";
        String idUsuario = "187726dc-577a-4322-b691-68b0b2435e45";

        produtoProvider.adicionar(ProdutoModel(
          id: uuid,
          dataCriacao: dataCriacao,
          nome: nome,
          preco: double.parse(preco),
          descricao: descricao,
          quantidade: double.parse(quantidade),
          unidade: unidadeQuantidade,
          categoria: categoria,
          ativo: (ativo) ? "Sim" : "Não",
          idUsuario: idUsuario,
        ));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListaProdutos()),
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
                const SizedBox(height: 16),
                Botao(
                  onPressed: colocaValorNoCampo,
                  label: "Dados",
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
