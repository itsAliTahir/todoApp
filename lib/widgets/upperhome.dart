import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/models/datamodels.dart';
import '../constants.dart';
import '../provider/dataprovider.dart';

// ignore: must_be_immutable
class MyUpperHome extends StatefulWidget {
  Function addNewTaskScreen;
  MyUpperHome(this.addNewTaskScreen, {super.key});

  @override
  State<MyUpperHome> createState() => _MyUpperHomeState();
}

class _MyUpperHomeState extends State<MyUpperHome>
    with SingleTickerProviderStateMixin {
  int selectedMethod = -1;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTasksList = Provider.of<ProviderClass>(context).tasks;
    final myCategoriesList = Provider.of<ProviderClass>(context).categories;
    final tasksLeft = Provider.of<ProviderClass>(context).countCategories();

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    // ignore: non_constant_identifier_names
    Widget CategoryBox(
      int index,
      Alignment myAlignment,
      IconData? myIcon,
    ) {
      return Align(
        alignment: myAlignment,
        child: Container(
          margin: const EdgeInsets.all(2),
          // color: Colors.green,
          width: pageWidth * 0.35,
          height: pageHeight * 0.092,
          child: Card(
            color: myCategoriesList[index].isSelected == true
                ? myCategoriesList[index].myColor
                : Colors.white,
            elevation: 2,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: myCategoriesList[index].isSelected == true
                  ? Colors.white
                  : myCategoriesList[index].myColor,
              onTap: () {
                Provider.of<ProviderClass>(context, listen: false)
                    .selectCategory(index);
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          myIcon,
                          size: 40,
                          color: const Color.fromARGB(93, 255, 255, 255),
                        )),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: myCategoriesList[index].isSelected == false
                            ? myCategoriesList[index].myColor
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        myCategoriesList[index].title,
                        style: TextStyle(
                            color: myCategoriesList[index].isSelected == true
                                ? fontColor
                                : fontColorDim2,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      top: 27,
                      left: 12,
                      child: Text(
                        myCategoriesList[index].quantity > 1
                            ? "${myCategoriesList[index].quantity} Tasks"
                            : "${myCategoriesList[index].quantity} Task",
                        style: TextStyle(
                            color: myCategoriesList[index].isSelected == true
                                ? fontColorDim2
                                : fontColorDim,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: pageWidth,
      height: (pageHeight * 0.44) - 8,
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Positioned(
            top: 55,
            right: 30,
            child: Hero(
              tag: "addButton",
              child: Ink(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    splashColor: const Color.fromARGB(255, 185, 16, 72),
                    onTap: () {
                      Provider.of<ProviderClass>(context, listen: false)
                          .selectCategory(-2);
                      widget.addNewTaskScreen(
                          MyTasks(
                              title: " ",
                              category: " ",
                              description: " ",
                              isCompleted: 0,
                              isSelected: false,
                              repeatType: 0),
                          0,
                          -1);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 40,
              ),
              width: pageWidth * 0.7,
              height: pageHeight * 0.13,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Hey User",
                        style: TextStyle(
                            fontFamily: "TiltNeon",
                            color: fontColorDim2,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                      child: Text(
                        "You have $tasksLeft tasks remaining",
                        style: TextStyle(
                          color: fontColorDim,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: pageWidth * 0.7,
              height: pageHeight * 0.29,
              margin: EdgeInsets.only(
                left: pageWidth * 0.1,
              ),
              // color: Colors.red,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    // color: Colors.green,
                    width: pageWidth * 0.33,
                    height: pageHeight * 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          myTasksList.length.toString(),
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Total Tasks",
                          style: TextStyle(
                            color: fontColorDim,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(5),
                    // color: Colors.green,
                    width: pageWidth * 0.33,
                    height: pageHeight * 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tasksLeft.toString(),
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tasks Left",
                          style: TextStyle(
                            color: fontColorDim,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: pageHeight * 0.085,
                    child: SizedBox(
                        width: pageWidth * 0.7,
                        height: 5,
                        child: Divider(
                          color: fontColorDim,
                        ))),
                DefaultTabController(
                  length: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: pageWidth * 0.7,
                      height: (pageHeight * 0.29) * (2 / 3) + 10,
                      child: Column(
                        children: [
                          SizedBox(
                              width: pageWidth * 0.7,
                              height: (pageHeight * 0.29) * (2 / 3),
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: SizedBox(
                                        // color: Colors.red,
                                        width: pageWidth * 0.7,
                                        height: (pageHeight * 0.29) * (2 / 3),
                                        child: Stack(children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: CategoryBox(
                                                0,
                                                Alignment.centerLeft,
                                                Icons.work_outline_rounded),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CategoryBox(
                                                1,
                                                Alignment.centerRight,
                                                Icons
                                                    .health_and_safety_outlined),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: CategoryBox(
                                                2,
                                                Alignment.bottomLeft,
                                                Icons.person_outline_rounded),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CategoryBox(
                                                3,
                                                Alignment.bottomRight,
                                                Icons.shopping_cart_outlined),
                                          ),
                                        ])),
                                  ),
                                  SingleChildScrollView(
                                    child: SizedBox(
                                        // color: Colors.red,
                                        width: pageWidth * 0.7,
                                        height: (pageHeight * 0.29) * (2 / 3),
                                        child: Stack(children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: CategoryBox(
                                                4,
                                                Alignment.centerLeft,
                                                Icons.train_outlined),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: CategoryBox(
                                                5,
                                                Alignment.centerRight,
                                                Icons.group_outlined),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: CategoryBox(
                                                6,
                                                Alignment.bottomLeft,
                                                Icons.linear_scale_rounded),
                                          ),
                                          // Positioned(
                                          //   bottom: 0,
                                          //   right: 0,
                                          //   child: CategoryBox(
                                          //       7,
                                          //       Alignment.bottomRight,
                                          //       Icons.linear_scale_rounded),
                                          // ),
                                        ])),
                                  ),
                                ],
                              )),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              children: [
                                Container(
                                  width: 20,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: fontColorDim,
                                      )),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 10,
                                  child: TabBar(
                                    padding: const EdgeInsets.all(0),
                                    indicator: BoxDecoration(
                                        color: fontColorDim,
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    controller: tabController,
                                    tabs: const [SizedBox(), SizedBox()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
