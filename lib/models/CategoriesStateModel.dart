import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:todo_app_flutter/bll/CategoriesState.dart';
import 'package:todo_app_flutter/domain/TodoCategories.dart';
import 'package:todo_app_flutter/services/HttpService.dart';

class CategoriesStateModel extends ChangeNotifier {
  final CategoriesState categoriesState = CategoriesState();
  final HttpService service = HttpService('TodoCategories');

  List<TodoCategories> get value => categoriesState.get();

  CategoriesStateModel(){
    log("test");
  }

  void load() async {
    var res = await service.getAll();
    log(res);
    categoriesState.setJson(res);
    notifyListeners();
    log(value.toString());
  }

  void reorder(int oldIndex, int newIndex) async {
    categoriesState.reorder(oldIndex, newIndex);
    notifyListeners();
    await updateIndex();
  }

  Future updateIndex() async {
    for(var i = 0; i < value.length; i++) {
      var item = value[i];
      item.categorySort = i;
      await service.put(item.id!, jsonEncode(item.toJson()));
    }
    notifyListeners();
  }

  void update(TodoCategories category, bool forceLoad) async {
    await service.put(category.id!, jsonEncode(category.toJson()));
    if (forceLoad) {
      load();
    }
  }

  void delete(int index) async {
    var item = categoriesState.getAt(index);
    await service.delete(item.id!);
    categoriesState.remove(index);
    updateIndex();

  }

  void add(String name) async {
      TodoCategories category = TodoCategories(null, name, value.length, '');
      await service.add(jsonEncode(category.toJsonShort()));
      load();
  }

}