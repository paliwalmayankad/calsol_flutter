
import 'package:neodove/DATABASE/Leads.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  final String tableNote = 'noteTable';
  final String columnId = 'id';
  final String lead_id  = 'lead_id';
  final String leadlist = 'leadlist';
  final String btninfo = 'btninfo';
  final String style = 'style';
  final String followupdate = 'followupdate';
  final String currentdate  = 'currentdate';

  static Database _db;

  DBHelper.internal();

 /* Future<Database> get db async {
    try {
      if (_db != null) {
        return _db;
      }
      _db = await initDatabase();
      return _db;
    }catch(e){
      print(e);
    }
  }

  initDatabase() async {
    try{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'leads.db');
    var db = await openDatabase(path, version: 1,
        onCreate: _onCreate);
    return db;
    }catch(e){
      print(e);
    }
  }

  _onCreate(Database db, int version) async {
    try{
    await db
        .execute('CREATE TABLE lead(id INTEGER PRIMARY KEY, lead_id TEXT, leadlist TEXT,btninfo TEXT, style TEXT, followupdate TEXT, currentdate TEXT)');
    }catch(e){
      print(e);
    }
  }*/
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

    //await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $lead_id TEXT, $leadlist TEXT, $btninfo TEXT, $style TEXT, $followupdate TEXT, $currentdate TEXT)');
  }

  Future<int> add(Leads student) async {
    try{
      var dbClient = await db;
      var result = await dbClient.insert(tableNote, student.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

      return result;
    }catch(e){
      print(e);
    }

  }

  Future<List<Leads>> getLeadss() async {
    try {
      var dbClient = await db;
      List<Map> maps = await dbClient.query(tableNote, columns: [
        lead_id,
        leadlist,
        style,
        btninfo,
        followupdate,
        currentdate
      ]);
      List<Leads> students = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          students.add(Leads.fromMap(maps[i]));
        }
      }
      return students;
    }catch(e)
    {
      print(e);
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'lead',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Leads student) async {
    var dbClient = await db;
    return await dbClient.update(
      'lead',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}