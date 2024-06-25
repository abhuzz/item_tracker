import 'package:flutter/material.dart';
import 'package:item_tracker/presentation/screens/item_list_screens/item_list_screen.dart';

class ItemListPage extends StatelessWidget {
  static String tag = '/';
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: const ItemListScreen(),
    );
  }
}