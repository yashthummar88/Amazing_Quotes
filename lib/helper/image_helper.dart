import 'package:amazing_quotes/models/image_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBImage {
  DBImage._();
  // ignore: non_constant_identifier_names
  String TABLE = "images";
  var database;
  List<String> i = [
    'assets/images/q1.jpg',
    'assets/images/q2.jpg',
    'assets/images/q3.jpg',
    'assets/images/q4.jpg',
    'assets/images/q5.jpg',
    'assets/images/q6.jpg',
    'assets/images/q7.jpg',
    'assets/images/q8.jpg',
    'assets/images/q9.jpg',
    'assets/images/q10.jpg',
    'assets/images/q11.jpg',
    'assets/images/q12.jpg',
    'assets/images/q13.jpg',
    'assets/images/q14.jpg',
    'assets/images/q15.jpg',
    'assets/images/q16.jpg',
    'assets/images/q17.jpg',
    'assets/images/q18.jpg',
    'assets/images/q19.jpg',
    'assets/images/q20.jpg',
    'assets/images/q21.jpg',
    'assets/images/q22.jpg',
    'assets/images/q23.jpg',
    'assets/images/q24.jpg',
    'assets/images/q25.jpg',
    'assets/images/q26.jpg',
    'assets/images/q27.jpg',
    'assets/images/q28.jpg',
    'assets/images/q29.jpg',
    'assets/images/q30.jpg',
    'assets/images/q31.jpg',
    'assets/images/q32.jpg',
    'assets/images/q33.jpg',
    'assets/images/q34.jpg',
    'assets/images/q35.jpg',
  ];
  List<String> images = [
    "INSERT INTO images(image)VALUES('assets/images/q1.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q2.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q3.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q4.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q5.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q6.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q7.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q8.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q9.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q10.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q11.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q12.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q13.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q14.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q15.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q16.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q17.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q18.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q19.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q20.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q21.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q22.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q23.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q24.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q25.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q26.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q27.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q28.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q29.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q30.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q31.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q32.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q33.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q34.jpg')",
    "INSERT INTO images(image)VALUES('assets/images/q35.jpg')",
  ];
  initDB() async {
    if (database == null) {
      database = openDatabase(
        join(await getDatabasesPath(), "image_12.db"),
        version: 1,
        onCreate: (db, version) {
          String sql =
              "CREATE TABLE $TABLE (id INTEGER, image TEXT,PRIMARY KEY('id' AUTOINCREMENT))";
          db.execute(sql);
          insertData();
        },
      );
    }
    return database;
  }

  void insertData() async {
    var db = await initDB();
    images.forEach((element) async {
      var res = await db.rawInsert(element);
      print(res);
    });
  }

  Future<List<ImageModel>> getAllImages() async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE ";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<ImageModel> response =
        res.map((record) => ImageModel.fromMap(record)).toList();
    return response;
  }

  Future<List<ImageModel>> getImageById({required int id}) async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE WHERE id = $id";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<ImageModel> response =
        res.map((record) => ImageModel.fromMap(record)).toList();
    return response;
  }

  getImageById2({required int id}) async {
    i.shuffle();
    String img = i[1];
    var db = await initDB();
    String sql = "UPDATE $TABLE SET  image = '$img' WHERE id = ${++id}";
    await db.rawUpdate(sql);
  }

  updateImageById(
      {required int oldId,
      required int newId,
      required String newImage,
      required String oldImage}) async {
    var db = await initDB();
    String sql1 = "UPDATE $TABLE SET image ='$newImage' WHERE id = $oldId";
    String sql2 = "UPDATE $TABLE SET image ='$oldImage' WHERE id = $newId";
    await db.rawUpdate(sql1);
    await db.rawUpdate(sql2);
  }

  Future<List<ImageModel>> updateImageById2(
      {required int oldId,
      required int newId,
      required String newImage,
      required String oldImage}) async {
    var db = await initDB();
    String sql1 = "UPDATE $TABLE SET image ='$newImage' WHERE id = $oldId";
    String sql2 = "UPDATE $TABLE SET image ='$oldImage' WHERE id = $newId";
    String sql3 = "SELECT * FROM $TABLE WHERE id = $oldId";
    await db.rawUpdate(sql1);
    await db.rawUpdate(sql2);
    List<Map<String, dynamic>> res = await db.rawQuery(sql3);
    List<ImageModel> response =
        res.map((record) => ImageModel.fromMap(record)).toList();
    return response;
  }
}

DBImage dbi = DBImage._();
