abstract class BaseDao<T> {
  Future<int> save(T base);
  Future<int> update(T base, String id);
  Future<List<T>> findAll();
  Future<List<T>> find(String id);
  Future<int> delete(String id);
  Map<String, dynamic> toMap(T base);
  List<T> toList(List<Map<String, dynamic>> mapa);
}
