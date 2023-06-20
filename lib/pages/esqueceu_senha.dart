import 'package:app_lista_produtos/pages/codigo_recuperacao.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({
    super.key,
  });

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (formKey.currentState!.validate()) {
        // String email = _emailController.text;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CodigoRecuperacao()),
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Digite o seu email para receber o codigo para poder alterar a senha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
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
                Botao(
                  onPressed: onSubmit,
                  label: "Proximo",
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
