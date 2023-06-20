class ProdutoModel {
  ProdutoModel({
    required this.id,
    // required this.foto,
    required this.nome,
    required this.preco,
    required this.categoria,
    required this.descricao,
    required this.quantidade,
    required this.unidade,
    required this.ativo,
    required this.idUsuario,
    required this.dataCriacao,
  });

  String id;
  // String foto;
  String nome;
  double preco;
  String categoria;
  String descricao;
  double quantidade;
  String unidade;
  bool ativo;
  String idUsuario;
  String dataCriacao;
}
