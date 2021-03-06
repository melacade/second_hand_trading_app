import 'dart:developer';

import 'package:second_hand_trading_app/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';

class DatabaseUtils {
  static String _dbDir;
  static String _dbName = "second_hand_trading_app";
  static Database _db;
  static final _lock = Lock();
  initDB() async {
    _dbDir = _dbDir == null ? await getDatabasesPath() : _dbDir;
    _db = await openDatabase(p.join(_dbDir, _dbName),
        onCreate: (database, version) {
      return database.execute('''
      create table user(
        id        CHAR(255)  PRIMARY KEY     not null,
        name      CHAR(30)                   not null,
        phone     CHAR(30),
        avator    CHAR(30) default 'default' ,
        token     TEXT,
        auth_time INTEGER                    null
      );
      ''');
    }, version: 1);
  }

  addNewLogin(UserData user) async {
    if (user == null) {
      return;
    }
    return _lock.synchronized(() async {
      await initDB();
      await _db.insert("user", user.toJson());
      log(user.toJson().toString());
      await _db.close();
    });
  }

  Future<UserData> findCurUSer() async {
    UserData user;
    return _lock.synchronized(() async {
      await initDB();
      var list = await _db.query("user");
      if (list.length > 0) {
        user = UserData.fromJson(list.first);
      } else {
        user = UserData();
        user.name = "Not logged in";
        user.avator = "default";
      }
      await _db.close();
      return user;
    });
  }

  deleteUser() async {
    UserData user = await findCurUSer();
    return _lock.synchronized(() async {
      if (user.id == null) {
        return;
      }
      await initDB();
      _db.delete("user", where: "id='${user.id}'");
      await _db.close();
    });
  }

  updateCurUser(UserData user) async {
    UserData user2 = await findCurUSer();
    return _lock.synchronized(() async {
      if (user2.id != user.id) {
        log("错误的更新");
        return;
      }
      await initDB();
      await _db.update("user", user.toJson());
      await _db.close();
    });
  }
}
