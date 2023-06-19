import 'package:app_lista_produtos/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_lista_produtos/models/produto_model.dart';

class ProdutoDao {
  static const String tabelaSql = "CREATE TABLE $_nomeTabela ("
      "$_id TEXT UNIQUE, "
      "$_nome TEXT, "
      "$_quantidade DOUBLE, "
      "$_unidade TEXT, "
      "$_categoria TEXT, "
      "$_descricao TEXT, "
      "$_ativo BOOLEAN, "
      "$_idUsuario TEXT, "
      "$_preco DOUBLE, "
      "$_foto TEXT, "
      "$_dataCriacao DATETIME"
      ")";

  static const String _nomeTabela = "produtoTable";
  static const String _id = "id";
  static const String _nome = "nome";
  static const String _quantidade = "quantidade";
  static const String _unidade = "unidade";
  static const String _categoria = "categoria";
  static const String _descricao = "descricao";
  static const String _ativo = "ativo";
  static const String _foto = "foto";
  static const String _preco = "preco";
  static const String _idUsuario = "idUsuario";
  static const String _dataCriacao = "dataCriacao";

  save(ProdutoModel produto) async {
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> produtosMap = toMap(produto);
    return await bancoDeDados.insert(_nomeTabela, produtosMap);
  }

  update(ProdutoModel produto, String idProduto) async {
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> produtosMap = toMap(produto);
    return await bancoDeDados.update(_nomeTabela, produtosMap,
        where: "$_id = ?", whereArgs: [idProduto]);
  }

  Future<List<ProdutoModel>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado =
        await bancoDeDados.query(_nomeTabela);
    return toList(resultado);
  }

  Future<List<ProdutoModel>> findByID(String idProduto) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados
        .query(_nomeTabela, where: "$_id = ?", whereArgs: [idProduto]);
    return toList(resultado);
  }

  Future<List<ProdutoModel>> findByNome(String nome) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados
        .query(_nomeTabela, where: "$_nome = ?", whereArgs: [nome]);
    return toList(resultado);
  }

  delete(String idProduto) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_nomeTabela, where: "$_id = ?", whereArgs: [idProduto]);
  }

  Map<String, dynamic> toMap(ProdutoModel produto) {
    final Map<String, dynamic> produtos = {};
    produtos[_id] = produto.id;
    produtos[_nome] = produto.nome;
    produtos[_quantidade] = produto.quantidade;
    produtos[_unidade] = produto.unidade;
    produtos[_categoria] = produto.categoria;
    produtos[_descricao] = produto.descricao;
    produtos[_ativo] = produto.ativo;
    produtos[_idUsuario] = produto.idUsuario;
    produtos[_idUsuario] = produto.idUsuario;
    produtos[_idUsuario] = produto.idUsuario;
    produtos[_foto] = produto.foto;
    produtos[_preco] = produto.preco;
    produtos[_dataCriacao] = produto.dataCriacao;
    return produtos;
  }

  List<ProdutoModel> toList(List<Map<String, dynamic>> mapaProdutos) {
    final List<ProdutoModel> produtos = [];
    for (Map<String, dynamic> linha in mapaProdutos) {
      final ProdutoModel produto = ProdutoModel(
        id: linha[_id],
        nome: linha[_nome],
        quantidade: linha[_quantidade],
        unidade: linha[_unidade],
        categoria: linha[_categoria],
        descricao: linha[_descricao],
        ativo: linha[_ativo],
        foto: linha[_foto],
        preco: linha[_preco],
        idUsuario: linha[_idUsuario],
        dataCriacao: linha[_dataCriacao],
      );
      produtos.add(produto);
    }
    return produtos;
  }
}
