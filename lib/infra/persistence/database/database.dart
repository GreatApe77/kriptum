import 'package:kriptum/shared/contracts/initializable.dart';

abstract class Database  implements Initializable{
  Future<int> insert(String table, Map<String, dynamic> values);
  Future<List<Map<String, dynamic>>> query(String table);
  Future<int> delete(String table, String where, List<Object?> whereArgs);
}