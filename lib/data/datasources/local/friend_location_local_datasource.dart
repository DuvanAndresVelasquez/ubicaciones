import 'package:prueba/data/models/friend_location_model.dart';
import 'package:prueba/data/models/location_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class FriendLocationLocalDatasource {
  final DatabaseHelper _dbHelper;

  FriendLocationLocalDatasource(this._dbHelper);

  Future<void> addFriendLocation(FriendLocationModel location) async {
    final db = await _dbHelper.database;
    await db.insert('friend_location', location.toMap());
  }

  Future<List<FriendLocationModel>> getFriendLocations() async {
    final db = await _dbHelper.database;
    final result = await db.query('friend_location');
    return result.map((e) => FriendLocationModel.fromMap(e)).toList();
  }

}
