import 'package:flutter/material.dart';
import 'package:item_tracker/core/routers/routes.dart';
import 'package:item_tracker/data/models/navigate_update_model.dart';
import 'package:item_tracker/domain/entities/item.dart';
import 'package:item_tracker/presentation/providers/item_provider.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {

  const AddItemScreen({
    Key? key,
  }): super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool? isUpdate = false;
  int? index;
  Item? item;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setupUpdateItem(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                var newItem = Item(
                  id: UniqueKey().toString(), // Generate unique ID
                  name: _nameController.text.trim(),
                  description: _descriptionController.text.trim(),
                );

                switch(isUpdate){
                  case true:
                    updateItem();
                  case false:
                    addItem();
                  case null:
                }

                AppNavigator.instance.goBack(); // Return to previous screen
              }
            },
            child: Text(isUpdate ?? false ? 'Update' :'Add'),
          ),
        ],
      ),
    );
  }

  setupUpdateItem(BuildContext context){
    try{
      NavigateUpdateModel otpParamModel = ModalRoute.of(context)!.settings.arguments as NavigateUpdateModel;
      if(otpParamModel != null){
        isUpdate = true;
        item = otpParamModel.item;
        index = otpParamModel.index;
        _nameController.text = otpParamModel.item?.name ?? '';
        _descriptionController.text = otpParamModel.item?.description ?? '';
      }
    } catch(e){
      isUpdate = false;
    }
  }

  void addItem(){
    var newItem = Item(
      id: UniqueKey().toString(), // Generate unique ID
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    Provider.of<ItemProvider>(context, listen: false).addItem(newItem);
  }

  void updateItem(){
    var updateItem = Item(
      id: item?.id ?? '',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    Provider.of<ItemProvider>(context, listen: false).updateItem(updateItem, index ?? 0);
  }

}