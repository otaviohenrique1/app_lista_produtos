import 'package:sqflite/sqflite.dart';
import 'package:app_lista_produtos/data/database.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';

class UsuarioDao {
  static const String tabelaSql = "CREATE TABLE $_nomeTabela ("
      "$_id TEXT UNIQUE, "
      "$_nome TEXT, "
      "$_email TEXT, "
      "$_senha TEXT, "
      "$_dataCriacao DATETIME"
      ")";

  static const String _nomeTabela = "usuarioTable";
  static const String _id = "id";
  static const String _nome = "nome";
  static const String _email = "email";
  static const String _senha = "senha";
  static const String _dataCriacao = "dataCriacao";

  save(UsuarioModel usuario) async {
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> usuariosMap = toMap(usuario);
    return await bancoDeDados.insert(_nomeTabela, usuariosMap);
  }

  update(UsuarioModel produto, String idProduto) async {
    final Database bancoDeDados = await getDatabase();
    Map<String, dynamic> usuariosMap = toMap(produto);
    return await bancoDeDados.update(_nomeTabela, usuariosMap,
        where: "$_id = ?", whereArgs: [idProduto]);
  }

  Future<List<UsuarioModel>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado =
        await bancoDeDados.query(_nomeTabela);
    return toList(resultado);
  }

  Future<List<UsuarioModel>> findById(String idUsuario) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados
        .query(_nomeTabela, where: "$_id = ?", whereArgs: [idUsuario]);
    return toList(resultado);
  }

  Future<List<UsuarioModel>> login(String email, String senha) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> resultado = await bancoDeDados.query(
      _nomeTabela,
      where: "$_email = ? AND $_senha = ?",
      whereArgs: [email, senha],
    );
    return toList(resultado);
  }

  delete(String idUsuario) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_nomeTabela, where: "$_id = ?", whereArgs: [idUsuario]);
  }

  Map<String, dynamic> toMap(UsuarioModel usuario) {
    final Map<String, dynamic> usuarios = {};
    usuarios[_id] = usuario.id;
    usuarios[_nome] = usuario.nome;
    usuarios[_email] = usuario.email;
    usuarios[_senha] = usuario.senha;
    usuarios[_dataCriacao] = usuario.dataCriacao;
    return usuarios;
  }

  List<UsuarioModel> toList(List<Map<String, dynamic>> mapaUsuarios) {
    final List<UsuarioModel> usuarios = [];
    for (Map<String, dynamic> linha in mapaUsuarios) {
      final UsuarioModel usuario = UsuarioModel(
        id: linha[_id],
        nome: linha[_nome],
        email: linha[_email],
        senha: linha[_senha],
        dataCriacao: linha[_dataCriacao],
      );
      usuarios.add(usuario);
    }
    return usuarios;
  }
}
