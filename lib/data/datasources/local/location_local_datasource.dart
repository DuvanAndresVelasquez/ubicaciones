import 'package:prueba/data/models/location_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class LocationLocalDataSource {
  final DatabaseHelper _dbHelper;

  LocationLocalDataSource(this._dbHelper);

  Future<void> addLocation(LocationModel location) async {
    final db = await _dbHelper.database;
    await db.insert('locations', location.toMap());
  }

  Future<List<LocationModel>> getLocations() async {
    final db = await _dbHelper.database;
    final result = await db.query('locations');
    return result.map((e) => LocationModel.fromMap(e)).toList();
  }



  Future<List<LocationModel>> getLocationsForFriend(int friendId) async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('''
    SELECT locations.*
    FROM locations
    INNER JOIN friend_location ON locations.id = friend_location.location_id
    WHERE friend_location.friend_id = ?
  ''', [friendId]);

    return result.map((e) => LocationModel.fromMap(e)).toList();
  }
}
