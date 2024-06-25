import 'package:item_tracker/data/repositories/item_repository.dart';
import 'package:item_tracker/domain/entities/item.dart';

class ItemUseCase {
  final ItemRepository repository;

  ItemUseCase(this.repository);


  Future<List<Item>> getItems() async {
    return await repository.getItems();
  }

  Future<void> addItem(Item item) async {
    try {
      await repository.addItem(item);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      await repository.deleteItem(item);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      await repository.updateItem(item);
    } catch (e) {
      rethrow;
    }
  }

}