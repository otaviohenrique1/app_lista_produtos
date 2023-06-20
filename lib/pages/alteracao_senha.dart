import 'package:app_lista_produtos/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class AlteracaoSenha extends StatefulWidget {
  const AlteracaoSenha({
    super.key,
  });

  @override
  State<AlteracaoSenha> createState() => _AlteracaoSenhaState();
}

class _AlteracaoSenhaState extends State<AlteracaoSenha> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repitaSenhaController = TextEditingController();

  @override
  void dispose() {
    _senhaController.dispose();
    _repitaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (formKey.currentState!.validate()) {
        String senha = _senhaController.text;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alteração da senha"),
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
