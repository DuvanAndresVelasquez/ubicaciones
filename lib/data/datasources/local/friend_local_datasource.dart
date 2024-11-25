import 'package:prueba/data/models/friend_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class FriendLocalDataSource {
  final DatabaseHelper _dbHelper;

  FriendLocalDataSource(this._dbHelper);

  Future<void> addFriend(FriendModel friend) async {
    final db = await _dbHelper.database;
    await db.insert('friends', friend.toMap());
  }

  Future<List<FriendModel>> getFriends() async {
    final db = await _dbHelper.database;
    final result = await db.query('friends');
    return result.map((e) => FriendModel.fromMap(e)).toList();
  }
}
