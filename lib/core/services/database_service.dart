import 'package:body_composition/core/models/measurement_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database _database;

  DatabaseService._privateConstructor();
  DatabaseService();

  static final DatabaseService instance = DatabaseService._privateConstructor();
  
  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await _initDatabase();

    return _database;
  }
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'measurements.db');

    return await openDatabase(
      path, version: 1,
      onCreate: (Database db, int version) {
      return db.execute(
          'CREATE TABLE measurement (id INTEGER PRIMARY KEY AUTOINCREMENT, weight INTEGER, notes STRING, unit_of_measurement STRING, date STRING)');
      });
  }

  Future<int> insertMeasurement(Measurement measurement) async {
    final db = await database;

    int rowId = await db.insert('measurement', measurement.toMap());
    return rowId;
  }

  Future<List<Measurement>> fetchMeasurements() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('measurement', orderBy: 'id DESC');

    return List.generate(
        maps.length,
        (i) => Measurement(
            id: maps[i]['id'],
            weight: maps[i]['weight'],
            notes: maps[i]['notes'],
            unitOfMeasurement: maps[i]['unit_of_measurement'],
            date: DateTime.parse(maps[i]['date'])));
  }

  Future<Measurement> fetchMeasurement(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> foundRow =
        await db.query('measurement', where: 'id = ? ', whereArgs: [id]);
    if (foundRow.length > 0) {
      return Measurement(
          id: foundRow[0]['id'],
          weight: foundRow[0]['weight'],
          notes: foundRow[0]['notes'],
          unitOfMeasurement: foundRow[0]['unit_of_measurement'],
          date: DateTime.parse(foundRow[0]['date']));
    } else {
      print('No rows found matching ID: $id');
    }
  }

  Future<DatabaseService> resetDatabaseValues() async {
    final db = await database;

    await db.delete('measurement');
    return this;
  }

  Future<void> deleteMeasurement(int id) async {
    final db = await database;

    await db.delete('measurement', where: 'id = ?', whereArgs: [id]);
    return this;
  }

  Future<void> updateMeasurement(Measurement measurement) async {
    final db = await database;
    print('Updating ${measurement.id}');
    await db.update(
      'measurement',
      measurement.toMap(),
      where: 'id = ?',
      whereArgs: [measurement.id]
    );
  }
}
