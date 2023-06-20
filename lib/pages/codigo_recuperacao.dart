import 'package:flutter/material.dart';
import 'package:app_lista_produtos/pages/alteracao_senha.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';

class CodigoRecuperacao extends StatefulWidget {
  const CodigoRecuperacao({
    super.key,
  });

  @override
  State<CodigoRecuperacao> createState() => _CodigoRecuperacaoState();
}

class _CodigoRecuperacaoState extends State<CodigoRecuperacao> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _codigoRecuperacaoController =
      TextEditingController();

  @override
  void dispose() {
    _codigoRecuperacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (formKey.currentState!.validate()) {
        String codigoRecuperacao = _codigoRecuperacaoController.text;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AlteracaoSenha()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Codigo de recuperação"),
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
                    "Digite o codigo recebido no seu email para poder alterar a senha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CampoTexto(
                    exibeLabel: true,
                    label: "Codigo de recuperação",
                    validator: validaEmail,
                    keyboardType: TextInputType.number,
                    controller: _codigoRecuperacaoController,
                    hintText: "Digite o codigo de recuperação",
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
