class UsuarioModel {
  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.dataCriacao,
  });

  String id;
  String nome;
  String email;
  String senha;
  DateTime dataCriacao;
}
