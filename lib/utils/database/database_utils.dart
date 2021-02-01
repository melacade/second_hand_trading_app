import 'dart:developer';

import 'package:second_hand_trading_app/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
class DatabaseUtils{
  static String _dbDir;
  static String _dbName="second_hand_trading_app";
  static Database _db;
  initDB() async{
    _dbDir = _dbDir == null ?  await getDatabasesPath():_dbDir;
    _db = await openDatabase(p.join(_dbDir,_dbName),onCreate: (database,version){
      return database.execute('''
      create table user(
        id        CHAR(255)  PRIMARY KEY     not null,
        name      CHAR(30)                   not null,
        phone     CHAR(30),
        avator    CHAR(30) default 'default' ,
        token     TEXT,
        auth_time INTEGER                    null
      );
      '''
      );
    },version: 1);
  }

  addNewLogin(UserData user) async{
    await initDB();
    await _db.insert("user", user.toJson());
    log(user.toJson().toString());
    await _db.close();
  }

  Future<UserData> findCurUSer() async{
    UserData user;
    await initDB();
    var list = await _db.query("user");
    if(list.length>0){
      user = UserData.fromJson(list.first);
    }else{
      user = UserData();
      user.name = "未登录";
      user.avator = "default";
    }
    await _db.close();
    return user;
  }

  deleteUser() async{
    UserData user = await findCurUSer();
    await initDB();
    _db.delete("user",where: "id=${user.id}");
    await _db.close();
  }

  updateCurUser(UserData user) async {
    UserData user = await findCurUSer();
    await initDB();
    _db.update("user", user.toJson());
    await _db.close();
  }

  
}