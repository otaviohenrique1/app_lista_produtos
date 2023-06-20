import 'package:app_lista_produtos/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:app_lista_produtos/utils/helpers.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class NovoUsuario extends StatefulWidget {
  const NovoUsuario({
    super.key,
  });

  @override
  State<NovoUsuario> createState() => _NovoUsuarioState();
}

class _NovoUsuarioState extends State<NovoUsuario> {
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

    onSubmit() {
      if (formKey.currentState!.validate()) {
        String nome = _nomeController.text;
        String email = _emailController.text;
        String senha = _senhaController.text;
        usuarioProvider.save(UsuarioModel(
          id: geraUuid(),
          nome: nome,
          email: email,
          senha: senha,
          dataCriacao: geraDataHoraFormatada(),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo usuario"),
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
                  label: "Cadastrar",
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
