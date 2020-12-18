import 'package:path/path.dart';
import 'package:refactory_mobile/constants.dart';
import 'package:refactory_mobile/model/login-story-model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static final DbHelper instance = DbHelper.internal();
  DbHelper.internal();

  factory DbHelper() => instance;

  static Database db;

  Future<Database> get database async{
    if(db != null) return db;
    db = await setDatabase();
    return db;
  }

  setDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DefaultKey.DBName);
    var database = await openDatabase(path, version: 1, onCreate: onCreateDatabase);
    return database;
  }

  void onCreateDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE ${DefaultKey.TableName}(id INTEGER PRIMARY KEY, ${DefaultKey.EmailColumn} TEXT,${DefaultKey.PasswordColumn} TEXT,${DefaultKey.PathImageColumn} TEXT, ${DefaultKey.TotalLoginColumn} INTEGER)");
    print("Database Created");
  }

  Future<int> saveUserData(LoginStoryModel userModel) async {
    var dbClient = await database;
    int res = await dbClient.insert(DefaultKey.TableName, userModel.toJson());
    print("data inserted");
    return res;
  }

  Future getLoginCounter(String email) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT ${DefaultKey.EmailColumn}, ${DefaultKey.TotalLoginColumn} FROM ${DefaultKey.TableName} WHERE ${DefaultKey.EmailColumn} = ? GROUP BY ${DefaultKey.EmailColumn}", [email]);
    if(res.isEmpty){
      res = null;
    }else{
      print("EmailCounter : $res");
    }
    return res;
  }
  Future setCounter(int counter, String email) async {
    var dbClient = await database;
    int res = await dbClient.rawUpdate("UPDATE ${DefaultKey.TableName} SET ${DefaultKey.TotalLoginColumn} = ? WHERE ${DefaultKey.EmailColumn} = ?", [counter, email]);
    print("updated count : $res");
    return res;
  }

  Future loginUser(String email, String password) async {
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT ${DefaultKey.EmailColumn}, ${DefaultKey.PasswordColumn} FROM ${DefaultKey.TableName} WHERE ${DefaultKey.EmailColumn} = ? AND ${DefaultKey.PasswordColumn} = ?", [email, password]);
    print("Login => $res");
    return res;
  }

  Future getUserData(String email) async{
    var dbClient = await database;
    var res = await dbClient.rawQuery("SELECT * FROM ${DefaultKey.TableName} WHERE ${DefaultKey.EmailColumn} = ?", [email]);
    print("User Data => $res");
    return res;
  }
}