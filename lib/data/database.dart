import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_lista_produtos/data/produto_dao.dart';
import 'package:app_lista_produtos/data/usuario_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(
    await getDatabasesPath(),
    "app_lista_produtos_db.db",
  );
  return openDatabase(
    path,
    onCreate: (db, version) {
      /* Cria o banco de dados se ele nao existe */
      db.execute(ProdutoDao.tabelaSql);
      db.execute(UsuarioDao.tabelaSql);
    },
    version: 1,
  );
}
