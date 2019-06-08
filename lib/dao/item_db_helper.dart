import 'dart:async';

import 'package:path/path.dart';

//import 'package:sale_aggregator_app/models/video.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/entity/Item.dart';

class ItemDbHelper {
  static final ItemDbHelper _instance = new ItemDbHelper.internal();

  factory ItemDbHelper() => _instance;

  final String tableName = 'itemTable';
  final String columnNameId = 'local_id';
  final String columnNameUid = 'uid';
  final String columnNameIs_sync = 'is_sync';
  final String columnNameTitle = 'title';
  final String columnNameState = 'state';
  final String columnNameCreate_time = 'create_time';

  static Database _db;

  ItemDbHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pangolin.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($columnNameId INTEGER PRIMARY KEY, $columnNameUid Integer, $columnNameIs_sync TEXT, $columnNameTitle TEXT, $columnNameState Integer,$columnNameCreate_time Integer)');
  }

  Future<int> insertVideo(Item item) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, item.toJson());

    return result;
  }

  Future<List> selectVideos({int limit, int offset}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableName,
      columns: [
        columnNameId,
        columnNameUid,
        columnNameIs_sync,
        columnNameTitle,
        columnNameState,
        columnNameCreate_time
      ],
      limit: limit,
      offset: offset,
    );
    List<Item> videos = [];
    result.forEach((item) => videos.add(Item.fromSql(item)));
    return videos;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  Future<Item> getItem(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableName,
        columns: [
          columnNameId,
          columnNameUid,
          columnNameIs_sync,
          columnNameTitle,
          columnNameState,
          columnNameCreate_time
        ],
        where: '$id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return Item.fromSql(result.first);
    }

    return null;
  }

//  Future<int> deleteNote(String images) async {
//    var dbClient = await db;
//    return await dbClient
//        .delete(tableName, where: '$image = ?', whereArgs: [images]);
//  }
//
//  Future<int> updateNote(Video video) async {
//    var dbClient = await db;
//    return await dbClient.update(tableName, video.toJson(),
//        where: "$columnId = ?", whereArgs: [video.id]);
//  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
