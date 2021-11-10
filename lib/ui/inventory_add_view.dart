import 'package:flutter/material.dart';
import 'package:toko_manager/ui/home_drawer.dart';

class InventoryAddView extends StatefulWidget {
  InventoryAddView({Key key}) : super(key: key);

  @override
  _InventoryAddViewState createState() => _InventoryAddViewState();
}

class _InventoryAddViewState extends State<InventoryAddView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: Container(
          child: Text('This is Inventory Add View!'),
        ),
      ),
    );
  }
}
