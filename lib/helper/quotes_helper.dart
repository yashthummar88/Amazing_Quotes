import 'package:amazing_quotes/models/quotes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  String TABLE = "quotes";
  var database;

  List<String> quotes = [
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('LOVE','There is never a time or place for true love. It happens accidentally, in a heartbeat, in a single flashing, throbbing moment.','Sarah Dessen',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('LOVE','Love is that condition in which the happiness of another person is essential to your own.','Robert A. Heinleinn',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('LOVE','Love never dies a natural death. It dies because we don’t know how to replenish its source. It dies of blindness and errors and betrayals. It dies of illness and wounds; it dies of weariness, of witherings, of tarnishings.','Anais Nin. Heinleinn',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('LOVE','He is not a lover who does not love forever.','Euripides',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('LOVE','To love is to burn, to be on fire.','Jane Austen',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('ATTITUDE','If you look the right way, you can see that the whole world is a garden.','Frances Hodgson Burnett',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('ATTITUDE','Darkness cannot drive out darkness: only light can do that. Hate cannot drive out hate: only love can do that.','Martin Luther King Jr.',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('ATTITUDE','We are all in the gutter, but some of us are looking at the stars.','Oscar Wilde',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('ATTITUDE','Live life to the fullest, and focus on the positive.','Matt Cameron',0)",
    "INSERT INTO quotes(type,quotes,author,addFavourite)VALUES('ATTITUDE','A positive attitude may not solve all our problems but that is the only option we have if we want to get out of problems.','Subodh Gupta',0)",
  ];

  initDB() async {
    if (database == null) {
      database = openDatabase(join(await getDatabasesPath(), "Quotes_07.db"),
          version: 1, onCreate: (db, version) {
        String sql =
            "CREATE TABLE $TABLE(id INTEGER, type TEXT, quotes TEXT, author TEXT,addFavourite INTEGER,PRIMARY KEY('id' AUTOINCREMENT))";
        db.execute(sql);
        insertData();
      });
    }
    return database;
  }

  void insertData() async {
    var db = await initDB();
    quotes.forEach((element) async {
      var res = await db.rawInsert(element);
      print(res);
    });
  }

  Future<List<Quotes>> getDataByType({required String type}) async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE WHERE type = '$type'";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Quotes> response =
        res.map((record) => Quotes.fromMap(record)).toList();
    return response;
  }

  Future<List<Quotes>> getDataById({required int id}) async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE WHERE id = $id";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Quotes> response =
        res.map((record) => Quotes.fromMap(record)).toList();
    return response;
  }

  Future<List<Quotes>> getAllData() async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE ";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Quotes> response =
        res.map((record) => Quotes.fromMap(record)).toList();
    return response;
  }

  Future<int> addToFavourite({required int id}) async {
    var db = await initDB();
    String sql = "UPDATE $TABLE SET addFavourite = 1 WHERE id = $id";
    return await db.rawUpdate(sql);
  }

  Future<int> removeToFavourite({required int id}) async {
    var db = await initDB();
    String sql = "UPDATE $TABLE SET addFavourite = 0 WHERE id = $id";
    return await db.rawUpdate(sql);
  }

  Future<List<Quotes>> getFavouriteData() async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE WHERE addFavourite = 1";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Quotes> response =
        res.map((record) => Quotes.fromMap(record)).toList();
    return response;
  }
}

DBHelper dbh = DBHelper._();
