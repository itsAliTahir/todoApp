import 'package:flutter/material.dart';

class MyTasks {
  String title;
  String description;
  String category;
  int isCompleted; // 0 = false, 1 = true
  bool isSelected;
  int repeatType; // 0 = one time, 1 = daily, 2 = weekdays, 3 = weekend
  MyTasks(
      {required this.title,
      required this.description,
      required this.category,
      required this.isCompleted,
      required this.isSelected,
      required this.repeatType});

  factory MyTasks.fromMap(Map<String, dynamic> json) => MyTasks(
        title: json['Title'],
        description: json['Description'],
        category: json['Category'],
        isCompleted: json['isCompleted'],
        isSelected: false,
        repeatType: json['Repeat'],
      );

  Map<String, dynamic> toMap() {
    return {
      'Title': title,
      'Description': description,
      'Category': category,
      'isCompleted': isCompleted,
      'Repeat': repeatType,
    };
  }
}

class Categories {
  String title;
  bool isSelected;
  Color myColor;
  int quantity;
  Categories(
    this.title,
    this.isSelected,
    this.myColor,
    this.quantity,
  );
}

List<String> list = <String>['One Time', 'Daily', 'Weekdays', 'Weekend'];
