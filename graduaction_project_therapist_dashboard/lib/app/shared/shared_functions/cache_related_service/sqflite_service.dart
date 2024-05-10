import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteServices {
  static Database? _database;
  static final SqfLiteServices instance = SqfLiteServices._init();

  SqfLiteServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('messages.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE messages (
      id $idType,
      type $textType,
      content $textType,
      timestamp $textType
    )
    ''');
  }

  Future<MessageModel> storeMessage(MessageModel message) async {
    final db = await database;
    final id = await db.insert('messages', message.toMap());
    return message.copyWith(id: id);
  }

  Future<List<MessageModel>> getMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('messages');

    return List.generate(maps.length, (i) {
      return MessageModel.fromMap(maps[i]);
    });
  }
}
