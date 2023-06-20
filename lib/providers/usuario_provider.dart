import 'package:app_lista_produtos/data/usuario_dao.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  List<UsuarioModel> _listaUsuarios = [];
  List<UsuarioModel> _usuarioDados = [];
  UsuarioModel _dadosUsuario = UsuarioModel(
    id: "",
    nome: "",
    email: "",
    senha: "",
    dataCriacao: "",
  );
  String _idUsuario = "";

  final String idUsuarioTeste = "187726dc-577a-4322-b691-68b0b2435e45";

  List<UsuarioModel> get listaUsuarios => _listaUsuarios;
  UsuarioModel get dadosUsuario => _dadosUsuario;
  List<UsuarioModel> get usuarioDados => _usuarioDados;
  String get idUsuario => _idUsuario;

  UsuarioModel initialValueUsuarioModel = UsuarioModel(
    id: "",
    nome: "",
    email: "",
    senha: "",
    dataCriacao: "",
  );

  addIdUsuario(String idUsuario) {
    _idUsuario = idUsuario;
  }

  removeIdUsuario() {
    addIdUsuario("");
  }

  Future save(UsuarioModel tarefa) async {
    await UsuarioDao().save(tarefa);
    findAll();
    // notifyListeners();
  }

  Future delete(String idTarefa) async {
    await UsuarioDao().delete(idTarefa);
    _dadosUsuario = initialValueUsuarioModel;
    findAll();
    // notifyListeners();
  }

  Future update(UsuarioModel tarefa, String idTarefa) async {
    await UsuarioDao().update(tarefa, idTarefa);
    findAll();
    // notifyListeners();
  }

  login(String email, String senha) async {
    List<UsuarioModel> data = await UsuarioDao().login(email, senha);
    _usuarioDados = data;
    notifyListeners();
  }

  findById(String idTarefa) async {
    List<UsuarioModel> data = await UsuarioDao().findById(idTarefa);
    if (data.isNotEmpty) {
      _dadosUsuario = data.first;
      notifyListeners();
    } else {
      _dadosUsuario = initialValueUsuarioModel;
      notifyListeners();
    }
  }

  findAll() async {
    _listaUsuarios = await UsuarioDao().findAll();
    notifyListeners();
  }
}
