import 'dart:collection';

import 'package:flutter/cupertino.dart';


// Category Model
class Category {
  
  Category({
   this.isSelected = false,
   this.title,
});
  
  final String title;
  bool isSelected;
}

//This provides the
class Categories extends ChangeNotifier {
  List<Category> allCategories = [
    Category(title: 'My Day', isSelected: true),
    Category(title: 'Important'),
    Category(title: 'Planned'),
  ];


  // Return an immutable version of the allCategories list
  UnmodifiableListView<Category> get categories {
    return UnmodifiableListView(allCategories);
  }

  // Make a category button selected or not
  void setSelectStatus(Category category, bool selected){
    category.isSelected = selected;
    notifyListeners();
  }

  // Set the isSelected property of all items in the allCategories list false
  void deselectAllCategories(){
    allCategories.forEach((element) {element.isSelected = false;});
    notifyListeners();
  }


  // Returns the length of the allCategories list
  int get categoryCount {
    return allCategories.length;
  }
}