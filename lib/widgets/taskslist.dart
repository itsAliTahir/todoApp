import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/datamodels.dart';
import '../provider/dataprovider.dart';

// ignore: must_be_immutable
class MyTasksList extends StatefulWidget {
  Function bottomDialogue;
  Function editTask;
  MyTasksList(this.bottomDialogue, this.editTask, {super.key});

  @override
  State<MyTasksList> createState() => _MyTasksListState();
}

class _MyTasksListState extends State<MyTasksList> {
  @override
  Widget build(BuildContext context) {
    final myTasksList = Provider.of<ProviderClass>(context).tasks;

    final int selectedMethod =
        Provider.of<ProviderClass>(context).selectedMethod;
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: pageWidth,
      height: (pageHeight * 0.57) - 18,
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return selectedMethod == -1 ||
                    (myTasksList[index].category[selectedMethod] != "-" &&
                        selectedMethod ==
                            int.parse(
                                myTasksList[index].category[selectedMethod]))
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    width: pageWidth - 68,
                    height: 70,
                    child: Card(
                      elevation: 1,
                      child: Ink(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          onLongPress: () {
                            Provider.of<ProviderClass>(context, listen: false)
                                .updateItem(
                                    MyTasks(
                                        title: " ",
                                        category: " ",
                                        description: " ",
                                        isCompleted:
                                            myTasksList[index].isCompleted,
                                        isSelected:
                                            !myTasksList[index].isSelected,
                                        repeatType: 0),
                                    index);
                          },
                          onTap: () {
                            if (myTasksList[index].isSelected == true) {
                              Provider.of<ProviderClass>(context, listen: false)
                                  .updateItem(
                                      MyTasks(
                                          category: " ",
                                          description: " ",
                                          title: " ",
                                          isCompleted:
                                              myTasksList[index].isCompleted,
                                          isSelected: false,
                                          repeatType: 0),
                                      index);
                              return;
                            }
                            widget.bottomDialogue(myTasksList[index]);
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, bottom: 5, right: 5),
                                child: AnimatedContainer(
                                  // color: Colors.red,
                                  duration: const Duration(milliseconds: 200),
                                  width: myTasksList[index].isSelected == true
                                      ? pageWidth - 42 - 100
                                      : pageWidth - 42,
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, top: 0),
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: myTasksList[index]
                                                              .isCompleted ==
                                                          1
                                                      ? fontColorDim
                                                      : themeColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: myTasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? fontColorDim
                                                  : Colors.white),
                                          child: InkWell(
                                            onTap: () {
                                              if (myTasksList[index]
                                                      .isCompleted ==
                                                  1) {
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .updateItem(
                                                        MyTasks(
                                                            title: " ",
                                                            description: " ",
                                                            category:
                                                                myTasksList[
                                                                        index]
                                                                    .category,
                                                            isCompleted: 0,
                                                            isSelected:
                                                                myTasksList[
                                                                        index]
                                                                    .isSelected,
                                                            repeatType: 0),
                                                        index);
                                              } else {
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .updateItem(
                                                        MyTasks(
                                                            title: " ",
                                                            description: " ",
                                                            category:
                                                                myTasksList[
                                                                        index]
                                                                    .category,
                                                            isCompleted: 1,
                                                            isSelected:
                                                                myTasksList[
                                                                        index]
                                                                    .isSelected,
                                                            repeatType: 0),
                                                        index);
                                              }
                                            },
                                            child: const Icon(
                                              Icons.check,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          left: 60,
                                          child: Text(
                                            myTasksList[index].title,
                                            style: TextStyle(
                                              color: myTasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? fontColorDim
                                                  : fontColorDim2,
                                              fontWeight: FontWeight.bold,
                                              decoration: myTasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                          )),
                                      Positioned(
                                          top: 27,
                                          left: 62,
                                          child: Text(
                                            myTasksList[index].description,
                                            style: TextStyle(
                                              color: fontColorDim,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              decoration: myTasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: myTasksList[index].isSelected == true
                                      ? 100
                                      : 0,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        bottomRight: Radius.circular(4)),
                                  ),
                                  child: Stack(
                                    children: [
                                      myTasksList[index].isCompleted == 0
                                          ? GestureDetector(
                                              onTap: () {
                                                widget.editTask(
                                                    myTasksList[index],
                                                    1,
                                                    index);
                                              },
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 0),
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45)),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.edit_note,
                                                    color: myTasksList[index]
                                                                .isSelected ==
                                                            true
                                                        ? Colors.black
                                                        : Colors.transparent,
                                                  )),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<ProviderClass>(context,
                                                  listen: false)
                                              .deleteItem(index);
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(45)),
                                            child: Center(
                                                child: Icon(
                                              Icons.delete_forever,
                                              color: myTasksList[index]
                                                          .isSelected ==
                                                      true
                                                  ? Colors.black
                                                  : Colors.transparent,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
          itemCount: myTasksList.length),
    );
  }
}
