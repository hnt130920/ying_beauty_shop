import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ying_beauty/db/cart_dao.dart';

class DB {
  static const DB_NAME = 'cart.db';
  static const DB_VERSION = 1;
  Future<Database> open() async {
    final database = openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: (db, version) async {
        await db.execute(CartDao.createTable());
      },
    );
    return database;
  }
}
