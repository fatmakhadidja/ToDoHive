import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int old_version, int new_version) async {
    print("onUpgrade ===============================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "tasks" (
   "id" INTEGER PRIMARY KEY AUTOINCREMENT,
   "title" TEXT NOT NULL,
   "description" TEXT
   )
   ''');
    print("Created tables ============================");
  }

  getData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
