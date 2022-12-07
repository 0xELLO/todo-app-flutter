import 'dart:convert';

import 'package:todo_app_flutter/domain/TodoCategories.dart';

class CategoriesState {
  List<TodoCategories> _todoCategories = [];

  void set(List<TodoCategories> state) {
    _todoCategories = state;
    _sort();
  }

  TodoCategories getAt(index) {
    return _todoCategories[index];
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex){
      newIndex -= 1;
    }
    final item = _todoCategories.removeAt(oldIndex);
    _todoCategories.insert(newIndex, item);
  }

  void remove(int index) {
    _todoCategories.removeAt(index);
  }

  void _sort() {
    _todoCategories.sort((a, b) => (a.categorySort < b.categorySort) ? -1 : 1);
  }

  void setJson(String jsonString) {
    Iterable list = jsonDecode(jsonString);
    _todoCategories = List<TodoCategories>.from(list.map((e) => TodoCategories.fromJson(e)));
    _sort();
  }

  List<TodoCategories> get() {
    return _todoCategories;
  }
}