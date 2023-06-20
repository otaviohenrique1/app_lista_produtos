import 'package:app_lista_produtos/models/usuario_model.dart';
import 'package:app_lista_produtos/pages/esqueceu_senha.dart';
import 'package:app_lista_produtos/pages/lista_usuarios.dart';
import 'package:app_lista_produtos/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_lista_produtos/pages/home_page.dart';
import 'package:app_lista_produtos/pages/novo_usuario.dart';
import 'package:app_lista_produtos/components/campo_texto.dart';
import 'package:app_lista_produtos/components/botao.dart';
import 'package:app_lista_produtos/utils/validator.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    novoUsuario() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NovoUsuario()),
      );
    }

    esqueceuSenha() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EsqueceuSenha()),
      );
    }

    UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    onSubmit() {
      if (formKey.currentState!.validate()) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomePage()),
        // );
        String email = _emailController.text;
        String senha = _senhaController.text;

        usuarioProvider.login(email, senha);
        List<UsuarioModel> data = usuarioProvider.listaUsuarios;
        print(data.length);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CampoTexto(
                  exibeLabel: true,
                  label: "E-mail",
                  validator: validaEmail,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  hintText: "Digite o seu e-mail",
                  obscureText: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                Botao(
                  onPressed: onSubmit,
                  label: "Entrar",
                  fontColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextButton(
                    onPressed: esqueceuSenha,
                    child: const Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: novoUsuario,
                  child: const Text.rich(TextSpan(
                    text: "Ainda não tem conta? ",
                    children: [
                      TextSpan(
                        text: "Faça seu cadastro!",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )),
                ),
                Botao(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListaUsuarios()),
                    );
                  },
                  label: "Usuarios",
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

// showDialog<String>(
//   context: context,
//   builder: (BuildContext context) => AlertDialog(
//     title: const Text('Aviso!'),
//     content: SizedBox(
//       height: 100,
//       child: Column(
//         children: [
//           Text(email),
//           Text(senha),
//           // const Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     Text('Deseja sair do aplicativo?'),
//           //   ],
//           // ),
//         ],
//       ),
//     ),
//     icon: const Icon(
//       Icons.warning_amber_rounded,
//       size: 64,
//     ),
//     iconColor: Colors.red,
//     actions: <Widget>[
//       TextButton(
//         onPressed: () => Navigator.pop(context),
//         // onPressed: () => Navigator.pop(context, 'Cancel'),
//         child: const Text('Não'),
//       ),
//       TextButton(
//         onPressed: () {
//           Navigator.pop(context);
//           // Navigator.pop(context, 'OK');
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => const Login()),
//           // );
//         },
//         child: const Text('Sim'),
//       ),
//     ],
//   ),
// );
