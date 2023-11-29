import 'package:code_academy_2/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{

  Future<Database> initDB() async{
    String path = await getDatabasesPath();
    Database db = await openDatabase(
      join(path, 'abdelrahman.db'),
      version: 1,
      onCreate: (db, version){
        db.execute('CREATE TABLE users(email TEXT, password TEXT)');
      }
    );
    return db;
  }

  Future<void> addUser(User user) async{
    Database db = await initDB();
    await db.insert('users', user.toMap());
  }

  Future<void> deleteUser(User user)async{
    Database db = await initDB();
    await db.delete('users', where: 'email = ?' , whereArgs: [user.email]);
  }

  Future<void> updateUser(User oldUser, User newUser)async{ // abdo@gmail.com
    Database db = await initDB();
    await db.update('users', newUser.toMap(), where: 'email = ?', whereArgs: [oldUser.email]);
  }

  Future<List<User>> getUsers() async{
    Database db = await initDB();
    List<Map<String, dynamic>> table = await db.query('users'); // [ {} , {} , {} ]
    List<User> users = [];
    for(var map in table){
      users.add(User.fromMap(0, map));
    }
    return users;
  }
}