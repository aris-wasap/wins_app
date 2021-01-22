import 'dart:async';
import 'dart:io';

import 'package:admart_app/models/cfl_db_warehouse_model.dart';
import 'package:admart_app/models/warehouse_response.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "admart.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Warehouse ("
          "WhsCode TEXT PRIMARY KEY,"
          "WhsName TEXT, "
          "BranchId INTEGER, "
          "BranchName TEXT "
          ")");
    });
  }

  Future warehouse_CopyToDb(WarehouseResponse warehouseResponse) async {
    final db = await database;

    // await db.transaction((txn) async {
    // Ok
    await db.execute('DELETE FROM Warehouse');

    // DON'T  use the database object in a transaction
    // this will deadlock!
    var warehouses = warehouseResponse.data;
    if (warehouses != null) {
      for (int i = 0; i < warehouses.length; i++) {
        var warehouse = warehouses[i];
        await db.insert('Warehouse', {
          'WhsCode': warehouse.whsCode,
          'WhsName': warehouse.whsName ?? "",
          'BranchId': warehouse.branchId ?? 0,
          'BranchName': warehouse.branchName ?? ""
        });
      }
    }
    // });

    return true;
  }

  //-----------------------------
  //All
  //-----------------------------
  // Future all_CopyApiToDb() async {
  //   await warehouse_CopyToDb();
  // }

  Future<List<CflDbWarehouseModel>> cflDbWarehouse_FetchNextPage(
      String lastId, String searchQuery) async {
    final db = await database;
    String ssql;
    String where = " WHERE 1=1 ";

    if (lastId != null) {
      if (lastId.isNotEmpty) {
        lastId = lastId.replaceAll("'", "''");
        where += "  AND T0.WhsCode>'${lastId}' ";
      }
    }

    if (searchQuery != null) {
      if (searchQuery.isNotEmpty) {
        searchQuery = searchQuery.replaceAll("'", "''");
        where += " AND ( ";
        where += "  IFNULL(T0.WhsCode,'') LIKE '%${searchQuery}%' OR  ";
        where += "  IFNULL(T0.WhsName,'') LIKE '%${searchQuery}%'   ";
        where += " ) ";
      }
    }

    ssql = 'SELECT * FROM Warehouse T0 ${where}  ORDER BY T0.WhsCode LIMIT 15 ';
    List<Map> mapRawQuery = await db.rawQuery(ssql);
    List<CflDbWarehouseModel> list = new List<CflDbWarehouseModel>.from(
        mapRawQuery.map((x) => new CflDbWarehouseModel(
              whsCode: x["WhsCode"],
              whsName: x["WhsName"] ?? "",
              branchId: x["BranchId"],
              branchName: x["BranchName"],
            )));

    return list;
  }

  Future<List<CflDbWarehouseModel>> cflDbWarehouse_Refresh(
      String lastId, String searchQuery) async {
    lastId = lastId.replaceAll("'", "''");
    searchQuery = searchQuery.replaceAll("'", "''");

    final db = await database;
    String ssql;
    String where = " WHERE 1=1 ";

    if (lastId != null) {
      if (lastId.isNotEmpty) {
        lastId = lastId.replaceAll("'", "''");
        where += "  AND T0.WhsCode>'${lastId}' ";
      }
    }

    if (searchQuery != null) {
      if (searchQuery.isNotEmpty) {
        searchQuery = searchQuery.replaceAll("'", "''");
        where += " AND ( ";
        where += "  IFNULL(T0.WhsCode,'') LIKE '%${searchQuery}%' OR  ";
        where += "  IFNULL(T0.WhsName,'') LIKE '%${searchQuery}%'    ";
        where += " ) ";
      }
    }

    ssql = 'SELECT * FROM Warehouse T0 ${where}   ORDER BY T0.WhsCode';
    List<Map> mapRawQuery = await db.rawQuery(ssql);
    List<CflDbWarehouseModel> list = new List<CflDbWarehouseModel>.from(
        mapRawQuery.map((x) => new CflDbWarehouseModel(
            whsCode: x["WhsCode"],
            whsName: x["WhsName"],
            branchId: x["BranchId"],
            branchName: x["BranchName"])));

    return list;
  }
}
