import 'package:flutter/material.dart';
import 'package:item_tracker/core/routers/routes.dart';
import 'package:item_tracker/data/models/navigate_update_model.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:item_tracker/domain/usecases/item_usecase.dart';
import 'package:item_tracker/presentation/providers/item_provider.dart';
import 'package:item_tracker/presentation/screens/add_item_screens/add_item_page.dart';
import 'package:item_tracker/presentation/screens/item_list_screens/widgets/list_card_widget.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<Item> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.instance
              .navigateTo('/add-item');
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Item>>(
        future: itemProvider.getItem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListCardWidget(
                  item: item,
                  itemProvider:itemProvider,
                  index: index,
                  updateFunc: (){
                    updateFunction(index,item);
                  },);
              },
            );
          }
        },
      ),
    );
  }

  updateFunction(int index,Item item){
    NavigateUpdateModel paramModel = NavigateUpdateModel();
      paramModel.item = item;
      paramModel.index = index;

    AppNavigator.instance
        .navigateTo('/add-item', arguments: paramModel);

  }
}