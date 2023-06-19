import 'package:app_lista_produtos/data/usuario_dao.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  List<UsuarioModel> _listaTarefas = [];
  UsuarioModel _dadosTarefa = UsuarioModel(
    id: "",
    nome: "",
    email: "",
    senha: "",
    dataCriacao: DateTime.now(),
  );
  String _idUsuario = "";

  List<UsuarioModel> get listaTarefas => _listaTarefas;
  UsuarioModel get dadosTarefa => _dadosTarefa;
  String get idUsuario => _idUsuario;

  UsuarioModel initialValueUsuarioModel = UsuarioModel(
    id: "",
    nome: "",
    email: "",
    senha: "",
    dataCriacao: DateTime.now(),
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
    _dadosTarefa = initialValueUsuarioModel;
    findAll();
    // notifyListeners();
  }

  Future update(UsuarioModel tarefa, String idTarefa) async {
    await UsuarioDao().update(tarefa, idTarefa);
    findAll();
    // notifyListeners();
  }

  Future<List<UsuarioModel>> login(String email, String senha) async {
    return await UsuarioDao().login(email, senha);
  }

  findById(String idTarefa) async {
    List<UsuarioModel> data = await UsuarioDao().findById(idTarefa);
    if (data.isNotEmpty) {
      _dadosTarefa = data.first;
      notifyListeners();
    } else {
      _dadosTarefa = initialValueUsuarioModel;
      notifyListeners();
    }
  }

  findAll() async {
    _listaTarefas = await UsuarioDao().findAll();
    notifyListeners();
  }
}
