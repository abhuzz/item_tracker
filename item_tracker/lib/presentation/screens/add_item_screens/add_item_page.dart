import 'package:flutter/material.dart';
import 'package:item_tracker/data/models/navigate_update_model.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:item_tracker/presentation/screens/add_item_screens/add_item_screen.dart';

class AddItemPage extends StatelessWidget {

  const AddItemPage({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AddItemScreen(),
      ),
    );
  }

}