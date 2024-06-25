import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:item_tracker/domain/usecases/item_usecase.dart';

class ItemProvider extends ChangeNotifier {
  final ItemUseCase itemUseCase;

  ItemProvider(this.itemUseCase);

  List<Item> _items = [];

  List<Item> get items => _items;

  Future<void> addItem(Item item) async {
    try {
      await itemUseCase.addItem(item);
      _items.add(item);
      notifyListeners();
    } catch (e) {
      print('Failed to add item: $e');
    }
  }

  Future<void> updateItem(Item item,int index) async {
    try {
      await itemUseCase.updateItem(item);
      _items.replaceRange(index, index, [item]);
      notifyListeners();
    } catch (e) {
      print('Failed to add item: $e');
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      await itemUseCase.deleteItem(item);
      _items.remove(item);
      notifyListeners();
    } catch (e) {
      print('Failed to delete item: $e');
    }
  }

  Future<List<Item>> getItem() async {
    _items = await itemUseCase.getItems();
    return _items;
  }

}
