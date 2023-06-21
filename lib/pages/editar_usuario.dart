import 'package:app_lista_produtos/pages/detalhes_usuario.dart';
import 'package:app_lista_produtos/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:app_lista_produtos/utils/helpers.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class EditarUsuario extends StatefulWidget {
  const EditarUsuario({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repitaSenhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _repitaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    usuarioProvider.findById(widget.id);
    UsuarioModel usuario = usuarioProvider.dadosUsuario;
    _nomeController.text = usuario.nome;
    _emailController.text = usuario.email;
    _senhaController.text = usuario.senha;
    _repitaSenhaController.text = usuario.senha;

    onSubmit() {
      if (formKey.currentState!.validate()) {
        String nome = _nomeController.text;
        String email = _emailController.text;
        String senha = _senhaController.text;
        usuarioProvider.update(
          UsuarioModel(
            id: usuario.id,
            nome: nome,
            email: email,
            senha: senha,
            dataCriacao: usuario.dataCriacao,
          ),
          usuario.id,
        );
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesUsuario(
              id: usuario.id,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar usuario"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    hintText: "Digite o seu nome",
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "E-mail",
                    validator: validaEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    hintText: "Digite o seu e-mail",
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Senha",
                    validator: validaSenha,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _senhaController,
                    hintText: "Digite a sua senha",
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Repita a senha",
                    validator: (value) =>
                        validaRepitaSenha(value, _senhaController),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _repitaSenhaController,
                    hintText: "Digite a sua senha",
                    obscureText: true,
                  ),
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
