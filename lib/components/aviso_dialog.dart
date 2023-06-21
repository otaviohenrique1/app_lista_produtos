import 'package:flutter/material.dart';

avisoDialog({
  required BuildContext context,
  required String mensagem,
  required Function() onPressedCancel,
  required Function() onPressedConfirm,
}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Aviso!'),
      content: SizedBox(
        height: 100,
        child: Center(child: Text(mensagem)),
      ),
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 64,
      ),
      iconColor: Colors.red,
      actions: <Widget>[
        TextButton(
          onPressed: onPressedCancel,
          // onPressed: () => Navigator.pop(context),
          // onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: onPressedConfirm,
          // onPressed: () {
          // Navigator.pop(context);
          // Navigator.pop(context, 'OK');
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Login()),
          // );
          // },
          child: const Text('Sim'),
        ),
      ],
    ),
  );
}
