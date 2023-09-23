import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/datamodels.dart';
import '../provider/dataprovider.dart';

class MyAddNewTaskScreen extends StatefulWidget {
  const MyAddNewTaskScreen({super.key});

  @override
  State<MyAddNewTaskScreen> createState() => _MyAddNewTaskScreenState();
}

class _MyAddNewTaskScreenState extends State<MyAddNewTaskScreen> {
  bool firstBuild = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String dropdownValue = 'One Time';
  String selectedCategories = "--------";
  bool isError = false;
  bool isCategorySelected = true;
  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final myCategoriesList = Provider.of<ProviderClass>(context).categories;
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    if (arguments[1] == 1 && firstBuild == true) {
      final MyTasks task = arguments[0];
      titleController.text = task.title;
      descriptionController.text = task.description;
      selectedCategories = task.category;
      dropdownValue = list[task.repeatType];
      firstBuild = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: pageWidth,
        height: pageHeight,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 53),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: pageHeight * 0.1 + 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    style: TextStyle(color: fontColor),
                    cursorColor: themeColor,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: "Write Title",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: isError ? errorColor : fontColorDim),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  isError ? errorColor : Colors.transparent)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        value.isEmpty || value.length > 20
                            ? isError = true
                            : isError = false;
                        return;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 12,
                    ),
                    child: Text(
                      isError ? "Invalid Input" : " ",
                      style: TextStyle(fontSize: 12, color: errorColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: pageHeight * 0.8,
              margin: EdgeInsets.only(left: pageWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Repeat:",
                            style: TextStyle(color: fontColor),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: DropdownButton<String>(
                              focusColor: Colors.transparent,
                              value: dropdownValue,
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "  Select Categories:",
                                  style: TextStyle(color: fontColor),
                                ),
                                Text(
                                  "   Please Select Atleast One Category",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: isCategorySelected == false
                                          ? const Color.fromARGB(
                                              255, 191, 55, 45)
                                          : Colors.transparent),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(children: [
                        for (int i = 0; i < myCategoriesList.length; i++)
                          Container(
                            margin: const EdgeInsets.all(2),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                if (selectedCategories[i] == '-') {
                                  isCategorySelected = true;
                                  selectedCategories =
                                      selectedCategories.substring(0, i) +
                                          i.toString() +
                                          selectedCategories.substring(i + 1);
                                } else {
                                  isCategorySelected = true;
                                  selectedCategories =
                                      '${selectedCategories.substring(0, i)}-${selectedCategories.substring(i + 1)}';
                                }
                                setState(() {});
                              },
                              child: Ink(
                                height: 32,
                                width:
                                    myCategoriesList[i].title.length * 10 + 20,
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 8, right: 8),
                                decoration: BoxDecoration(
                                    color: selectedCategories[i] != '-' &&
                                            int.parse(selectedCategories[i]) ==
                                                i
                                        ? myCategoriesList[i].myColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: selectedCategories[i] == '-'
                                            ? fontColorDim
                                            : myCategoriesList[i].myColor)),
                                child: FittedBox(
                                  child: Text(
                                    myCategoriesList[i].title,
                                    style: TextStyle(
                                        color: selectedCategories[i] != '-' &&
                                                int.parse(selectedCategories[
                                                        i]) ==
                                                    i
                                            ? const Color.fromARGB(
                                                255, 255, 255, 255)
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ]),
                    ],
                  ),
                  Container(
                    width: pageWidth,
                    height: pageHeight * 0.3,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: fontColorDim),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: descriptionController,
                      cursorColor: themeColor,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Description",
                        helperText:
                            "Remaining Words: ${150 - descriptionController.text.length}",
                        helperStyle: TextStyle(
                            // ignore: prefer_is_empty
                            color: descriptionController.text.length >= 0 &&
                                    descriptionController.text.length < 100
                                ? Colors.transparent
                                : descriptionController.text.length >= 100 &&
                                        descriptionController.text.length <= 150
                                    ? fontColorDim
                                    : errorColor),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Ink(
                          width: pageWidth * 0.3,
                          height: pageHeight * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: fontColorDim2)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.keyboard_backspace_rounded,
                                color: fontColorDim2),
                          ),
                        ),
                        Ink(
                          width: pageWidth * 0.4,
                          height: pageHeight * 0.065,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              int repeat = 0;
                              if (titleController.text.isEmpty ||
                                  titleController.text.length > 20) {
                                isError = true;
                                setState(() {});
                                return;
                              } else if (selectedCategories == "--------") {
                                isCategorySelected = false;
                                setState(() {});
                                return;
                              } else if (descriptionController.text.length >
                                  150) {
                                setState(() {});
                                return;
                              }
                              if (descriptionController.text.isEmpty) {
                                descriptionController.text = " ";
                              }
                              for (int i = 0; i < list.length; i++) {
                                if (dropdownValue == list[i]) {
                                  repeat = i;
                                }
                              }
                              if (arguments[1] == 1) {
                                Provider.of<ProviderClass>(context,
                                        listen: false)
                                    .editItem(
                                        MyTasks(
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                          category: selectedCategories,
                                          isCompleted: 0,
                                          isSelected: false,
                                          repeatType: repeat,
                                        ),
                                        arguments[2]);
                                Navigator.of(context).pop();
                                return;
                              }
                              Provider.of<ProviderClass>(context, listen: false)
                                  .addItems(
                                MyTasks(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  category: selectedCategories,
                                  isCompleted: 0,
                                  isSelected: false,
                                  repeatType: repeat,
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Center(
                                child: Text(
                              arguments[1] == 1 ? "Save Changes" : "Add",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
