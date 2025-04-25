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
            telefone TEXT NOT NULL,
            cidade TEXT 
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> createContatos(String nome, String telefone, String cidade) async {
    final db = await getDatabase();
    await db.insert(
      tableContato,
      {
        'nome': nome,
        'telefone': telefone,
        'cidade': cidade,
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getContatos() async {
    final db = await getDatabase();
    return await db.query(tableContato);
  }

  static Future<void> editContatos(int id, String nome, String telefone, String cidade) async {
    final db = await getDatabase();
    await db.update(
      tableContato,
      {
        'nome': nome,
        'telefone': telefone,
        'cidade': cidade,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteContatos(int id) async {
    final db = await getDatabase();
    await db.delete(
      tableContato,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAllContatos() async {
    final db = await getDatabase();
    await db.delete(tableContato);
  }
}
