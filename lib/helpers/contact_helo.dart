import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String contactTable = "contactTable";
const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String birthdayColumn = "birthdayColumn";
const String imageColumn = "imageColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databsesPath = await getDatabasesPath();
    final path = join(databsesPath, 'birthday.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable{$idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $birthdayColumn TEXT, $imageColumn TEXT}");
    });
  }
}

class Data {
  int id = 0;
  String name = '';
  String birthday = '';
  String phone = '';
  String image = '';

  Data.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    birthday = map[birthdayColumn];
    image = map[imageColumn];
  }

  Map<String, dynamic> toMap() {
    return {nameColumn: name, birthdayColumn: birthday, imageColumn: image};
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Birtdhay: {$id, name: $name, phone: $phone, img: $image}";
  }
}
