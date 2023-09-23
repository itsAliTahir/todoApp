import 'package:flutter/material.dart';
import '../constants.dart';
import '../helper/databasehelper.dart';
import '../models/datamodels.dart';

class ProviderClass with ChangeNotifier {
  int selectedMethod = -1;
  final List<MyTasks> _myTasksList = [
    // MyTasks(
    //     title: "Dentist appointment",
    //     description: " ",
    //     category: "-1------",
    //     isCompleted: 1,
    //     isSelected: false,
    //     repeatType: 0),
    // MyTasks(
    //     title: "Groceries",
    //     description: "Pasta Sauce, Noodles, Milk,",
    //     category: "---3----",
    //     isCompleted: 0,
    //     isSelected: false,
    //     repeatType: 0),
    // MyTasks(
    //     title: "Meeting with client",
    //     description: "2:00 PM in the Office",
    //     category: "----456-",
    //     isCompleted: 0,
    //     isSelected: false,
    //     repeatType: 1),
    // MyTasks(
    //     title: "Gym",
    //     description: "At 8:30 PM",
    //     category: "-12-----",
    //     isCompleted: 0,
    //     isSelected: false,
    //     repeatType: 1),
  ];

  final List<Categories> _myCategoriesList = [
    Categories("Work", false, itemColor1, 0),
    Categories("Health", false, itemColor2, 0),
    Categories("Personal", false, itemColor3, 0),
    Categories("Shopping", false, itemColor4, 0),
    Categories("Travel", false, itemColor5, 0),
    Categories("Social", false, itemColor6, 0),
    Categories("Others", false, itemColor7, 0),
  ];

  List<MyTasks> get tasks {
    _myTasksList.sort((a, b) => a.isCompleted.compareTo(b.isCompleted));
    return [..._myTasksList];
  }

  List<Categories> get categories {
    return [..._myCategoriesList];
  }

  Future<void> initializeList() async {
    try {
      List<MyTasks> tempList = await DatabaseHelper.instance.getData();
      for (int i = 0; i < tempList.length; i++) {
        _myTasksList.add(tempList[i]);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Couldn't Fetch Data");
    }
  }

  addItems(MyTasks inputItems) {
    //
    _myTasksList.add(inputItems);
    DatabaseHelper.instance.addIntoDatabase(inputItems);
    notifyListeners();
    //
  }

  void updateItem(MyTasks inputItems, int index) {
    for (int i = 0; i < _myTasksList.length; i++) {
      _myTasksList[i].isSelected = false;
    }
    _myTasksList[index].isCompleted = inputItems.isCompleted;
    _myTasksList[index].isSelected = inputItems.isSelected;
    notifyListeners();
  }

  void editItem(MyTasks inputItems, int index) {
    DatabaseHelper.instance.updateDatabase(_myTasksList[index], inputItems);
    _myTasksList[index] = inputItems;
    notifyListeners();
  }

  void deleteItem(int index) {
    DatabaseHelper.instance.deleteFromDatabase(_myTasksList[index]);
    _myTasksList.removeAt(index);
    notifyListeners();
  }

  int countCategories() {
    int tasksLeft = 0;
    for (int i = 0; i < _myCategoriesList.length; i++) {
      _myCategoriesList[i].quantity = 0;
    }

    for (int i = 0; i < _myTasksList.length; i++) {
      if (_myTasksList[i].isCompleted == 0) {
        tasksLeft++;
      }
      for (int j = 0; j < _myCategoriesList.length; j++) {
        for (int k = 0; k < _myTasksList[i].category.length; k++) {
          if (_myTasksList[i].category[k] != "-") {
            if (int.parse(_myTasksList[i].category[k]) == j) {
              _myCategoriesList[j].quantity++;
            }
          }
        }
      }
    }
    return tasksLeft;
  }

  void selectCategory(int index) {
    for (int i = 0; i < _myTasksList.length; i++) {
      _myTasksList[i].isSelected = false;
    }
    if (index == -2) {
      for (int i = 0; i < _myCategoriesList.length; i++) {
        _myCategoriesList[i].isSelected = false;
      }
      selectedMethod = -1;
      notifyListeners();
      return;
    }
    if (_myCategoriesList[index].isSelected == true) {
      _myCategoriesList[index].isSelected = false;
      selectedMethod = -1;
      notifyListeners();
      return;
    }
    for (int i = 0; i < _myCategoriesList.length; i++) {
      _myCategoriesList[i].isSelected = false;
    }
    _myCategoriesList[index].isSelected = true;
    selectedMethod = index;
    notifyListeners();
    return;
  }

  void khali() {}
}
