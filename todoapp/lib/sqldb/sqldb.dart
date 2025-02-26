// Import necessary packages for database operations
import 'package:sqflite/sqflite.dart'; // Sqflite package for database operations
import 'package:path/path.dart'; // Path package to construct database file paths

// Class to manage SQLite database operations
class SqlDB {
  static Database? _db; // Private static variable to hold the database instance

  // Getter method to access the database instance asynchronously
  Future<Database?> get db async {
    if (_db == null) {
      // If database is not initialized, call initialDB() to create/open it
      _db = await initialDB();
      return _db;
    } else {
      // If database is already initialized, return the existing instance
      return _db;
    }
  }

  // Method to initialize and open the database
  initialDB() async {
    String databasepath = await getDatabasesPath(); // Get default database path
    String path = join(
        databasepath, 'todoDB.db'); // Set the database file name and location

    // Open the database and execute onCreate or onUpgrade if needed
    Database db = await openDatabase(
      path,
      onCreate: _onCreate, // Called when database is created for the first time
      version: 2, // Database version (used for upgrades)
      onUpgrade: _onUpgrade, // Called when database version is changed
    );

    return db; // Return the database instance
  }

  // Method called when the database version is upgraded
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade ===============================");
    // This is where you would handle schema migrations when updating the database
  }

  // Method called when the database is created for the first time
  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "tasks" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT, 
      "name" TEXT NOT NULL, 
      "description" TEXT,
      "category"  INTEGER NOT NULL,
      "isDone" INTEGER NOT NULL DEFAULT 0,
      "date" TEXT NOT NULL
    )
    '''); // SQL query to create the 'tasks' table

    print("Created tables ============================");
  }

  // Method to retrieve data using a raw SQL query
  getData(String sql) async {
    Database? mydb = await db;
    print(
        'db accesses ====================================='); // Get database instance
    List<Map<String, dynamic>> response =
        await mydb!.rawQuery(sql); // Execute SELECT query
    return response; // Return fetched data as a list of maps
  }

  // Method to insert data into the database
  insertData(String sql) async {
    Database? mydb = await db; // Get database instance
    int response = await mydb!.rawInsert(sql);
    print("Inserted data $response ============================");
    // Execute INSERT query
    return response; // Return the row ID of the inserted record
  }

  // Method to update existing data in the database
  updateData(String sql) async {
    Database? mydb = await db; // Get database instance
    int response = await mydb!.rawUpdate(sql); // Execute UPDATE query
    return response; // Return the number of affected rows
  }

  // Method to delete data from the database
  deleteData(String sql) async {
    Database? mydb = await db; // Get database instance
    int response = await mydb!.rawDelete(sql);
    print(
        'task deleted ================================'); // Execute DELETE query
    return response; // Return the number of affected rows
  }
}
