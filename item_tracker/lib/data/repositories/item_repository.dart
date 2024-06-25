import 'package:item_tracker/core/database_helper/database_helper.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:sqflite/sqflite.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> addItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(Item item);
}

class ItemRepositoryImpl implements ItemRepository {
  final dbHelper = DatabaseHelper();

  @override
  Future<void> addItem(Item item) async {
    // TODO: implement addItem
    final db = await dbHelper.database;
    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteItem(Item item) async {
    // TODO: implement deleteItem
    final db = await dbHelper.database;
    await db.delete(
      'items',
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  @override
  Future<List<Item>> getItems() async {
    // TODO: implement getItems
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
      );
    });
  }

  @override
  Future<void> updateItem(Item item) async {
    // TODO: implement updateItem
    final db = await dbHelper.database;
    await db.update(
      'items',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }
}