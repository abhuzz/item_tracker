import 'package:flutter/material.dart';
import 'package:item_tracker/data/models/navigate_update_model.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:item_tracker/presentation/providers/item_provider.dart';

class ListCardWidget extends StatelessWidget {
  final Item item;
  final ItemProvider itemProvider;
  final int index;
  final Function() updateFunc;
  const ListCardWidget({required this.item,required this.itemProvider,required this.index,required this.updateFunc,super.key,});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Colors.purpleAccent, width: 2),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: updateFunc,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                itemProvider.deleteItem(item);
              },
            ),
          )
        ],
      ),
    );
  }
}
