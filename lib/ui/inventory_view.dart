import 'package:flutter/material.dart';
import 'package:toko_manager/ui/home_drawer.dart';

class InventoryView extends StatefulWidget {
  InventoryView({Key key}) : super(key: key);

  @override
  _InventoryViewState createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: Container(
          child: Text('This is Inventory view!'),
        ),
      ),
    );
  }
}
