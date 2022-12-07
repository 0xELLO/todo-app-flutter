class TodoCategories {
  final String? id;
  final String categoryName;
  int categorySort;
  final String? syncDate;

  TodoCategories(this.id, this.categoryName, this.categorySort, this.syncDate);

  TodoCategories.fromJson(Map<String, dynamic> json)
   :id =  json['id'],
    categoryName = json['categoryName'],
    categorySort = json['categorySort'],
    syncDate = json['syncDate'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryName': categoryName,
    'categorySort': categorySort,
    'syncDate' : syncDate
  };

    Map<String, dynamic> toJsonShort() => {
    'categoryName': categoryName,
    'categorySort': categorySort,
    'syncDate' : syncDate
  };


}