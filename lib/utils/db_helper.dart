import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:repeat_exam/screen/edit/model/edit_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  Database? dataBase;

  final String DB_NAME = "db_name";

  Future<Database> checkDb() async {
    if (dataBase != null) {
      return dataBase!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String todoTable =
            "CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT,description TEXT, category TEXT,date TEXT)";

        db.execute(todoTable);
      },
    );
  }

  Future<void> insertDB(EditModel editModel) async {
    dataBase = await checkDb();

    dataBase!.insert("todo", {
      "title": editModel.title,
      "description": editModel.description,
      "category": editModel.category,
      "date": editModel.date,
    });
  }

  Future<List<EditModel>> readDB(EditModel editModel) async {
    dataBase = await checkDb();
    String query = "SELECT * FROM todo";
    List<Map> data = await dataBase!.rawQuery(query, null);
    List<EditModel> editList =
        data.map((e) => EditModel.mapToModel(e)).toList();
    return editList;
  }

  Future<void> deleteDB({required String id}) async {
    dataBase = await checkDb();
    dataBase!.delete("todo", where: "id=?", whereArgs: [id]);
  }

  Future<void> updateDB(EditModel editModel) async {
    dataBase = await checkDb();
    await dataBase!.update(
        "todo",
        {
          "title": editModel.title,
          "description": editModel.description,
          "category": editModel.category,
          "date": editModel.date,
        },
        where: "id=?",
        whereArgs: [editModel.id]);
  }
}
