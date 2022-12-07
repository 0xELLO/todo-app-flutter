import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/components/AddButton.dart';
import 'package:todo_app_flutter/domain/TodoCategories.dart';
import 'package:todo_app_flutter/models/CategoriesStateModel.dart';
import 'package:todo_app_flutter/screens/PriorityScreen.dart';

import '../models/AuthStateModel.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<TodoCategories> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesStateModel>(context, listen: false).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    _items = Provider.of<CategoriesStateModel>(context).value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories " + Provider.of<AuthStateModel>(context).value.toString()),
      ),
      body: Stack(
        children: [ReorderableListView(
        onReorder: (int oldIndex, int newIndex) => {Provider.of<CategoriesStateModel>(context, listen: false).reorder(oldIndex, newIndex)},
        children: _getListItems(),
      ),
      AddButtonWidget(addButton: (addButton))]),
    );
  }

  void addButton(String name){
    Provider.of<CategoriesStateModel>(context, listen: false).add(name);
  }

  void onReorder(int oldIndex, int newIndex) {
    Provider.of<CategoriesStateModel>(context).reorder(oldIndex, newIndex);
  }

  List<Widget> _getListItems() => _items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(TodoCategories item, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          Provider.of<CategoriesStateModel>(context, listen: false).delete(index);
        });
      },
      background: Container(color: Colors.red),
      child: ListTile(
        key: ValueKey(item.id!),
        title: Text(
          '${item.categoryName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${item.categorySort}',
          style: TextStyle(
          ),
        ),
        onTap: () {Navigator.push(context, MaterialPageRoute(builder: ((context) => PriorityScreen(categoryId: item.id!))));},
      ),
    );
  }
}