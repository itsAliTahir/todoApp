import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/constants.dart';
import 'package:todolist_app/provider/dataprovider.dart';
import '../helper/databasehelper.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1, milliseconds: 400)).then((value) {
      Navigator.of(context).pushNamed("/homescreen");
    });
  }

  int buildScreen = 1;
  @override
  Widget build(BuildContext context) {
    if (buildScreen == 1) {
      Provider.of<ProviderClass>(context).initializeList();
      buildScreen++;
    }
    // done apps
    DatabaseHelper.instance.getData();
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: themeColor),
            child: Center(
              child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "ToDo App",
                        style: TextStyle(
                            color: fontColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Pacifico"),
                      ))
                    ]),
              ),
            )));
  }
}
