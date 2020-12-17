import 'dart:io';
import 'package:doan_cnpm/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "cardb.db";
  static final _databaseVersion = 1;
  static final table = 'cart_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  static final columnQuantity = 'quantity';
  static final columnImage = 'image';
  static final columnCheck = 'checked';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnId TEXT PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPrice INTEGER NOT NULL,
            $columnQuantity INTEGER NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnCheck INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(ProductModel product) async {
    Database db = await instance.database;
    print('id:${product.id} image: ${product.image}');
    return await db.insert(table, {
      'id': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': product.quantity,
      'image': product.image[0],
      'checked': product.isChecked ? 1 : 0
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(id) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnId = '%$id%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(ProductModel product) async {
    Database db = await instance.database;
    String id = product.toMap()['id'];
    print('update id: ${id}');
    return await db.update(table, product.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  // UpdateFavItem(ProductModel data) async {
  //   try {
  //     var qry =
  //         "UPDATE shopping set fav = ${data.fav ? 1 : 0} where id = ${data.id}";
  //     this._db.rawUpdate(qry).then((res) {
  //       print("UPDATE RES ${res}");
  //     }).catchError((e) {
  //       print("UPDATE ERR ${e}");
  //     });
  //   } catch (e) {
  //     print("ERRR @@");
  //     print(e);
  //   }
  // }

  // Add In fav list
  // addToFav(Data data) {
  //   var _index = _data.indexWhere((d) => d.id == data.id);
  //   data.fav = !data.fav;
  //   _data.insert(_index, data);
  //   this.UpdateFavItem(data);
  //   notifyListeners();
  // }

}
