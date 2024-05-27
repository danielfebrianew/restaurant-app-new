import 'package:resto_app_new/data/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableUsers = 'users';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();

    final db = openDatabase(
      '$path/users2.db',
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tableUsers (
          id INTEGER PRIMARY KEY,
          username TEXT UNIQUE,
          password TEXT
        )
        ''');
      },
      version: 2,
    );

    return db;
  }

  Future<Database?> get database async {
    return _database ??= await _initializeDb();
  }

  Future<bool> doesUserExist(String username) async {
    final db = await database;
    final maps = await db!.query(
      _tableUsers,
      where: 'username = ?',
      whereArgs: [username],
    );

    return maps.isNotEmpty;
  }

  Future<bool> insertUser(User user) async {
    try {
      final db = await database;

      // Check if user exists
      if (await doesUserExist(user.username)) {
        return false; // User already exists
      }

      final hashPassword = await FlutterBcrypt.hashPw(
          password: user.password, salt: await FlutterBcrypt.salt());
      user.password = hashPassword;
      await db!.insert(_tableUsers, user.toJson());
      return true;
    } catch (e) {
      // print('Insert user error: $e');
      return false;
    }
  }

  Future<User?> login(String username, String password) async {
    final db = await database;
    final maps = await db!.query(
      _tableUsers,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      final user = User.fromJson(maps.first);
      final isValidPassword =
          await FlutterBcrypt.verify(password: password, hash: user.password);
      if (isValidPassword) {
        return user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
