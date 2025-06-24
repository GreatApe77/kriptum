import 'package:kriptum/shared/contracts/disposable.dart';
import 'package:kriptum/shared/contracts/initializable.dart';

abstract class SqlDatabase implements Initializable, Disposable {
  Future<int> insert(String table, Map<String, dynamic> values);

  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  });

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
  });

  Future<int> delete(
    String table,
    String where,
    List<Object?> whereArgs,
  );
  Future<void> deleteAll(String table);
  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<Object?>? arguments]);

  Future<void> execute(String sql, [List<Object?>? arguments]);

  Future<T> transaction<T>(Future<T> Function() action);

  Future<int> getVersion();
}
