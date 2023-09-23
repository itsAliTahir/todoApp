import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/datamodels.dart';
import '../provider/dataprovider.dart';

class MyShowTaskDetail extends StatefulWidget {
  final MyTasks task;
  const MyShowTaskDetail(this.task, {super.key});

  @override
  State<MyShowTaskDetail> createState() => _MyShowTaskDetailState();
}

class _MyShowTaskDetailState extends State<MyShowTaskDetail> {
  @override
  Widget build(BuildContext context) {
    final myCategoriesList = Provider.of<ProviderClass>(context).categories;
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: pageHeight * 0.56,
      child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: pageWidth * 0.5 - 20,
                  height: 30,
                  // color: Colors.red,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.task.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                widget.task.isCompleted == 0
                    ? SizedBox(
                        width: pageWidth * 0.125,
                        height: 22,
                        child: FittedBox(
                          child: Text(
                            "Active",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                                fontSize: 16),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: pageWidth * 0.205,
                        height: 22,
                        child: FittedBox(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: fontColorDim,
                                fontSize: 16),
                          ),
                        ),
                      ),
              ]),
              Container(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: [
                    for (int i = 0; i < 8; i++)
                      widget.task.category[i] != "-"
                          ? Container(
                              height: 32,
                              width: myCategoriesList[i].title.length * 10 + 20,
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 8, right: 8),
                              decoration: BoxDecoration(
                                  color: myCategoriesList[i].myColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: FittedBox(
                                child: Text(
                                  myCategoriesList[i].title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : const SizedBox()
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 15,
                  child: Text(
                    list[widget.task.repeatType],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: fontColorDim3),
                  ),
                ),
              ),
              Divider(color: fontColorDim),
              Container(
                height: pageHeight * 0.3 - 70,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.task.description))),
              )
            ],
          )),
    );
  }
}
