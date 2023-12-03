import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  // Getter for the database instance
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  // Initialize the database
  initialDb() async {
    // Get the path for the database
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'MyPlant.db');

    // Open the database and handle creation/upgrading
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );

    return myDb;
  }

  // Create the Plants table when the database is created
  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "Plants"(
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "imagePath" TEXT,
        "plantName" TEXT NOT NULL,
        "amountOfWater" REAL NOT NULL,
        "type" TEXT DEFAULT 'New',
        "active" INTEGER DEFAULT 0,
        "fromDate" TEXT,
        "untilDate" TEXT
      )
    ''');
    print(
        '================================= CREATE PLANTS TABLE DONE =================================');
  }

  // Handle database upgrades
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print(
        '================================= ONUPGRADE TABLE DONE =================================');
  }

  // Read data from the database using a raw SQL query
  Future<List<Map<String, Object?>>> readData(String sql) async {
    Database? myDb = await db;
    List<Map<String, Object?>> response = await myDb!.rawQuery(sql);
    return response;
  }

  Future<List<Map<String, dynamic>>> getAllPlants() async {
    Database? myDb = await db;
    List<Map<String, dynamic>> plants =
        await myDb!.query("SELECT * FROM 'Plants'");
    return plants;
  }

  // Insert data into the database using a raw SQL query
  insertData(String sql, List list) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // Update data in the database using a raw SQL query
  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // Delete data from the database using a raw SQL query
  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
