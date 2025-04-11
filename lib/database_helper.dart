import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static const String tableContato = "Contatos";

  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, "dbContatos.db"),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableContato (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            telefone TEXT NOT NULL
          )       
        ''');
      },
      version: 1,
    );
  }

  static Future<void> createContatos(String nome, String telefone) async {
    final db = await getDatabase();
    await db.insert(
      tableContato,
      {
        'nome': nome,
        'telefone': telefone,
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getContatos() async {
    final db = await getDatabase();
    return await db.query(tableContato);
  }

  static Future<void> editContatos() async {}

  static Future<void> deleteContatos() async {}
}
