import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseModel {
  late String name;
  late int number;
  late int id;
  DatabaseModel(this.name,this.id, this.number);
}

class DBhelper {
  static String databaseName = "Create Order";
  static int databaseVersion = 1;
  static String tableName = "orderDetails";
  static String columnId = "id";
  static String columnItemName = "name";
  static String columnItemNumbers = "number";
  DBhelper._counstructor();
  static final DBhelper instantce = DBhelper._counstructor();
  static var _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initdatabase();
    return _database;
  }

  initdatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = await join(documentDirectory.path, databaseName);
    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: (Database database, databaseVersion) async {
        return await database.execute(
            """CREATE TABLE $tableName
            ($columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnItemName  TEXT,
            $columnItemNumbers INTEGER)
            """);
      },
    );
  }
    static insert  (DatabaseModel databaseModel) async {
    
    Database database = await DBhelper.instantce.database;
    Map<String, dynamic> row = {
      columnItemName: databaseModel.name,
      columnItemNumbers: databaseModel.number,
    };
    final id = database.insert(tableName, row);
    print(id);
  }
  static readData() async {
    Database database = await DBhelper.instantce.database;
    return database.query(tableName);
  }
  static Future updateData(DatabaseModel databaseModel)async{
    Database database = await DBhelper.instantce.database;
    return database.execute("UPDATE $tableName SET $columnItemName='${databaseModel.name}' , $columnItemNumbers=${databaseModel.number} where $columnId=${databaseModel.id}");
  }
static  Future deleteData(DatabaseModel databaseModel)async{
    Database database = await DBhelper.instantce.database;
    return database.execute("DELETE FROM $tableName where id=${databaseModel.id}");
  }
}
