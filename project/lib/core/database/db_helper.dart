import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../features/inspection/models/inspection_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  factory DbHelper() {
    return _instance;
  }

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'telsmd.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cek_potensials (
        local_id INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        unit_input_id INTEGER,
        wilayah_id INTEGER,
        uptiga_id INTEGER,
        idpel_id INTEGER,
        nama TEXT,
        alamat TEXT,
        tarif TEXT,
        daya REAL,
        pemb_arus TEXT,
        pt TEXT,
        ct TEXT,
        fxm REAL,
        merk_meter TEXT,
        type_meter TEXT,
        nomormeter TEXT,
        teganganmeter TEXT,
        arusmeter TEXT,
        konsmeter TEXT,
        tahunmeter REAL,
        classmeter TEXT,
        kwhwbp REAL,
        kwhlwbp REAL,
        kwhtotal REAL,
        kvarhwbp REAL,
        kvarhlwbp REAL,
        kvarhtotal REAL,
        ctr REAL,
        cts REAL,
        ctt REAL,
        ctsr REAL,
        ctss REAL,
        ctst REAL,
        ectr REAL,
        ects REAL,
        ectt REAL,
        vr REAL,
        vs REAL,
        vt REAL,
        vn REAL,
        kond_proteksi TEXT,
        arus_setting TEXT,
        waktu_setting TEXT,
        thermal_setting TEXT,
        merk_modem_lama TEXT,
        merk_modem_baru TEXT,
        type_modem_lama TEXT,
        type_modem_baru TEXT,
        imei_modem_lama TEXT,
        imei_modem_baru TEXT,
        provider_lama TEXT,
        provider_baru TEXT,
        no_simcard_lama TEXT,
        no_simcard_baru TEXT,
        ket_modem TEXT,
        petugas_pemeriksa TEXT,
        doku1 TEXT,
        doku2 TEXT,
        doku3 TEXT,
        doku4 TEXT,
        doku5 TEXT,
        dokumen TEXT,
        kesimpulan TEXT,
        tindaklanjut TEXT,
        keterangan TEXT,
        user_id INTEGER,
        created_at TEXT,
        updated_at TEXT,
        is_synced INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertInspection(InspectionModel inspection, {required int userId}) async {
    final db = await database;
    final data = inspection.toJsonForDb(userId: userId);    
    data['is_synced'] = 0;
    return await db.insert('cek_potensials', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUnsyncedInspectionsMaps() async {
    final db = await database;
    return await db.query(
      'cek_potensials',
      where: 'is_synced = ?',
      whereArgs: [0],
    );
  }

  Future<List<InspectionModel>> getUnsyncedInspections() async {
    final maps = await getUnsyncedInspectionsMaps();
    return List.generate(maps.length, (i) {
      return InspectionModel.fromJson(maps[i]);
    });
  }

  Future<void> markAsSynced(int localId) async {
    final db = await database;
    await db.update(
      'cek_potensials',
      {'is_synced': 1},
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }
  
  Future<void> deleteInspection(int localId) async {
    final db = await database;
    await db.delete(
      'cek_potensials',
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }
}
