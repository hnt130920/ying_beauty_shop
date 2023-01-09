import 'package:sqflite/sqflite.dart';
import 'package:ying_beauty/db/db.dart';
import 'package:ying_beauty/model/sqlite/cart.dart';

class CartDao {
  static const TABLE_NAME = 'carts';
  static const COL_PROID = 'ProID';
  static const COL_NAME = 'Name';
  static const COL_PRICE = 'Price';
  static const COL_QUANTITY = 'Quantity';
  static const COL_IMG = 'Img';
  static String createTable() => '''
    CREATE TABLE IF NOT EXISTS $TABLE_NAME(
      $COL_PROID INTEGER,
      $COL_PRICE DOUBLE,
      $COL_NAME TEXT,
      $COL_QUANTITY INTEGER,
      $COL_IMG TEXT
    );
    ''';
  Future<bool> insert(Cart cart) async {
    final db = await DB().open();
    final result = await db.insert(TABLE_NAME, _toMap(cart),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.close();
    return result > 0;
  }

  Future<bool> update(Cart Cart) async {
    final db = await DB().open();
    final result = await db.update(
      TABLE_NAME,
      _toMap(Cart),
      where: '$COL_PROID = ?',
      whereArgs: [Cart.proId],
    );
    db.close();
    return result > 0;
  }

  Future<bool> delete(int id) async {
    final db = await DB().open();
    final result = await db.delete(
      TABLE_NAME,
      where: '$COL_PROID = ?',
      whereArgs: [id],
    );
    db.close();
    return result > 0;
  }

  deleteAll() async {
    final db = await DB().open();
    return db.rawDelete("Delete from $TABLE_NAME");
  }

  Future<Cart?> get(int id) async {
    final db = await DB().open();
    final results = await db.query(
      TABLE_NAME,
      where: '$COL_PROID = ?',
      whereArgs: [id],
      limit: 1,
    );
    db.close();
    return results.isEmpty ? null : _toCart(results[0]);
  }

  Future<List<Cart>> getCarts() async {
    final db = await DB().open();
    final results = await db.query(
      TABLE_NAME,
    );
    db.close();
    return List.generate(results.length, (i) => _toCart(results[i]));
  }

  Map<String, dynamic> _toMap(Cart cart) {
    return {
      COL_PROID: cart.proId,
      COL_NAME: cart.name,
      COL_PRICE: cart.price,
      COL_QUANTITY: cart.quantity,
      COL_IMG: cart.img,
    };
  }

  Cart _toCart(Map<String, dynamic> map) {
    return Cart(
        name: map[COL_NAME],
        price: map[COL_PRICE],
        proId: map[COL_PROID],
        quantity: map[COL_QUANTITY],
        img: map[COL_IMG]);
  }
}
