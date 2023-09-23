import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/datamodels.dart';
import '../widgets/showtaskdetails.dart';
import '../widgets/taskslist.dart';
import '../widgets/upperhome.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    void bottomDialogue(MyTasks task) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) {
            return MyShowTaskDetail(task);
          });
    }

    void addNewTaskScreen(MyTasks task, int type, int index) {
      Navigator.pushNamed(context, '/addnewtaskscreen',
          arguments: [task, type, index]);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: pageWidth,
        height: pageHeight,
        child: Column(
          children: [
            MyUpperHome(addNewTaskScreen),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.065, vertical: 0),
              child: Divider(
                color: fontColorDim,
              ),
            ),
            MyTasksList(bottomDialogue, addNewTaskScreen),
          ],
        ),
      ),
    );
  }
}
