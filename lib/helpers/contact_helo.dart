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
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databsesPath = await getDatabasesPath();
    final path = join(databsesPath, 'birthdaynews.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $contactTable{$idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $birthdayColumn TEXT, $imageColumn TEXT}");
    });
  }

  Future<Data> saveContact(Data data) async {
    Database dbData = await db;
    data.id = await dbData.insert(contactTable, data.toMap());
    return data;
  }

  Future<Data?> getBirtdhay(int id) async {
    Database dbData = await db;
    List<Map> maps = await dbData.query(contactTable,
        columns: [idColumn, nameColumn, birthdayColumn, imageColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Data.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database dbData = await db;
    return await dbData
        .delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> update(Data data) async {
    Database dbData = await db;
    return await dbData.update(contactTable, data.toMap(),
        where: '$idColumn = ?', whereArgs: [data.id]);
  }

  Future<List> getAllContacts() async {
    Database dbData = await db;
    List listMap = await dbData.rawQuery('SELECT * FROM $contactTable');
    List<Data> listContact = [];
    for (Map m in listMap) {
      listContact.add(Data.fromMap(m));
    }
    return listContact;
  }

  Future<void> close() async {
    Database dbData = await db;
    dbData.close();
  }
}

class Data {
  int id = 0;
  String name = '';
  String birthday = '';
  String phone = '';
  String image = '';

  Data();

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
