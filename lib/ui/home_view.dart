import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toko_manager/ui/home_drawer.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: Container(
          child: Text('This is Home View!'),
        ),
      ),
    );
  }
}
