import 'package:flutter/material.dart';

bool validaValor(String? value) {
  return (value == null || value.isEmpty);
}

bool validaTamanhoMinimoSenha(String value) {
  return value.length <= 8;
}

bool validaTamanhoMaximoSenha(String value) {
  return value.length >= 32;
}

String? validaCampoVazio(String? value) {
  if (validaValor(value)) {
    return "Campo vazio";
  }
  return null;
}

String? validaEmail(String? value) {
  if (validaValor(value)) {
    return "Campo vazio";
  } else if (!value!.contains("@")) {
    return "E-mail deve conter @";
  } else if (!value.contains(".com")) {
    return "E-mail deve conter .com";
  }
  return null;
}

String? validaSenha(String? value) {
  if (validaValor(value)) {
    return "Campo vazio";
  } else if (validaTamanhoMinimoSenha(value!)) {
    return "Minimo de 8 caracteres";
  } else if (validaTamanhoMaximoSenha(value)) {
    return "Maximo de 32 caracteres";
  }
  return null;
}

String? validaRepitaSenha(
    String? value, TextEditingController senhaController) {
  if (validaValor(value)) {
    return "Campo vazio";
  } else if (senhaController.text != value) {
    return "Senhas não coincidem";
  } else if (validaTamanhoMinimoSenha(value!)) {
    return "Minimo de 8 caracteres";
  } else if (validaTamanhoMaximoSenha(value)) {
    return "Maximo de 8 caracteres";
  }
  return null;
}

String? validaSelect(
    {required String? value, required String primeiroValorSelect}) {
  if (value == null || value == primeiroValorSelect) {
    return "Valor inválido";
  }
  return null;
}
